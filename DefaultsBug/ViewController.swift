import UIKit

public enum Feature: String, Codable {
    case dynamicHome
    case devTools
}

public enum Onboarding: String, Codable {
    case global, profile
}


@objc public class UserSettings: NSObject, Codable {

//    @objc public var dailyReminderTime: TimeOfDay?
    @objc public var didAskForAppStoreReview: Bool = false
    @objc public var lastChecklistRewardDate: Date?
    @objc public var lastLoginDate: Date?
    @objc public var nextDateToAskForAppStoreReview: Date?
    @objc public var didAskPermissionForStepsData: Bool = false
    @objc public var didReceiveStepsData: Bool = false
    @objc public var didTurnOnStepsData: Bool = false

    public var enabledFeatures: Set<Feature> = []
}


@objc public class DeviceSettings: NSObject, Codable {
    public var activeAccountID: Int64?
    public var installationId: Int64?

    public var apnsToken: String?
//    public var notificationCapabilities: NotificationCapabilities?
    public var viewedOnboardings: Set<Onboarding> = []
    public var userSettings: UserSettings?

    public override init() {}
}


class ViewController: UIViewController {
    @IBOutlet weak var button: UIButton!
    let userDefaults = UserDefaults.standard
    var deviceSettings: DeviceSettings!

    override func viewDidLoad() {
        super.viewDidLoad()
        read()
    }

    func read() {
        deviceSettings = existingSettings()
        let viewedOnboarding = deviceSettings.viewedOnboardings.contains(.global)
        button.setTitle(viewedOnboarding ? "onboarding seen" : "onboarding not seen", for: .normal)
    }

    @IBAction func change(_ sender: Any) {
        if deviceSettings.viewedOnboardings.contains(.global) {
            deviceSettings.viewedOnboardings.remove(.global)
        } else {
            deviceSettings.viewedOnboardings.insert(.global)
        }
        let encoded = try! JSONEncoder().encode(deviceSettings)
        let jsonDictionary = try! JSONSerialization.jsonObject(with: encoded, options: [])
        userDefaults.set(jsonDictionary, forKey: "DeviceSettings")
        if userDefaults.synchronize() {
            read()
        }
    }

    private func existingSettings() -> DeviceSettings {
        if let jsonDictionary = userDefaults.dictionary(forKey: "DeviceSettings"),
            let encoded = try? JSONSerialization.data(withJSONObject: jsonDictionary, options: []),
            let decoded = try? JSONDecoder().decode(DeviceSettings.self, from: encoded) {
            return decoded
        } else {
            return DeviceSettings()
        }
    }
}

