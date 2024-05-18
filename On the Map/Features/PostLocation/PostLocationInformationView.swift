//
//  PostLocationInformationView.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit

protocol PostLocationInformationViewDelegate: AnyObject {
    func searchFor(location: String?)
}

class PostLocationInformationView: UIView {
    
    weak var delegate: PostLocationInformationViewDelegate?
    
    private lazy var containerStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.axis = .vertical
        stackview.distribution = .fillEqually
        return stackview
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25)
        
        let firstText = "Where are you\n"
        let attributedString = NSMutableAttributedString(string: firstText)
        
        let secondText = "studying\n"
        let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 30)]
        attributedString.append(NSMutableAttributedString(string: secondText, attributes: attrs))

        let thirdText = "today?"
        attributedString.append(NSMutableAttributedString(string: thirdText))
        label.attributedText = attributedString
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your location here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.backgroundColor = .udacityColor
        textField.textAlignment = .center
        textField.textColor = .white
        textField.delegate = self
        return textField
    }()
    
    private lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Find on the map", for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(containerStackView)
        buttonView.addSubview(button)

        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(textField)
        containerStackView.addArrangedSubview(buttonView)
        
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: safeTopAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: safeBottomAnchor),
            
            button.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor)
        ])
    }
    
    @objc
    private func didTapButton() {
        delegate?.searchFor(location: textField.text)
    }
}

extension PostLocationInformationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

