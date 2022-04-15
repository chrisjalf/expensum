//
//  ViewController.swift
//  Expensum
//
//  Created by Chris James on 17/03/2022.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background1")
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc1.title = "Home"
        
        let vc2 = UINavigationController(rootViewController: TransactionsViewController())
        vc2.tabBarItem.image = UIImage(systemName: "arrow.left.arrow.right")
        vc2.title = "Transactions"
        
        let vc3 = UINavigationController(rootViewController: TransactionAddViewController())
        vc3.tabBarItem.image = UIImage(systemName: "plus.app.fill")?.resize(70, 70)
        //vc3.tabBarController?.tabBar.items?[0].title = "" or vc3.title
        
        let vc4 = UINavigationController(rootViewController: ChartViewController())
        vc4.tabBarItem.image = UIImage(systemName: "chart.pie.fill")
        vc4.title = "Chart"
        
        let vc5 = UINavigationController(rootViewController: ProfileViewController())
        vc5.tabBarItem.image = UIImage(systemName: "person.fill")
        vc5.title = "Profile"
        
        tabBar.backgroundColor = UIColor(named: "Background2")
        tabBar.tintColor = UIColor(named: "Color1")
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
        self.delegate = self
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       get {
          return .portrait
       }
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if tabBarController.selectedIndex == 2 {
            let vc = tabBarController.selectedViewController
            vc?.loadView()
        }
        
        return true
    }
}
