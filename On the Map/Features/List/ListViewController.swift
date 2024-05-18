//
//  ListViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    private lazy var listView: ListView = {
        return ListView()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = listView
    }
    
    public func setData(with locations: [StudentLocation]) {
        listView.setup(with: locations)
    }
}
