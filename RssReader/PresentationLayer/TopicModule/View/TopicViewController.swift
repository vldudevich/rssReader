//
//  TopicViewController.swift
//  RssReader
//
//  Created by vladislav on 07.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreData

class TopicViewController: UIViewController {
    
    @IBOutlet private weak var topicsTableView: UITableView!
    @IBOutlet private weak var topicSearchBar: UISearchBar!
    @IBOutlet private weak var modesState: UISegmentedControl!
    
    var output: TopicViewOutput!
    
    private var topicLists = [SavedTopic]()
    private var searchLists = [SavedTopic]()
    private var activityIndicator = UIActivityIndicatorView()
    
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewDidOnLoad()
    }
    
    
   @IBAction private func changeModesControlSwitch(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            searchLists.removeAll()
            topicLists.filter {$0.saved}.forEach {searchLists.append($0) }
            topicsTableView.reloadData()
        } else {
            searchLists = topicLists
            topicsTableView.reloadData()
            
        }
    }
}

private extension TopicViewController {
    func createActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        self.view.addSubview(activityIndicator)
    }
    
    func showSettingController() {
        let settingsNavController = UIStoryboard(name: "SettingsViewController", bundle: nil).instantiateInitialViewController() as? UINavigationController
        let viewController = settingsNavController?.viewControllers.first as? SettingsViewController
        viewController?.delegate = self
        self.present(settingsNavController!, animated: true)
    }

    func startActivityIndicator() {

        topicsTableView.isHidden = true
        createActivityIndicator()
        activityIndicator.startAnimating()
        activityIndicator.backgroundColor = .white
    }
    
    @objc func settingButtonTouchUpInside(_ sender: UIButton) {
        showSettingController()
    }
    
    
    func hideIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
            self.activityIndicator.isHidden = true
            self.topicsTableView.isHidden = false
            self.topicsTableView.reloadData()
        }
    }
    
    @objc func refreshTable(_ sender: UIRefreshControl) {
        topicLists.removeAll()
        output.updateTopics()
        sender.endRefreshing()
    }
}

extension TopicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        topicsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchLists.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topicsTableView.dequeueReusableCell(withIdentifier: TopicTableViewCell .identifier) as! TopicTableViewCell
        cell.delegate = self
        cell.configureCell(topic: searchLists[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        var rowActions = [UITableViewRowAction]()

        let download = UITableViewRowAction(style: .normal, title: "download") { (action, indexPath) in
            self.topicLists[indexPath.row].saved = true
//            self.output.saveToBD(item: self.topicLists[indexPath.row])
            
        }
        
        let delete = UITableViewRowAction(style: .normal, title: "delete") { (action, indexPath) in
            self.topicLists[indexPath.row].saved = false
            DataManager.shared.removeTopic(indexPath: indexPath.row)
            
        }
        
        if topicLists[indexPath.row].saved {
            rowActions.append(delete)
        } else {
            rowActions.append(download)
        }
        delete.backgroundColor = .red
        return rowActions
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
}

extension TopicViewController: TopicTableViewCellDelegate {
    
    func readLinkLocal(_ cell: TopicTableViewCell) {
        let webView = CustomWebViewController()
        guard let indexTopic = topicsTableView.indexPath(for: cell)?.row else {return}
        webView.url = topicLists[indexTopic].webLink!
        self.navigationController?.pushViewController(webView, animated: true)
    }
}

extension TopicViewController: TopicViewInput {
    
    func onGetSettingsItems(itemsCount: Int) {
        
        if itemsCount == 0 {
            showSettingController()
        }
    }
    
    func onGetTopics(items: [SavedTopic]) {
        topicLists += items
        searchLists = topicLists
        topicsTableView.isHidden = false
        topicsTableView.reloadData()
        
    }
    
    func setupState() {
        topicsTableView.isHidden = true
        topicsTableView.delegate = self
        topicsTableView.dataSource = self
        topicsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshTable(_:)), for: .valueChanged)
        
        topicSearchBar.delegate = self

        self.title = "Dzone RSS News"

        let rightBarButtonItem = UIButton()
        rightBarButtonItem.addTarget(self, action: #selector(settingButtonTouchUpInside(_:)), for: .touchUpInside)
        rightBarButtonItem.setImage(UIImage(named: "settings"), for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonItem)
        
        modesState.setTitle("Online", forSegmentAt: 0)
        modesState.setTitle("Offline", forSegmentAt: 1)
    }
}

extension TopicViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchLists.removeAll()
        if searchText == "" {
            searchLists = topicLists
        }
        
        for item in topicLists {
            if searchText != "" && item.title!.contains(searchText) {
                searchLists.append(item)
            }
        }
        
        topicsTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension TopicViewController: SaveSettingsItemsDelegate {
    func saveSettingsItems() {
        output.updateTopics()
    }
}
