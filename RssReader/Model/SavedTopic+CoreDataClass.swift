//
//  SavedTopic+CoreDataClass.swift
//  
//
//  Created by vladislav on 16.10.2020.
//
//

import Foundation
import CoreData

@objc(SavedTopic)
public class SavedTopic: NSManagedObject {
    
    convenience init (topicObject: RSSItem, context: NSManagedObjectContext!) {
        self.init(context: context)
        
        title = topicObject.title
        descr = topicObject.description
        pubDate = topicObject.pubDate
        webLink = topicObject.link
        imageLink = topicObject.currentMedia
        category = topicObject.category
        saved = topicObject.isLoad
    }
}
