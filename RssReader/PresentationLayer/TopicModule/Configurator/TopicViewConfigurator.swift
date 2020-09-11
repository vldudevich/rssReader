//
//  TopicViewConfigurator.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TopicViewConfigurator {
    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? TopicViewController {
            configure(viewController: viewController)
        }
    }
    
    private func configure(viewController: TopicViewController) {
        let presenter = TopicViewPresenter()
        presenter.view = viewController
        viewController.output = presenter
    }
}
