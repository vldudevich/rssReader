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
    
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        webView.load(urlRequest)
        
        view.addSubview(webView)
        webView.fillToSuperview()
    }
}
