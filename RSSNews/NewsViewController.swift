//
//  NewsViewController.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 07.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    var news: [RSSItem]?
    
    let feedURLString = "https://developer.apple.com/news/rss/news.rss"
//    let feedURLString = "https://www.finam.ru/net/analysis/conews/rsspoint"
//    let feedURLString = "https://www.banki.ru/xml/news.rss"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 200
        
        fetchData(from: feedURLString)
    }
    
    func fetchData(from urlString: String) {
        let feedParser = RSSParser()
        feedParser.parseFeed(url: urlString) { news in
            self.news = news
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = news else { return 0 }
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsTableViewCell
        
        if let item = news?[indexPath.row] {
            cell.item = item
        }
        
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rssItem = news?[indexPath.row] else { return }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
