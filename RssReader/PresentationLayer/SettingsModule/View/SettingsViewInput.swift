//
//  SettingsViewInput.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol SettingsViewInput: AnyObject {
    func setupState()
    func loadStateFromBD(indexOfCategory: Int)
}
