//
//  TransactionsViewController.swift
//  Expensum
//
//  Created by Chris James on 19/03/2022.
//

import UIKit

class TransactionsViewController: UIViewController {
    private var categories: [Category] = [Category]()
    
    private var selectedCategoryId: Int?
    
    private var transactions: [Transaction] = [Transaction]()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(named: "Background1")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let transactionTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.showsVerticalScrollIndicator = false
        table.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Transactions"
        view.backgroundColor = UIColor(named: "Background1")
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")
        
        setupView()
        applyConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchCategories()
        fetchTransactions()
    }
    
    private func setupView() {
        view.addSubview(categoryCollectionView)
        view.addSubview(transactionTableView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // categoryCollectionView
            categoryCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            // transactionTableView
            transactionTableView.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
            transactionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transactionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transactionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    private func fetchCategories() {
        APICaller.shared.getCategories() { result in
            switch result {
            case .success(let categories):
                self.categories = categories
                DispatchQueue.main.async {
                    self.categoryCollectionView.reloadData()
                }
            case .failure(let error):
                if error.localizedDescription == "jwt expired" {
                    self.goToLoginScreen()
                } else {
                    self.errorAlertBox(message: error.localizedDescription)
                }
            }
        }
    }
    
    private func fetchTransactions() {
        var params: [URLQueryItem] = [URLQueryItem]()
        
        if let selectedCategoryId = selectedCategoryId {
            params.append(
                URLQueryItem(name: "cat_id", value: String(selectedCategoryId))
            )
        }
        
        APICaller.shared.getTransactions(params: params) { result in
            switch result {
            case .success(let data):
                self.transactions = data.transactions!
                DispatchQueue.main.async {
                    self.transactionTableView.reloadData()
                }
            case .failure(let error):
                if error.localizedDescription == "jwt expired" {
                    self.goToLoginScreen()
                } else {
                    self.errorAlertBox(message: error.localizedDescription)
                }
            }
        }
    }
    
    @objc private func handleRefreshControl() {
        fetchTransactions()
        
        transactionTableView.refreshControl!.endRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        transactionTableView.refreshControl = UIRefreshControl()
        transactionTableView.refreshControl!.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
    }
}

extension TransactionsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categories[indexPath.row].name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]).width + 50, height: 50)
    }
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return }

        let category = cell.getSelectedCategory()

        print(category.id)
    }*/
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryCollectionViewCell else { return false }
        
        if cell.isSelected == true {
            collectionView.deselectItem(at: indexPath, animated: true)
            selectedCategoryId = nil
            fetchTransactions()
        } else {
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
            selectedCategoryId = categories[indexPath.row].id
            fetchTransactions()
            
            return true
        }
        
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configure(with: categories[indexPath.row].name)
        
        return cell
    }
}

extension TransactionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = transactions[indexPath.section]
        
        DispatchQueue.main.async {
            let vc = TransactionViewController()
            vc.configure(with: model)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier, for: indexPath) as? TransactionTableViewCell else { return UITableViewCell() }
        
        let model = transactions[indexPath.section]

        cell.configure(with: model)
        
        return cell
    }
}
