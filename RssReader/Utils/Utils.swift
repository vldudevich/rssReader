//
//  Utls.swift
//  RssReader
//
//  Created by vladislav on 08.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit

class Utils {
    static func load(url: URL, completionHandler: ((UIImage?) -> Void)? = nil) {
        DispatchQueue.global().async { [] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler?(image)
                    }
                }
            }
        }
    }
}

