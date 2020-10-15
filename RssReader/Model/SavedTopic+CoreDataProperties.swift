//
//  SavedTopic+CoreDataProperties.swift
//  
//
//  Created by vladislav on 30.09.2020.
//
//

import Foundation
import CoreData


extension SavedTopic {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SavedTopic> {
        return NSFetchRequest<SavedTopic>(entityName: "SavedTopic")
    }

    @NSManaged public var title: String?
    @NSManaged public var category: [String]?
    @NSManaged public var descr: String?
    @NSManaged public var image: Data?
    @NSManaged public var link: Data?
    @NSManaged public var pubDate: String?
    @NSManaged public var saved: Bool

}
