//
//  TransactionTableViewCell.swift
//  Expensum
//
//  Created by Chris James on 27/03/2022.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    static let identifier = "TransactionTableViewCell"
    
    private var transactions: [Transaction] = [Transaction]()
    
    private var categoryIcon: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = UIColor(named: "Background2")
        
        contentView.addSubview(categoryIcon)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(amountLabel)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // categoryIcon
            categoryIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            categoryIcon.widthAnchor.constraint(equalToConstant: 50),
            categoryIcon.heightAnchor.constraint(equalToConstant: 50),
            
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -25),
            descriptionLabel.leadingAnchor.constraint(equalTo: categoryIcon.trailingAnchor, constant: 10),
            
            // dateLabel
            dateLabel.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 25),
            dateLabel.leadingAnchor.constraint(equalTo: categoryIcon.trailingAnchor, constant: 10),
            
            // amountLabel
            amountLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with model: Transaction) {
        if model.description.count > 20 {
            let text = "\(String(model.description.prefix(15)))..."
            descriptionLabel.text = text
        } else {
            descriptionLabel.text = model.description
        }
        
        dateLabel.text = model.trans_date
        amountLabel.text = "$\(model.amount)"
        amountLabel.textColor = model.type == "Add" ? .systemGreen : .systemRed
        categoryIcon = categoryIcon.setCategoryIcon(categoryIcon, category: model.category!.name)
    }
}
