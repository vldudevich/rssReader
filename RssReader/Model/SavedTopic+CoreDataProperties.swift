//
//  SavedTopic+CoreDataProperties.swift
//  
//
//  Created by vladislav on 16.10.2020.
//
//

import Foundation
import CoreData


extension SavedTopic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTopic> {
        return NSFetchRequest<SavedTopic>(entityName: "SavedTopic")
    }

    @NSManaged public var category: [String]?
    @NSManaged public var descr: String?
    @NSManaged public var imageData: Data?
    @NSManaged public var imageLink: String?
    @NSManaged public var webLinkData: Data?
    @NSManaged public var pubDate: String?
    @NSManaged public var saved: Bool
    @NSManaged public var title: String?
    @NSManaged public var webLink: String?

}
