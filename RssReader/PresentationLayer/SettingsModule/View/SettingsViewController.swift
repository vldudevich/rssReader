//
//  ViewController.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol SaveStateCategoriesDelegate {
    func saveSettings(for list: [String])
}

class SettingsViewController: UIViewController {
    
    @IBOutlet private weak var allCategorySwitch: UISwitch!
    @IBOutlet private weak var agileCategorySwitch: UISwitch!
    @IBOutlet private weak var AICategorySwitch: UISwitch!
    @IBOutlet private weak var bigDataCategorySwitch: UISwitch!
    @IBOutlet private weak var cloudCategorySwitch: UISwitch!
    @IBOutlet private weak var dataBaseCategorySwitch: UISwitch!
    @IBOutlet private weak var devOpsCategorySwitch: UISwitch!
    @IBOutlet private weak var integrationCategorySwitch: UISwitch!
    @IBOutlet private weak var IOTCategorySwitch: UISwitch!
    @IBOutlet private weak var javaCategorySwitch: UISwitch!
    @IBOutlet private weak var microServicesCategorySwitch: UISwitch!
    @IBOutlet private weak var openSourceCategorySwitch: UISwitch!
    @IBOutlet private weak var perfomanceCategorySwitch: UISwitch!
    @IBOutlet private weak var securityCategorySwitch: UISwitch!
    @IBOutlet private weak var webDevCategorySwitch: UISwitch!
    
    var output: SettingsViewOutput!
    var bufTopicLists = [String]()
    var topicLists = [String]()
    var delegate: SaveStateCategoriesDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewOnDidLoad()
    }
    
    @IBAction private func saveConfigurationTouchUpInside(_ sender: Any) {
        if topicLists.count != 0 {
            self.dismiss(animated: true, completion: nil)
        } else {
            var alertController = UIAlertController()
            alertController = UIAlertController(title: "Error", message: "You need to choose at least 1 topic", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
            delegate.saveSettings(for: topicLists)
        }
    }
    
    @IBAction private func saveStateSwitch(_ sender: UISwitch) {
        switch sender {
            
        case allCategorySwitch: changeAllCategoryToList(value: allCategorySwitch.isOn)
        case agileCategorySwitch: changeCategoryToList(value: agileCategorySwitch.isOn, nameCategory: TopicThemes.agile.rawValue)
        case AICategorySwitch: changeCategoryToList(value: AICategorySwitch.isOn, nameCategory: TopicThemes.AI.rawValue)
        case bigDataCategorySwitch: changeCategoryToList(value: bigDataCategorySwitch.isOn, nameCategory: TopicThemes.bigData.rawValue)
        case cloudCategorySwitch: changeCategoryToList(value: cloudCategorySwitch.isOn, nameCategory: TopicThemes.cloud.rawValue)
        case dataBaseCategorySwitch: changeCategoryToList(value: dataBaseCategorySwitch.isOn, nameCategory: TopicThemes.dataBase.rawValue)
        case devOpsCategorySwitch: changeCategoryToList(value: devOpsCategorySwitch.isOn, nameCategory: TopicThemes.devOps.rawValue)
        case integrationCategorySwitch: changeCategoryToList(value: integrationCategorySwitch.isOn, nameCategory: TopicThemes.integration.rawValue)
        case IOTCategorySwitch: changeCategoryToList(value: IOTCategorySwitch.isOn, nameCategory: TopicThemes.IOT.rawValue)
        case javaCategorySwitch: changeCategoryToList(value: javaCategorySwitch.isOn, nameCategory: TopicThemes.java.rawValue)
        case microServicesCategorySwitch: changeCategoryToList(value: microServicesCategorySwitch.isOn, nameCategory: TopicThemes.microServices.rawValue)
        case openSourceCategorySwitch: changeCategoryToList(value: openSourceCategorySwitch.isOn, nameCategory: TopicThemes.openSource.rawValue)
        case perfomanceCategorySwitch: changeCategoryToList(value: perfomanceCategorySwitch.isOn, nameCategory: TopicThemes.openSource.rawValue)
        case securityCategorySwitch: changeCategoryToList(value: securityCategorySwitch.isOn, nameCategory: TopicThemes.security.rawValue)
        case webDevCategorySwitch: changeCategoryToList(value: webDevCategorySwitch.isOn, nameCategory: TopicThemes.webDev.rawValue)
            
        default:
            return
        }
        
    }
}
extension SettingsViewController: SettingsViewInput {
    func setupState() {
        self.title = "Zones to Subscrtibe"
        
        allCategorySwitch.isOn = true
        lockOtherSwitches()
    }
}

private extension SettingsViewController {
    
    func changeAllCategoryToList(value: Bool) {
        value ? lockOtherSwitches() : unlockOtherSwitches()
    }
    
    func changeCategoryToList(value: Bool, nameCategory: String) {
        value ? addToList(nameCategory: nameCategory) : removeFromList(nameCategory: nameCategory)
    }
    
    func removeFromList(nameCategory: String) {
        let index = topicLists.firstIndex(of: nameCategory)
        topicLists.remove(at: index!)
    }
    
    func addToList(nameCategory: String) {
        topicLists.append(nameCategory)
    }
    
    func unlockOtherSwitches() {
        
        topicLists.removeAll()
        topicLists = bufTopicLists
        
        agileCategorySwitch.isEnabled = true
        AICategorySwitch.isEnabled = true
        bigDataCategorySwitch.isEnabled = true
        cloudCategorySwitch.isEnabled = true
        dataBaseCategorySwitch.isEnabled = true
        devOpsCategorySwitch.isEnabled = true
        integrationCategorySwitch.isEnabled = true
        IOTCategorySwitch.isEnabled = true
        javaCategorySwitch.isEnabled = true
        microServicesCategorySwitch.isEnabled = true
        openSourceCategorySwitch.isEnabled = true
        perfomanceCategorySwitch.isEnabled = true
        securityCategorySwitch.isEnabled = true
        webDevCategorySwitch.isEnabled = true
    }
    func lockOtherSwitches() {
        
        bufTopicLists = topicLists
        topicLists.removeAll()
        topicLists.append(TopicThemes.all.rawValue)
        
        agileCategorySwitch.isEnabled = false
        AICategorySwitch.isEnabled = false
        bigDataCategorySwitch.isEnabled = false
        cloudCategorySwitch.isEnabled = false
        dataBaseCategorySwitch.isEnabled = false
        devOpsCategorySwitch.isEnabled = false
        integrationCategorySwitch.isEnabled = false
        IOTCategorySwitch.isEnabled = false
        javaCategorySwitch.isEnabled = false
        microServicesCategorySwitch.isEnabled = false
        openSourceCategorySwitch.isEnabled = false
        perfomanceCategorySwitch.isEnabled = false
        securityCategorySwitch.isEnabled = false
        webDevCategorySwitch.isEnabled = false
    }
}
