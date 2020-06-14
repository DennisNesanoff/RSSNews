//
//  NewsViewController.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 07.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    private var news: [RSSItem]?
    private let sources = SourceManager.shared.createSources()
    private var tableView = UITableView()
    private var refreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    private var feedURLString = "https://developer.apple.com/news/rss/news.rss"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        fetchData(from: feedURLString)
        sender.endRefreshing()
    }
    
    @objc func openSource() {
        let ac = UIAlertController(title: "Open source…", message: nil, preferredStyle: .actionSheet)

        sources.forEach { source in
            ac.addAction(UIAlertAction(title: source.title, style: .default) { _ in
                self.feedURLString = source.rssString
                self.fetchData(from: self.feedURLString)
            })
        }
        
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    // MARK: - configureUI()
    private func configureUI() {
        view.addSubview(tableView)
        
        configureNavigationBar(largeTitleColor: .white,
                               backgoundColor: UIColor(red: 1/225, green: 108/225, blue: 62/225, alpha: 1),
                               tintColor: .white,
                               title: "RSS News",
                               preferredLargeTitle: true)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Source",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(openSource))
        
        setTableViewDelegates()
        
        tableView.refreshControl = refreshControl
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.pin(to: view)
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifire)
        
        fetchData(from: feedURLString)
    }
    
    private func setTableViewDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - fetchData
    private func fetchData(from urlString: String) {
        let feedParser = RSSParser()
        feedParser.parseFeed(url: urlString) { news in
            self.news = news
            
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
            }
        }
    }
}

extension NewsViewController: UITableViewDelegate {
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let news = news else { return 0 }
        
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifire, for: indexPath) as! NewsTableViewCell
        
        if let item = news?[indexPath.row] {
            cell.item = item
        }
        
        return cell
    }
}

extension NewsViewController: UITableViewDataSource {
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        news?[indexPath.row].readed = true
        tableView.reloadData()
        
        let detailVC = DetailViewController()
        detailVC.item = news?[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
