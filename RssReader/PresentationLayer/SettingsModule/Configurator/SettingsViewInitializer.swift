//
//  SettingsViewInitializer.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class SettingsViewInitializer: NSObject {
    
    @IBOutlet private var viewController: SettingsViewController!
    
    override func awakeFromNib() {
        let configurator = SettingsViewConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
