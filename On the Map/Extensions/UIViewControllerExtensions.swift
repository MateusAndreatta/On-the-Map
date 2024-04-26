//
//  UIViewControllerExtensions.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String, action: String = "OK") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: action, style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
}
