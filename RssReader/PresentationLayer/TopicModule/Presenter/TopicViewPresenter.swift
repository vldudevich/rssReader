//
//  TopicViewPresenter.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

class TopicViewPresenter: TopicViewOutput {
    func viewDidOnLoad(urlToSearch: String) {
        view.setupState()
        getTopicData(urlToSearch: urlToSearch)
    }
    

    weak var view: TopicViewInput!
    
    func searchTopicByTitleName(stringToSearch: String) {
        
    }
    
    
    private func getTopicData(urlToSearch: String) {
        let dataManager = DataManager()
        dataManager.getTopicData(url: urlToSearch) { (data) in
            let parser = FeedParser()
            parser.delegate = self
            parser.parseTopic(data: data)
        }
    }
}

extension TopicViewPresenter: FeedParserDelegate {
    func feedGetElements(rssItems: [RSSItem]) {
        view.topicsGet(items: rssItems)
    }
}
