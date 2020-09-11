//
//  SettingsViewPresenter.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SettingsViewPresenter: SettingsViewOutput {
    weak var view: SettingsViewInput!
    
    func viewOnDidLoad() {
        view.setupState()
    }
}
