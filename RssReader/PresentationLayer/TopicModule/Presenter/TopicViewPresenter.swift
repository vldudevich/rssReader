//
//  TopicViewPresenter.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TopicViewPresenter: TopicViewOutput {
    func saveToBD(item: RSSItem) {
    
    }
    
    weak var view: TopicViewInput!
    
//    func saveToBD(item: SavedTopic) {
//
//        let currentItem = SavedTopic(context: PersistenceService.shared.persistentContainer.viewContext)
//
//        let group = DispatchGroup()
//        currentItem.title = item.title
//        currentItem.descr = item.descr
//        currentItem.pubDate = item.pubDate
//        currentItem.saved = item.isLoad
//        group.enter()
//
//        DataManager.shared.getWebData(url: item.currentMedia) { (data) in
//            currentItem.image = data
//            group.leave()
//        }
//        group.enter()
//        DataManager.shared.getWebData(url: item.link) { (data) in
//            currentItem.link = data
//            group.leave()
//        }
//
//        group.notify(queue: .main) {
//            PersistenceService.shared.saveContext()
//        }
//    }
    
    func viewDidOnLoad() {
        view.setupState()
        if DataManager.shared.isNetworkAccess {
            getSettingsItem()
//        } else {
//            getSavingItem()
//        }
        }
    }
    
    func updateTopics() {
        getSettingsItem()
    }
}

private extension TopicViewPresenter {
    
    func getTopicData(urlToSearch: String) {
        
        DataManager.shared.getTopicData(url: urlToSearch) { (data) in
            let parser = FeedParser()
            parser.delegate = self
            parser.parseTopic(data: data)
        }
    }
    func getSettingsItem() {
        var activeCategory = [String]()
        let fetchRequest:
            NSFetchRequest<SettingItem> = SettingItem.fetchRequest()

        do {
            let items =
                try PersistenceService.shared.persistentContainer.viewContext.fetch(fetchRequest)

            items.filter { $0.isActive }.forEach { activeCategory.append($0.name!) }
            view.onGetSettingsItems(itemsCount: activeCategory.count)
            PersistenceService.shared.saveContext()
        } catch {}
        
        if !activeCategory.isEmpty {
            activeCategory.forEach {loadTopicsByCategory(categoriesToSearch: $0)}
        }
    }
    
    func loadTopicsByCategory(categoriesToSearch: String) {
        
        let parser = FeedParser()
        let group = DispatchGroup()
        var myData = Data()
        
        group.enter()
        DataManager.shared.getTopicData(url: categoriesToSearch) { (data) in
            
            parser.delegate = self
            myData = data
            group.leave()
            
        }
        group.notify(queue: .main) {
            parser.parseTopic(data: myData)
        }
    }
}

extension TopicViewPresenter: FeedParserDelegate {
    func feedGetElements(rssItems: [RSSItem]) {
        var items = [SavedTopic]()
        
        rssItems.forEach {items.append(SavedTopic(topicObject: $0, context: PersistenceService.shared.persistentContainer.viewContext))}
        view.onGetTopics(items: items)
    }
}
