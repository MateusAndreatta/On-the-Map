//
//  UIViewExtensions.swift
//  On the Map
//
//  Created by Mateus Andreatta on 26/04/24.
//

import UIKit

extension UIView {
    func setupToSuperview() {
        guard let superview else { return }
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
        ])
    }
    
    public var safeTopAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.topAnchor
    }
    
    public var safeBottomAnchor: NSLayoutYAxisAnchor {
        return self.safeAreaLayoutGuide.bottomAnchor
    }
    
//    func showAlert(title: String, message: String) {
//       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
//       alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//       present(alertController, animated: true, completion: nil)
//   }
    
}
