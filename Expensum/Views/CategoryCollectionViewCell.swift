//
//  CategoryCollectionViewCell.swift
//  Expensum
//
//  Created by Chris James on 12/04/2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private var categoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Background1")
        button.setTitleColor(UIColor(named: "Color1"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "Color1")!.cgColor
        button.layer.cornerRadius = 15
        button.isUserInteractionEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override var isSelected: Bool {
        didSet {
          if self.isSelected {
              // This block will be executed whenever the cell’s selection state is set to true (i.e For the selected cell)
              categoryButton.backgroundColor = UIColor(named: "Color1")
              categoryButton.setTitleColor(UIColor(named: "Background2"), for: .normal)
          } else {
              // This block will be executed whenever the cell’s selection state is set to false (i.e For the rest of the cells)
              categoryButton.backgroundColor = UIColor(named: "Background1")
              categoryButton.setTitleColor(UIColor(named: "Color1"), for: .normal)
          }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(categoryButton)
        
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            // categoryButton
            categoryButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            categoryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    public func configure(with category: String) {
        categoryButton.setTitle(category, for: .normal)
    }
}

extension CategoryCollectionViewCell {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
       if #available(iOS 13.0, *) {
           if (traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection)) {
               categoryButton.layer.borderColor = UIColor(named: "Color1")!.cgColor
           }
       }
    }
}
