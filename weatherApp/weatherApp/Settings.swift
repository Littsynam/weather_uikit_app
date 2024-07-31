//
//  Settings.swift
//  weatherApp
//
//  Created by Mastery on 24.07.2024.
//
import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var settingTxtField: UITextField!
    @IBAction func actionButtonTap(_ sender: Any) {
        var city = settingTxtField.text ?? ""
        let userDefaults = UserDefaults.standard
        userDefaults.set(city, forKey: "city")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var savedCity = UserDefaults.standard.string(forKey: "city")
        settingTxtField.text = savedCity
        
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }
    var cityes = ["Karaganda", "Astana"]
    
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cityes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cityCellID", for: indexPath)
        let city = cityes[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let city = cityes[indexPath.row]
        let userDefaults = UserDefaults.standard
        userDefaults.set(city, forKey: "city")
        settingTxtField.text = city
    }
}
