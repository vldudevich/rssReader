//
//  SettingsViewPresenter.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import CoreData

class SettingsViewPresenter: SettingsViewOutput {

    weak var view: SettingsViewInput!
    
    func viewOnDidLoad() {
        view.setupState()
    }
    
    func turnOnSwitch(indexOfCategory: Int) {
        let fetchRequest:
            NSFetchRequest<SettingItem> = SettingItem.fetchRequest()

        do {
            let items =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            items[indexOfCategory].isActive = true
            PersistenceService.shared.saveContext()
        } catch {}
    }
    
    func turnOffSwitch(indexOfCategory: Int) {
        let fetchRequest:
            NSFetchRequest<SettingItem> = SettingItem.fetchRequest()

        do {
            let items =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            items[indexOfCategory].isActive = false
            PersistenceService.shared.saveContext()
        } catch {}
    }
    
    func loadFromBD() {
        let fetchRequest:
            NSFetchRequest<SettingItem> = SettingItem.fetchRequest()

        do {
            let items =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            for (item, element) in items.enumerated() {
                if element.isActive {
                    view.loadStateFromBD(indexOfCategory: item)
                }
            }
            PersistenceService.shared.saveContext()
        } catch {}
    }
}

private extension SettingsViewPresenter {

}
