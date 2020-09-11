//
//  TopicViewPresenter.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TopicViewPresenter: TopicViewOutput {
    func searchTopicByTitleName(stringToSearch: String) {
        
    }
    
    
    weak var view: TopicViewInput!
    
    func viewDidOnLoad() {
        view.setupState()
    }
}
