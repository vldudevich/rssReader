//
//  CustomWebViewController.swift
//  RssReader
//
//  Created by vladislav on 09.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import UIKit
import WebKit

class CustomWebViewController: UIViewController {

    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            DataManager.shared.getWebData(url: self.url) { (data) in
                DispatchQueue.main.async {
                if let htmlData = String(data: data, encoding: String.Encoding.utf8) {
                    webView.loadHTMLString(htmlData, baseURL: URL(string: self.url)!)
                    }
                }
            }
        }

        view.addSubview(webView)
        webView.fillToSuperview()
    }
}
