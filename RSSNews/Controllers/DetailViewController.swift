//
//  DetailViewController.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 12.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    var descriptionLabel = UITextView()
    
    var item: RSSItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        
        configureTitleLabel()
        configureDateLabel()
        configureDescriptionLabel()
        
        setTitleConstraints()
        setDateConstraints()
        setDescriptionConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // MARK: - Configuration of items
    func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.text = item.title
        titleLabel.font = UIFont.systemFont(ofSize: 23, weight: .semibold)
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.text = item.pubDate
        dateLabel.font = UIFont.systemFont(ofSize: 11)
    }
    
    func configureDescriptionLabel() {
        descriptionLabel.text = item.description
        descriptionLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }
    
    // MARK: - Set constraints
    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func setDateConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            dateLabel.heightAnchor.constraint(equalToConstant: 40),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    func setDescriptionConstraints() {
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
        ])
    }
}
