//
//  DataManager.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import CoreData

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    var isAccess: Bool {
        return API.shared.getInternetActivity()
    }
    
    func getTopicData(url: String, topicData: @escaping (Data) -> Void){
        API.shared.request(for: url, success: { (data) in
            topicData(data)
        }) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    func getWebData(url: String, topicData: @escaping (Data) -> Void) {
        API.shared.requestForGetData(for: url, success: { (data) in
            topicData(data)
        }) { (error) in
            if let error = error {
                print(error)
            }
        }
    }
    func fillTheBD() {
        
        let managedContext =
            PersistenceService.shared.persistentContainer.viewContext
        
        //2
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "SettingItem")
        
        //3
        do {
          let settingItem = try managedContext.fetch(fetchRequest)
            if settingItem.isEmpty {
                for item in TopicThemes.allCases {
                    let setting = SettingItem(context: PersistenceService.shared.persistentContainer.viewContext)
                    setting.name = item.rawValue
                    setting.isActive = false
                    PersistenceService.shared.saveContext()
                }
            }
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")

        } catch {}
    }
    
    func getTopicItems(completion: ([SavedTopic]) -> Void) {
        
        let fetchRequest:
            NSFetchRequest<SavedTopic> = SavedTopic.fetchRequest()
        
        do {
            let savedTopicItems =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            completion(savedTopicItems)
            PersistenceService.shared.saveContext()
            
        } catch {}
        
    }
    func removeTopic(indexPath: Int) {
        
        let fetchRequest:
            NSFetchRequest<SavedTopic> = SavedTopic.fetchRequest()
        
        do {
            var savedTopicItems =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            savedTopicItems.remove(at: indexPath)
            PersistenceService.shared.saveContext()
            
        } catch {}
        
    }
    func getSettingItems(completion: ([SettingItem]) -> Void) {
        
        let fetchRequest:
            NSFetchRequest<SettingItem> = SettingItem.fetchRequest()
        
        do {
            let settingItems =  try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)
            completion(settingItems)
            PersistenceService.shared.saveContext()
            
        } catch {}
        
    }
    
}

