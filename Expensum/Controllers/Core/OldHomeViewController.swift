//
//  HomeViewController.swift
//  Expensum
//
//  Created by Chris James on 17/03/2022.
//

import UIKit
import Combine

class OldHomeViewController: UIViewController {
    var characters = ["Link", "Zelda", "Ganondorf", "Midna"]
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let homeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Expense", "Income"])
        segmentedControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = .systemIndigo
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let cardOne: UIView = {
        let uiView = UIView()
        uiView.backgroundColor = .white
        uiView.layer.cornerRadius = 30
        uiView.layer.cornerCurve = .continuous
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowOpacity = 0.1
        uiView.layer.shadowOffset = CGSize(width: 0, height: 5)
        uiView.layer.shadowRadius = 10
        uiView.layer.masksToBounds = false
        uiView.translatesAutoresizingMaskIntoConstraints = false
        return uiView
    }()
    
    private let labelOne: UILabel = {
        let label = UILabel()
        label.text = "Savings"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "$7,456.00"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressOne: CustomProgressBar = {
        let progressBar = CustomProgressBar()
        progressBar.progress = 0.7
        progressBar.backgroundColor = .opaqueSeparator
        progressBar.color = .systemTeal
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private let labelThree: UILabel = {
        let label = UILabel()
        label.text = "Earned"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelFour: UILabel = {
        let label = UILabel()
        label.text = "$10,500.00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let progressTwo: CustomProgressBar = {
        let progressBar = CustomProgressBar()
        progressBar.progress = 0.25
        progressBar.backgroundColor = .opaqueSeparator
        progressBar.color = .systemPink
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        return progressBar
    }()
    
    private let labelFive: UILabel = {
        let label = UILabel()
        label.text = "Spend"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSix: UILabel = {
        let label = UILabel()
        label.text = "$10,500.00"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let labelSeven: UILabel = {
        let label = UILabel()
        label.text = "Top Spending"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let topSpendingTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        //table.separatorStyle = .none
        
        //table.rowHeight = 50
        
        table.isScrollEnabled = false
        
        /*table.insetsContentViewsToSafeArea = false
        table.sectionHeaderHeight = 10
        table.sectionFooterHeight = 10*/
        
        table.register(UITableViewCell.self, forCellReuseIdentifier: "topSpendingCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let labelEight: UILabel = {
        let label = UILabel()
        label.text = "Monthly Budget"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let monthlyBudgetCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection  = .horizontal
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .clear
        collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "monthlyBudgetCell")
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private var tokens: Set<AnyCancellable> = []
    private var topSpendingTableHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Home"
        
        setupView()

        setupNavBarAppearance()

        applyConstraints()
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(homeSegmentedControl)
        scrollView.addSubview(cardOne)
        
        cardOne.addSubview(labelOne)
        cardOne.addSubview(labelTwo)
        cardOne.addSubview(progressOne)
        cardOne.addSubview(progressTwo)
        
        progressOne.addSubview(labelThree)
        progressOne.addSubview(labelFour)
        
        progressTwo.addSubview(labelFive)
        progressTwo.addSubview(labelSix)
        
        scrollView.addSubview(labelSeven)
        scrollView.addSubview(topSpendingTable)
        scrollView.addSubview(labelEight)
        scrollView.addSubview(monthlyBudgetCollection)
        
        topSpendingTable.delegate = self
        topSpendingTable.dataSource = self
        topSpendingTableHeight = topSpendingTable.heightAnchor.constraint(equalToConstant: 100)
        
        // Subscribe to table view changes
        topSpendingTable.publisher(for: \.contentSize)
            .sink { contentSize in
                self.topSpendingTableHeight.constant = contentSize.height
            }
            .store(in: &tokens)
        
        monthlyBudgetCollection.delegate = self
        monthlyBudgetCollection.dataSource = self
    }
    
    private func setupNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemIndigo
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // scrollView
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // homeSegmentedControl
            homeSegmentedControl.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 20),
            homeSegmentedControl.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            homeSegmentedControl.widthAnchor.constraint(equalToConstant: 350),
            
            // cardOne
            cardOne.topAnchor.constraint(equalTo: homeSegmentedControl.bottomAnchor, constant: 20),
            cardOne.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            //cardOne.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor, constant: -20),
            cardOne.widthAnchor.constraint(equalToConstant: 350),
            //cardOne.heightAnchor.constraint(equalToConstant: 250),
            
            // labelOne
            labelOne.topAnchor.constraint(equalTo: cardOne.topAnchor, constant: 30),
            labelOne.leadingAnchor.constraint(equalTo: cardOne.leadingAnchor, constant: 30),

            // labelTwo
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor, constant: 15),
            labelTwo.leadingAnchor.constraint(equalTo: cardOne.leadingAnchor, constant: 30),
            
            // progressOne
            progressOne.topAnchor.constraint(equalTo: labelTwo.bottomAnchor, constant: 30),
            progressOne.leadingAnchor.constraint(equalTo: cardOne.leadingAnchor, constant: 30),
            progressOne.trailingAnchor.constraint(equalTo: cardOne.trailingAnchor, constant: -30),
            progressOne.heightAnchor.constraint(equalToConstant: 25),
            
            // labelThree
            labelThree.leadingAnchor.constraint(equalTo: progressOne.leadingAnchor, constant: 15),
            labelThree.centerYAnchor.constraint(equalTo: progressOne.centerYAnchor),
            
            // labelFour
            labelFour.trailingAnchor.constraint(equalTo: progressOne.trailingAnchor, constant: -15),
            labelFour.centerYAnchor.constraint(equalTo: progressOne.centerYAnchor),
            
            // progressTwo
            progressTwo.topAnchor.constraint(equalTo: progressOne.bottomAnchor, constant: 15),
            progressTwo.leadingAnchor.constraint(equalTo: cardOne.leadingAnchor, constant: 30),
            progressTwo.trailingAnchor.constraint(equalTo: cardOne.trailingAnchor, constant: -30),
            progressTwo.bottomAnchor.constraint(equalTo: cardOne.bottomAnchor, constant: -30),
            progressTwo.heightAnchor.constraint(equalToConstant: 25),
            
            // labelFive
            labelFive.leadingAnchor.constraint(equalTo: progressTwo.leadingAnchor, constant: 15),
            labelFive.centerYAnchor.constraint(equalTo: progressTwo.centerYAnchor),
            
            // labelSix
            labelSix.trailingAnchor.constraint(equalTo: progressTwo.trailingAnchor, constant: -15),
            labelSix.centerYAnchor.constraint(equalTo: progressTwo.centerYAnchor),
            
            // labelSeven
            labelSeven.topAnchor.constraint(equalTo: cardOne.bottomAnchor, constant: 20),
            labelSeven.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // topSpendingTable
            topSpendingTable.topAnchor.constraint(equalTo: labelSeven.bottomAnchor, constant: 20),
            topSpendingTable.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            topSpendingTable.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            topSpendingTableHeight,
            
            // labelSeven
            labelEight.topAnchor.constraint(equalTo: topSpendingTable.bottomAnchor, constant: 20),
            labelEight.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            
            // monthlyBudgetCollection
            monthlyBudgetCollection.topAnchor.constraint(equalTo: labelEight.bottomAnchor, constant: 20),
            monthlyBudgetCollection.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor),
            monthlyBudgetCollection.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor),
            monthlyBudgetCollection.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            monthlyBudgetCollection.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
}


extension OldHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topSpendingCell", for: indexPath)
        cell.textLabel?.text = characters[indexPath.section]
        cell.backgroundColor = .white
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 1
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }*/
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights: [CGFloat] = [50, 100, 30, 70]
        
        return heights[indexPath.section]
    }
}

extension OldHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let view: UIView = {
            let view = UIView()
            view.backgroundColor = UIColor(red: 0.91, green: 0.97, blue: 1.00, alpha: 1.00)
            view.layer.cornerRadius = 25
            return view
        }()
        
        let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.tintColor = .systemTeal
            imageView.image = UIImage(systemName: "house.fill")
            imageView.contentMode = .scaleAspectFill
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()
        
        view.addSubview(imageView)
        imageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "monthlyBudgetCell", for: indexPath)
        cell.addSubview(view)
        view.frame = cell.bounds
        return cell
    }
}
