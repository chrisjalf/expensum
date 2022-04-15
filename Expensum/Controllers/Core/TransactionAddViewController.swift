//
//  TransactionCreateViewController.swift
//  Expensum
//
//  Created by Chris James on 14/04/2022.
//

import UIKit

class TransactionAddViewController: UIViewController {
    private var categories: [Category] = [Category]()
    
    private var selectedCategoryId: Int?
    
    private let types: [String] = ["Add", "Deduct"]
    
    private var selectedType: String = ""
    
    private var transDate: String = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
        return formatter.string(from: Date())
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionField: CustomTextField = {
        let textField = CustomTextField()
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Type"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Add", "Deduct"])
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor(named: "Background2")!], for: .selected)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = UIColor(named: "Color1")
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.text = "Amount"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let amountField: CustomTextField = {
        let textField = CustomTextField()
        textField.keyboardType = .decimalPad
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let transDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Transaction Date"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let transDatePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .dateAndTime
        picker.maximumDate = Date()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Color1")
        button.setTitle("Add", for: .normal)
        button.setTitleColor(UIColor(named: "Background2"), for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.title = "Add Transaction"
        view.backgroundColor = UIColor(named: "Background1")
        
        setupView()
        applyConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        selectedType = "Add"
        
        transDate = {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:00"
            return formatter.string(from: Date())
        }()
        
        descriptionField.text = ""
        descriptionField.endEditing(true)
        
        categoryCollectionView.reloadData()
        
        typeSegmentedControl.selectedSegmentIndex = 0
        
        amountField.text = ""
        amountField.endEditing(true)
        
        transDatePicker.date = Date()
        
        fetchCategories()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        categoryCollectionView.delegate = self
        categoryCollectionView.dataSource = self
        
        typeSegmentedControl.addTarget(self, action: #selector(didSelectType), for: .valueChanged)
        
        amountField.delegate = self
    
        transDatePicker.addTarget(self, action: #selector(didSelectTransDate), for: .valueChanged)
        
        addButton.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
    }
    
    private func setupView() {
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionField)
        view.addSubview(categoryLabel)
        view.addSubview(categoryCollectionView)
        view.addSubview(typeLabel)
        view.addSubview(typeSegmentedControl)
        view.addSubview(amountLabel)
        view.addSubview(amountField)
        view.addSubview(transDateLabel)
        view.addSubview(transDatePicker)
        view.addSubview(addButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // descriptionLabel
            descriptionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // descriptionField
            descriptionField.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionField.heightAnchor.constraint(equalToConstant: 50),
            
            // categoryLabel
            categoryLabel.topAnchor.constraint(equalTo: descriptionField.bottomAnchor, constant: 20),
            categoryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // categoryCollectionView
            categoryCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 50),
            
            // typeLabel
            typeLabel.topAnchor.constraint(equalTo: categoryCollectionView.bottomAnchor, constant: 20),
            typeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // typeSegmentedControl
            typeSegmentedControl.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            typeSegmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            typeSegmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // amountLabel
            amountLabel.topAnchor.constraint(equalTo: typeSegmentedControl.bottomAnchor, constant: 20),
            amountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // amountField
            amountField.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 5),
            amountField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            amountField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            // transDateLabel
            transDateLabel.topAnchor.constraint(equalTo: amountField.bottomAnchor, constant: 20),
            transDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // transDatePicker
            transDatePicker.topAnchor.constraint(equalTo: transDateLabel.bottomAnchor, constant: 5),
            transDatePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            // addButton
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: 50)
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
    
    @objc private func didSelectType(_ sender: UISegmentedControl) {
        selectedType = types[sender.selectedSegmentIndex]
    }
    
    @objc private func didSelectTransDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        transDate = formatter.string(from: sender.date)
    }
    
    @objc private func didTapAddButton(_ sender: UIButton) {
        var params: [URLQueryItem] = [URLQueryItem]()
        
        if let description = descriptionField.text {
            params.append(
                URLQueryItem(name: "description", value: description)
            )
        }
        
        if let cat_id = selectedCategoryId {
            params.append(
                URLQueryItem(name: "cat_id", value: String(cat_id))
            )
        }
        
        params.append(URLQueryItem(name: "type", value: selectedType))
        
        if let amount = amountField.text {
            params.append(
                URLQueryItem(name: "amount", value: String(amount))
            )
        }
        
        params.append(URLQueryItem(name: "trans_date", value: transDate))
        
        APICaller.shared.addTransaction(params: params) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tabBarController?.selectedIndex = 1
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
}

extension TransactionAddViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: categories[indexPath.row].name.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]).width + 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        selectedCategoryId = categories[indexPath.row].id
        
        return true
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

extension TransactionAddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == amountField {
            guard let oldText = textField.text, let r = Range(range, in: oldText) else { return true }

            let newText = oldText.replacingCharacters(in: r, with: string)
            let isNumeric = newText.isEmpty || (Double(newText) != nil)
            let numberOfDots = newText.components(separatedBy: ".").count - 1
            let numberOfDecimalDigits: Int
            
            if let dotIndex = newText.firstIndex(of: ".") {
                numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
            } else {
                numberOfDecimalDigits = 0
            }

            return isNumeric && numberOfDots <= 1 && numberOfDecimalDigits <= 2
        } else {
            return true
        }
    }
}
