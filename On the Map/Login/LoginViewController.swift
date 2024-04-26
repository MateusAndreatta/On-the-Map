//
//  LoginViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import UIKit

class LoginViewController: UIViewController {

    private lazy var loginView: UIView = {
        let loginView = LoginView()
        loginView.delegate = self
        return loginView
    }()
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension LoginViewController: LoginViewDelegate {
    func didTapButton(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            // Show an alert if either username or password is empty
            showAlert(title: "Error", message: "Please enter both email and password.")
            return
        }
        
        // Here you can perform login authentication, e.g., check against a database
        if email == "admin" && password == "password" {
            showAlert(title: "Success", message: "Login successful!")
        } else {
            showAlert(title: "Error", message: "Invalid username or password.")
        }
    }
    
}

