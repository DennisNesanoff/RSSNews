//
//  NewsTableViewCell.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 11.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            descriptionLabel.text = item.description
            dataLabel.text = item.pubDate
        }
    }
}
