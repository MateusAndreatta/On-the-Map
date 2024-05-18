//
//  LoginViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import UIKit

class LoginViewController: UIViewController {

    private let viewModel: LoginViewModel
    
    private lazy var loginView: LoginView = {
        let loginView = LoginView()
        loginView.delegate = self
        return loginView
    }()
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        self.view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
}

extension LoginViewController: LoginViewDelegate {
    func didTapButton(email: String?, password: String?) {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            showAlert(title: "Error", message: "Please enter both email and password.")
            return
        }
        viewModel.login(email: email, password: password) { [weak self] success, errorMessage in
            if success {
                self?.navigationController?.pushViewController(HomeViewController(viewModel: HomeViewModel()), animated: true)
            } else {
                if let errorMessage {
                    self?.showAlert(title: "Error", message: errorMessage)
                } else {
                    self?.showAlert(title: "Error", message: "Please, try again later")
                }
            }
        }
    }
    
}

