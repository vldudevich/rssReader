//
//  SettingsViewOutput.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol SettingsViewOutput {
    func viewOnDidLoad()
    func turnOnSwitch(indexOfCategory: Int)
    func turnOffSwitch(indexOfCategory: Int)
    func loadFromBD()
}


