//
//  HomeViewController.swift
//  Expensum
//
//  Created by Chris James on 26/03/2022.
//

import UIKit

class HomeViewController: UIViewController {
    private var transactions: [Transaction] = [Transaction]()
    
    private let primaryBackground = UIColor(named: "PrimaryBackground")!
    private let secondaryBackground = UIColor(named: "SecondaryBackground")!
    private let gradientLayer = CAGradientLayer()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let currentBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "CURRENT BALANCE"
        label.textColor = .white.withAlphaComponent(0.75)
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let currentBalanceAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 48, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
        let date = Date()
        
        let label = UILabel()
        label.text = "\(date.monthMedium) \(date.year)"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let incomeIcon: UIImageView = {
        let image = UIImage(systemName: "arrow.up")
        
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        view.contentMode = .center
        view.image = image
        view.backgroundColor = .white
        view.tintColor = .systemGreen
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let incomeLabel: UILabel = {
        let label = UILabel()
        label.text = "INCOME"
        label.textColor = .white.withAlphaComponent(0.9)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let incomeAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let expenseIcon: UIImageView = {
        let image = UIImage(systemName: "arrow.down")
        
        let view = UIImageView()
        view.layer.borderWidth = 1
        view.layer.masksToBounds = false
        view.layer.borderColor = UIColor.white.cgColor
        view.contentMode = .center
        view.image = image
        view.backgroundColor = .white
        view.tintColor = .red
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let expenseLabel: UILabel = {
        let label = UILabel()
        label.text = "EXPENSE"
        label.textColor = .white.withAlphaComponent(0.9)
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let expenseAmountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        
        view.backgroundColor = UIColor(named: "Background1")
        navigationController?.navigationBar.tintColor = UIColor(named: "Color1")
        
        setupView()
        applyConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchTransactions()
    }
    
    private func setupView() {
        view.addSubview(backgroundView)
        view.addSubview(currentBalanceLabel)
        view.addSubview(currentBalanceAmountLabel)
        view.addSubview(dateLabel)
        view.addSubview(incomeIcon)
        view.addSubview(incomeLabel)
        view.addSubview(incomeAmountLabel)
        view.addSubview(expenseIcon)
        view.addSubview(expenseLabel)
        view.addSubview(expenseAmountLabel)
        view.addSubview(transactionTableView)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // backgroundView
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.heightAnchor.constraint(equalToConstant: 300),
            
            // currentBalanceLabel
            currentBalanceLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            currentBalanceLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // currentBalanceAmountLabel
            currentBalanceAmountLabel.topAnchor.constraint(equalTo: currentBalanceLabel.bottomAnchor, constant: 5),
            currentBalanceAmountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // dateLabel
            dateLabel.topAnchor.constraint(equalTo: currentBalanceAmountLabel.bottomAnchor, constant: 5),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // incomeIcon
            incomeIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            incomeIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            incomeIcon.widthAnchor.constraint(equalToConstant: 25),
            incomeIcon.heightAnchor.constraint(equalToConstant: 25),
            
            // incomeLabel
            incomeLabel.leadingAnchor.constraint(equalTo: incomeIcon.leadingAnchor, constant: 40),
            incomeLabel.centerYAnchor.constraint(equalTo: incomeIcon.centerYAnchor),
            
            // incomeAmountLabel
            incomeAmountLabel.topAnchor.constraint(equalTo: incomeLabel.bottomAnchor, constant: 5),
            incomeAmountLabel.leadingAnchor.constraint(equalTo: incomeLabel.leadingAnchor),
            
            // expenseIcon
            expenseIcon.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            expenseIcon.widthAnchor.constraint(equalToConstant: 25),
            expenseIcon.heightAnchor.constraint(equalToConstant: 25),
            
            // expenseLabel
            expenseLabel.leadingAnchor.constraint(equalTo: expenseIcon.leadingAnchor, constant: 40),
            expenseLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            expenseLabel.centerYAnchor.constraint(equalTo: expenseIcon.centerYAnchor),
            
            // expenseAmountLabel
            expenseAmountLabel.topAnchor.constraint(equalTo: expenseLabel.bottomAnchor, constant: 5),
            expenseAmountLabel.leadingAnchor.constraint(equalTo: expenseLabel.leadingAnchor),
            
            // transactionTableView
            transactionTableView.topAnchor.constraint(equalTo: incomeAmountLabel.bottomAnchor, constant: 20),
            transactionTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            transactionTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            transactionTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gradientLayer.colors = [primaryBackground.cgColor, secondaryBackground.cgColor]
        gradientLayer.frame = backgroundView.bounds
        backgroundView.layer.insertSublayer(gradientLayer, at: 0)

        incomeIcon.layer.cornerRadius = incomeIcon.frame.height / 2
        expenseIcon.layer.cornerRadius = expenseIcon.frame.height / 2
        
        transactionTableView.refreshControl = UIRefreshControl()
        transactionTableView.refreshControl!.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
        transactionTableView.delegate = self
        transactionTableView.dataSource = self
    }
    
    private func fetchTransactions() {
        let params = [
            URLQueryItem(name: "current_month", value: String(true))
        ]
        
        APICaller.shared.getTransactions(params: params) { result in
            switch result {
            case .success(let data):
                self.transactions = data.transactions!
                DispatchQueue.main.async {
                    self.currentBalanceAmountLabel.text = data.balance!
                    self.incomeAmountLabel.text = data.income!
                    self.expenseAmountLabel.text = data.expense!
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
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
