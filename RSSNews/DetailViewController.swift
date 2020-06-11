//
//  DetailViewController.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 08.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {
    
    
    @IBOutlet weak var dataLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = ""
    }
}
