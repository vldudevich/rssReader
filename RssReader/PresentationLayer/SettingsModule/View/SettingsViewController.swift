//
//  ViewController.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import CoreData

protocol SaveSettingsItemsDelegate: AnyObject {
    func saveSettingsItems()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    var output: SettingsViewOutput!
    var activeSettingItem = [Int]()
    weak var delegate: SaveSettingsItemsDelegate!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        output.viewOnDidLoad()
        output.loadFromBD()
    }
}
extension SettingsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return TopicThemes.allCases.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SettingSectionHeaderReusableView.indentifier, for: indexPath) as? SettingSectionHeaderReusableView {
            sectionHeader.sectionHeaderLabel.text = "Categories"
            sectionHeader.sectionHeaderDividerView.backgroundColor = .lightGray
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoriesCollectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.indentifier, for: indexPath) as! CategoriesCollectionViewCell
        cell.delegate = self
         
        if activeSettingItem.contains(indexPath.row) {
            cell.configureCell(settingItemName: TopicThemes.allCases[indexPath.row].rawValue, settingItemSwitchState: true)
        } else {
            cell.configureCell(settingItemName: TopicThemes.allCases[indexPath.row].rawValue, settingItemSwitchState: false)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categoriesCollectionView.deselectItem(at: indexPath, animated: true)
    }
}
extension SettingsViewController: SettingsViewInput {
    func loadStateFromBD(indexOfCategory: Int) {
        activeSettingItem.append(indexOfCategory)
    }
    
    func setupState() {
        self.title = "Zones to Subscrtibe"
        
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressTouchUpInside))
    }
}

extension SettingsViewController: CategoriesCollectionViewCellDelegate {
    
    func valueChangeSwitch(_ cell: CategoriesCollectionViewCell) {
        guard let index = categoriesCollectionView.indexPath(for: cell)?.row else { return }
        if cell.categorySwitch.isOn {
            output.turnOnSwitch(indexOfCategory: index)
        } else {
            output.turnOffSwitch(indexOfCategory: index)
        }
    }
}
private extension SettingsViewController {
    
    @objc func donePressTouchUpInside() {
        delegate.saveSettingsItems()
        dismiss(animated: true, completion: nil)
    }
}
