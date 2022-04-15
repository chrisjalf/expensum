//
//  UIImage.swift
//  Expensum
//
//  Created by Chris James on 27/03/2022.
//

import UIKit

extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
    
    func resize(_ width: CGFloat, _ height:CGFloat) -> UIImage? {
        let widthRatio  = width / size.width
        let heightRatio = height / size.height
        let ratio = widthRatio > heightRatio ? heightRatio : widthRatio
        let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}

extension UIImageView {
    func setCategoryIcon(_ categoryIcon: UIImageView, category: String) -> UIImageView {
        var image: UIImage!
        var backgroundColor: UIColor!
        
        switch category {
        case "Housing":
            image = UIImage(systemName: "house.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemTeal)
            backgroundColor = .systemTeal.withAlphaComponent(0.3)
        case "Transportation":
            image = UIImage(systemName: "car.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.magenta)
            backgroundColor = .magenta.withAlphaComponent(0.3)
        case "Food":
            image = UIImage(systemName: "fork.knife")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemRed)
            backgroundColor = .systemRed.withAlphaComponent(0.3)
        case "Utilities":
            image = UIImage(systemName: "bolt.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemYellow)
            backgroundColor = .systemYellow.withAlphaComponent(0.3)
        case "Medical & Insurance":
            image = UIImage(systemName: "cross.case.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemBrown)
            backgroundColor = .systemBrown.withAlphaComponent(0.3)
        case "Entertainment":
            image = UIImage(systemName: "gamecontroller.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemGray)
            backgroundColor = .systemGray.withAlphaComponent(0.3)
        case "Savings & Investments":
            image = UIImage(systemName: "dollarsign.square.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemGreen)
            backgroundColor = .systemGreen.withAlphaComponent(0.3)
        case "Clothing":
            image = UIImage(systemName: "tshirt.fill")
            image = image?.imageWithInsets(insets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))?.withTintColor(.systemOrange)
            backgroundColor = .systemOrange.withAlphaComponent(0.3)
        default:
            break
        }
        
        categoryIcon.image = image
        categoryIcon.backgroundColor = backgroundColor
        
        return categoryIcon
    }
}

extension UIViewController {
    func goToLoginScreen() {
        KeychainHelper.standard.delete(service: "access_token", account: "expensum")
        
        DispatchQueue.main.async {
            let vc = LoginViewController()
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    func errorAlertBox(message: String) {
        // Test alert box
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension Formatter {
    static let year: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY"
        return formatter
    }()
    
    static let monthMedium: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }()
    
    static let hour12: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h"
        return formatter
    }()
    
    static let minute0x: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    
    static let amPM: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a"
        return formatter
    }()
}

extension Date {
    var year: String { return Formatter.year.string(from: self) }
    var monthMedium: String { return Formatter.monthMedium.string(from: self) }
    var hour12: String { return Formatter.hour12.string(from: self) }
    var minute0x: String { return Formatter.minute0x.string(from: self) }
    var amPM: String { return Formatter.amPM.string(from: self) }
}
