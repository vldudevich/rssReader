//
//  CategoriesCollectionViewCell.swift
//  RssReader
//
//  Created by vladislav on 15.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

protocol CategoriesCollectionViewCellDelegate: AnyObject {
    func valueChangeSwitch(_ cell: CategoriesCollectionViewCell)
}

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    static let indentifier = "CategoriesCollectionViewCell"
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categorySwitch: UISwitch!
    
    weak var delegate: CategoriesCollectionViewCellDelegate!
    
    @IBAction private func changeStateSwitchByTap(_ sender: UISwitch) {
        
        delegate.valueChangeSwitch(self)
    }
    
    func configureCell(settingItemName: String, settingItemSwitchState: Bool) {
        categoryNameLabel.text = settingItemName.capitalized
        categorySwitch.isOn = settingItemSwitchState
    }
}

