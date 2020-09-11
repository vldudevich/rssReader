//
//  TopicTableViewCell.swift
//  RssReader
//
//  Created by vladislav on 08.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol TopicTableViewCellDelegate {
    func readLinkLocal(_ cell: TopicTableViewCell)
}

class TopicTableViewCell: UITableViewCell {
    
    static let identifier = "TopicTableViewCell"
    
    @IBOutlet private weak var titleTopicLabel: UILabel!
    @IBOutlet private weak var pubDateTopicLabel: UILabel!
    @IBOutlet private weak var topicImageView: UIImageView!
    @IBOutlet private weak var descriptionTopicLabel: UILabel!
    @IBOutlet private weak var categoryTopicLabel: UILabel!
    
    var delegate: TopicTableViewCellDelegate?
    
    @IBAction func readClick(_ sender: Any) {
        delegate?.readLinkLocal(self)
    }
    
    func configureCell(topic: RSSItem) {
        
        titleTopicLabel.text = topic.title
        pubDateTopicLabel.text = topic.pubDate
        descriptionTopicLabel.text = topic.description
        pubDateTopicLabel.text = topic.pubDate
        categoryTopicLabel.text = topic.category.first?.capitalized
        topic.getImage { (image) in
            self.topicImageView.image = image
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
