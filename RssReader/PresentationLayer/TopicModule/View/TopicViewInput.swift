//
//  TopicViewInput.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation

protocol TopicViewInput: AnyObject {
    func setupState()
    func onGetTopics(items: [SavedTopic])
    func onGetSettingsItems(itemsCount: Int)
}
