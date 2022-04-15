//
//  TransactionViewController.swift
//  Expensum
//
//  Created by Chris James on 07/04/2022.
//

import UIKit

class TransactionViewController: UIViewController {
    private var transaction: Transaction?
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var categoryIcon: UIImageView = {
        let view = UIImageView()
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionTypeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaction Type"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transactionTypeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transDateTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaction Date"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transaction Details"
        view.backgroundColor = UIColor(named: "Background1")
        
        setupView()
        applyConstraints()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(categoryIcon)
        scrollView.addSubview(descriptionTitleLabel)
        scrollView.addSubview(descriptionLabel)
        scrollView.addSubview(categoryTitleLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(transactionTypeTitleLabel)
        scrollView.addSubview(transactionTypeLabel)
        scrollView.addSubview(amountTitleLabel)
        scrollView.addSubview(amountLabel)
        scrollView.addSubview(transDateTitleLabel)
        scrollView.addSubview(transDateLabel)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // categoryIcon
            categoryIcon.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 15),
            categoryIcon.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            categoryIcon.widthAnchor.constraint(equalToConstant: 50),
            categoryIcon.heightAnchor.constraint(equalToConstant: 50),
            
            // descriptionTitleLabel
            descriptionTitleLabel.topAnchor.constraint(equalTo: categoryIcon.bottomAnchor, constant: 20),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            descriptionLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40),
            
            // categoryTitleLabel
            categoryTitleLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            categoryTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // categoryLabel
            categoryLabel.topAnchor.constraint(equalTo: categoryTitleLabel.bottomAnchor, constant: 5),
            categoryLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // transactionTypeTitleLabel
            transactionTypeTitleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 20),
            transactionTypeTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // transactionTypeLabel
            transactionTypeLabel.topAnchor.constraint(equalTo: transactionTypeTitleLabel.bottomAnchor, constant: 5),
            transactionTypeLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // amountTitleLabel
            amountTitleLabel.topAnchor.constraint(equalTo: transactionTypeLabel.bottomAnchor, constant: 20),
            amountTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // amountLabel
            amountLabel.topAnchor.constraint(equalTo: amountTitleLabel.bottomAnchor, constant: 5),
            amountLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // transDateTitleLabel
            transDateTitleLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 20),
            transDateTitleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // transDateLabel
            transDateLabel.topAnchor.constraint(equalTo: transDateTitleLabel.bottomAnchor, constant: 5),
            transDateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        categoryIcon = categoryIcon.setCategoryIcon(categoryIcon, category: transaction!.category!.name)
        descriptionLabel.text = transaction!.description
        categoryLabel.text = transaction!.category!.name
        transactionTypeLabel.text = transaction!.type
        amountLabel.text = "$\(transaction!.amount)"
        transDateLabel.text = transaction!.trans_date
    }
    
    public func configure(with model: Transaction) {
        transaction = model
    }
}
