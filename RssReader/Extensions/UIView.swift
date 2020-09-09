//
//  UIView.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

extension UIView {
    func fillToSuperview() {
        
        translatesAutoresizingMaskIntoConstraints = false
        if let superview = superview {
            let left = leftAnchor.constraint(equalTo: superview.leftAnchor)
            let right = rightAnchor.constraint(equalTo: superview.rightAnchor)
            let top = topAnchor.constraint(equalTo: superview.topAnchor)
            let bottom = bottomAnchor.constraint(equalTo: superview.bottomAnchor)
            NSLayoutConstraint.activate([left, right, top, bottom])
        }
    }
}
