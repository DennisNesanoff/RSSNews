//
//  XMLParser.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 08.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import Foundation

class Parser: NSObject, XMLParserDelegate {
    var rssItems: [RSSItem] = []
    var currentElement = ""
    var currentTitle = "" {
        didSet {
            currentTitle = currentTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var currentPublicationDate = "" {
        didSet {
            currentPublicationDate = currentPublicationDate.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var currentDescription = "" {
        didSet {
            currentDescription = currentDescription.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
    
    var parserComplitionHandler: (([RSSItem]) -> Void)?
    
    func parseRSSNews(url: String, complitionHandler: (([RSSItem]) -> Void)?) {
        parserComplitionHandler = complitionHandler
        
        let request = URLRequest(url: URL(string: url)!)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error {
                    print(error.localizedDescription)
                }
                
                return
            }
            
            // parse XML
            let parser = XMLParser(data: data)
            parser.delegate = self
            parser.parse()
        }.resume()
    }
    
    // MARK: - XML Parser Delegate
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
        
        if currentElement == "item" {
            var currentTitle = ""
            var currentPublicationDate = ""
            var currentDescription = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch currentElement {
        case "title": currentTitle += string
        case "description": currentTitle += string
        case "pubDate": currentTitle += string
        default: break
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "item" {
            let rssItem = RSSItem(title: currentTitle, publicationDate: currentPublicationDate, description: currentDescription)
            rssItems.append(rssItem)
        }
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        parserComplitionHandler?(rssItems)
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print(parseError.localizedDescription)
    }
}
