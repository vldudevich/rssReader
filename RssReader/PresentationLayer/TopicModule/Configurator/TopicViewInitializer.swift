//
//  TopicViewInitializer.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class TopicViewInitializer: NSObject {
    
    @IBOutlet private var viewController: TopicViewController!
    
    override func awakeFromNib() {
        let configurator = TopicViewConfigurator()
        configurator.configureModuleForViewInput(viewInput: viewController)
    }
}
