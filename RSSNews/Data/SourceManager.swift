//
//  SourceManager.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 12.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import Foundation

class SourceManager {
    static var shared = SourceManager()
    var sources: [Sourse] = []
    
    func createSources() -> [Sourse] {
        sources = [
            Sourse(title: "apple.com", rssString: "https://developer.apple.com/news/rss/news.rss"),
            Sourse(title: "finam.ru", rssString: "https://www.finam.ru/net/analysis/conews/rsspoint"),
            Sourse(title: "banki.ru", rssString: "https://www.banki.ru/xml/news.rss"),
        ]
        return sources
    }
}
