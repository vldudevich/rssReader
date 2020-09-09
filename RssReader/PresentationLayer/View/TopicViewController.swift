//
//  TopicViewController.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class TopicViewController: UIViewController {
    
    @IBOutlet private weak var topicsTableView: UITableView!
    
    let url = "http://feeds.dzone.com/agile"
    
    var output: TopicViewOutput!
    var topicLists = [RSSItem]()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidOnLoad()
    }
}

extension TopicViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicsTableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TopicViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicLists.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topicsTableView.dequeueReusableCell(withIdentifier: TopicTableViewCell.identifier) as! TopicTableViewCell
        cell.delegate = self
        cell.configureCell(topic: topicLists[indexPath.row])
        return cell
    }
    
}
extension TopicViewController: TopicTableViewCellDelegate {
    func readLinkLocal(_ cell: TopicTableViewCell) {
        let webView = CustomWebViewController()
        guard let indexTopic = topicsTableView.indexPath(for: cell)?.row else {return}
        webView.url = topicLists[indexTopic].link
        self.navigationController?.pushViewController(webView, animated: true)
    }
}

extension TopicViewController: FeedParserDelegate {
    func feedGetElements(rssItems: [RSSItem]) {
        topicLists = rssItems
        print(rssItems)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.topicsTableView.isHidden = false
            self.topicsTableView.reloadData()
        }
    }
}

extension TopicViewController: TopicViewInput {
    func setupState() {
        
        topicsTableView.delegate = self
        topicsTableView.dataSource = self
        topicsTableView.isHidden = true
        let feed = FeedParser()
        feed.delegate = self
        feed.parseFeed(url: url)

        self.title = "Dzone RSS News"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "settings"), landscapeImagePhone: UIImage(named: "settings"), style: .plain, target: self, action: nil)
        
        createActivityIndicator()
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = .white
    }
}

private extension TopicViewController {
    func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
}
