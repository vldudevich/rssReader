//
//  SettingsConfigurator.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class SettingsViewConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? SettingsViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: SettingsViewController) {
        let presenter = SettingsViewPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
