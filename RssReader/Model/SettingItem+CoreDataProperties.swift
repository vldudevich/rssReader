//
//  SettingItem+CoreDataProperties.swift
//  
//
//  Created by vladislav on 16.10.2020.
//
//

import Foundation
import CoreData


extension SettingItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SettingItem> {
        return NSFetchRequest<SettingItem>(entityName: "SettingItem")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?

}
