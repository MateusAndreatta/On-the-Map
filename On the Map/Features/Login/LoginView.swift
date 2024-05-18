//
//  LoginView.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import UIKit

protocol LoginViewDelegate: AnyObject {
    func didTapButton(email: String?, password: String?)
}

class LoginView: UIView {
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .init(named: "udacitylogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.isSecureTextEntry = true
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    weak var delegate: LoginViewDelegate?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .udacityColor
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(imageView)
        addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(usernameTextField)
        containerStackView.addArrangedSubview(passwordTextField)
        containerStackView.addArrangedSubview(loginButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeTopAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 128),
            
            containerStackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
        ])
    }
    
    @objc func loginButtonTapped() {
        delegate?.didTapButton(email: usernameTextField.text, password: passwordTextField.text)
     }
    
}

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
