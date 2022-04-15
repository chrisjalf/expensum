//
//  LoginViewController.swift
//  Expensum
//
//  Created by Chris James on 17/03/2022.
//

import UIKit

class LoginViewController: UIViewController {
    private let expensumLabel: UILabel = {
        let label = UILabel()
        label.text = "Expensum"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Email"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.layer.cornerRadius = 5
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "Color1")
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor(named: "Background2"), for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "Background1")

        view.addSubview(expensumLabel)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)

        applyConstraints()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        loginButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    private func applyConstraints() {
        let expensumLabelConstraints = [
            expensumLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            expensumLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let textFieldConstraints = [
            emailField.topAnchor.constraint(equalTo: expensumLabel.bottomAnchor, constant: 100),
            emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            emailField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            emailField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.leadingAnchor.constraint(equalTo: emailField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: emailField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        let buttonConstraints = [
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 16),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(expensumLabelConstraints)
        NSLayoutConstraint.activate(textFieldConstraints)
        NSLayoutConstraint.activate(buttonConstraints)
    }
    
    @objc private func didTapButton() {
        guard let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            self.errorAlertBox(message: "Incomplete fields")
            return
        }
        
        APICaller.shared.login(email: email, password: password) { result in
            switch result {
            case .success(_):
                self.goToHomeScreen()
            case .failure(let error):
                self.errorAlertBox(message: error.localizedDescription)
            }
        }
    }

    private func goToHomeScreen() {
        DispatchQueue.main.async {
            let vc = MainTabBarViewController()
            vc.modalTransitionStyle = .flipHorizontal
            vc.modalPresentationStyle = .fullScreen
            
            self.present(vc, animated: true, completion: nil)
        }
    }
}
