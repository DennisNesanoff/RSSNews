//
//  NewsViewController.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 07.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class NewsViewController: UITableViewController {
    var rssItems: [RSSItem]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func fetchData() {
        let parser = Parser()
        parser.parseRSSNews(url: "https://www.finam.ru/net/analysis/conews/rsspoint") { rssItems in
            self.rssItems = rssItems
            
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else { return 0 }
        
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        return cell
    }
}
