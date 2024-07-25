//
//  Settings.swift
//  weatherApp
//
//  Created by Mastery on 24.07.2024.
//
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingTxtField: UITextField!
    @IBAction func actionButtonTap(_ sender: Any) {
        var city = settingTxtField.text ?? ""
        let userDefaults = UserDefaults.standard
        userDefaults.set(city, forKey: "city")
    }
}
