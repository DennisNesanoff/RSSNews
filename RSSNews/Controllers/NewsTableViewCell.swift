//
//  NewsTableViewCell.swift
//  RSSNews
//
//  Created by Dennis Nesanoff on 12.06.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    var readedView = UIView()
    var titleLabel = UILabel()
    var dateLabel = UILabel()
    
    var item: RSSItem! {
        didSet {
            titleLabel.text = item.title
            dateLabel.text = item.pubDate
            
            let color = UIColor(red: 138/225, green: 199/225, blue: 97/225, alpha: 1)
            let checkedColor = UIColor(red: 1/225, green: 108/225, blue: 62/225, alpha: 1)
            readedView.backgroundColor = item.readed ? checkedColor : color
            titleLabel.textColor = item.readed ? .white : checkedColor
            dateLabel.textColor = item.readed ? .white : checkedColor
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        accessoryType = .disclosureIndicator
        
        addSubview(readedView)
        addSubview(titleLabel)
        addSubview(dateLabel)
        
        configureTitleLabel()
        configureDateLabel()
        
        setViewConstraints()
        setTitleConstraints()
        setDateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration of items
    func configureTitleLabel() {
        titleLabel.numberOfLines = 3
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = UIColor(red: 1/225, green: 108/225, blue: 62/225, alpha: 1)
    }
    
    func configureDateLabel() {
        dateLabel.numberOfLines = 1
        dateLabel.adjustsFontSizeToFitWidth = true
        dateLabel.textColor = UIColor(red: 1/225, green: 108/225, blue: 62/225, alpha: 1)
    }
    
    // MARK: - Set constraints
    func setViewConstraints() {
        readedView.translatesAutoresizingMaskIntoConstraints = false
        readedView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        readedView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        readedView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        readedView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    func setTitleConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: readedView.topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: readedView.leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: readedView.trailingAnchor, constant: -8).isActive = true
    }
    
    func setDateConstraints() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        dateLabel.leadingAnchor.constraint(equalTo: readedView.leadingAnchor, constant: 8).isActive = true
        dateLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: readedView.trailingAnchor, constant: -8).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: readedView.bottomAnchor, constant: -8).isActive = true
    }
}
