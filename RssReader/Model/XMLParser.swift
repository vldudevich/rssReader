//
//  XMLParser.swift
//  RssReader
//
//  Created by vladislav on 03.09.2020.
//  Copyright © 2020 vladislav. All rights reserved.
//

import Foundation
import UIKit

protocol FeedParserDelegate: AnyObject {
    func feedGetElements(rssItems: [RSSItem])
}

class RSSItem {
    
    var title: String = ""
    var link: String = ""
    var description: String = ""
    var category: [String] = []
    var pubDate: String = ""
    var currentMedia: String = ""
    var isLoad: Bool = false
    
    init(title: String, link: String, description: String, category: [String], pubDate: String, currentMedia: String, isload: Bool) {
        
        self.title = title
        self.link = link
        self.description = description
        self.category = category
        self.pubDate = pubDate
        self.currentMedia = currentMedia
        self.isLoad = isload
        
    }
    
    func getImage(succes: @escaping (_ success: UIImage) -> Void)  {
        if let url = URL(string: currentMedia) {
            Utils.load(url: url) { (image) in
                guard let image = image else { return }
                succes(image)
            }
        } else {
            succes(UIImage(named: "nophoto")!)
        }
    }
}

enum RSSTags: String {
    case title
    case link
    case description
    case category
    case pubDate
    case media = "media:thumbnail"
}

class FeedParser: NSObject, XMLParserDelegate {
    
    private var rssItems: [RSSItem] = []
    private var currentElement: String = ""
    private var currentTitle: String = ""
    private var currentLink: String = ""
    private var currentDescription: String = ""
    private var currentCategory: [String] = []
    private var currentPubDate: String = ""
    private var currentMedia: String = ""
    private var currentStateIsLoad: Bool = false
    
    weak var delegate: FeedParserDelegate?
    
    func parseFeed(url: String) {
        
        let request = URLRequest(url: URL(string: url)!)
        let urlSession = URLSession.shared
        let task = urlSession.dataTask(with: request) { (data, _, _)  in
            guard let data = data else {return}
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }
        task.resume()
        
    }
    func parseTopic(data: Data) {
        let parser = XMLParser(data: data)
        parser.delegate = self
        parser.parse()
    }
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        if currentElement == "item" {
            currentTitle = ""
            currentLink = ""
            currentDescription = ""
            currentCategory = []
            currentPubDate = ""
            currentMedia = ""
        }
        if currentElement == RSSTags.media.rawValue {
            guard let url = attributeDict["url"] else {return}
            
            currentMedia = url
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
            
        case RSSTags.title.rawValue: currentTitle += string.htmlDecoded
        case RSSTags.link.rawValue: currentLink += string.htmlDecoded
        case RSSTags.description.rawValue: currentDescription += string.htmlDecoded
        case RSSTags.category.rawValue: currentCategory.append(string.htmlDecoded); currentCategory.removeAll() { $0 == ""}
        case RSSTags.pubDate.rawValue: currentPubDate += string.htmlDecoded
        case RSSTags.media.rawValue: currentMedia += string.htmlDecoded
            
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, link: currentLink, description: currentDescription, category: currentCategory, pubDate: currentPubDate, currentMedia: currentMedia, isload: currentStateIsLoad)
            self.rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        delegate?.feedGetElements(rssItems: rssItems)
    }
}
