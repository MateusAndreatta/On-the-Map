//
//  PostLocationViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit
import MapKit

class PostLocationViewController: UIViewController {
    private let viewModel: PostLocationViewModel
    
    private lazy var containerView: UIStackView = {
        return UIStackView(arrangedSubviews: [postLocationInformationView, postLocationSubmitView])
    }()
    
    private lazy var postLocationInformationView: PostLocationInformationView = {
        let postLocationInformationView = PostLocationInformationView()
        postLocationInformationView.delegate = self
        return postLocationInformationView
    }()
    
    private lazy var postLocationSubmitView: PostLocationSubmitView = {
        let postLocationSubmitView = PostLocationSubmitView()
        postLocationSubmitView.isHidden = true
        postLocationSubmitView.delegate = self
        return postLocationSubmitView
    }()
    
    init(viewModel: PostLocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view = containerView
        title = "Add Location"
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func setupNavigationBar() {
        let cancelItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDidTap))
        navigationItem.rightBarButtonItem = cancelItem
    }
    
    private func showSubmitView() {
        postLocationInformationView.isHidden = true
        postLocationSubmitView.isHidden = false
    }
    
    @objc
    private func cancelDidTap() {
        navigationController?.popViewController(animated: true)
    }
}

extension PostLocationViewController: PostLocationInformationViewDelegate {
    
    func searchFor(location: String?) {
        guard let location, !location.isEmpty else {
            showAlert(title: "Ops", message: "You should fill the location field")
            return
        }
        postLocationSubmitView.searchLocation(for: location)
        showSubmitView()
    }
    
}


extension PostLocationViewController: PostLocationSubmitViewDelegate {
    
    func submit(link: String?, coordinate: CLLocationCoordinate2D?, search: String?) {
        guard let link, !link.isEmpty else {
            showAlert(title: "Ops", message: "You should fill the link field")
            return
        }
        guard let latitude = coordinate?.latitude,
              let longitude = coordinate?.longitude,
              let search = search else {
            showAlert(title: "Error", message: "Unable to get your location information data, please try again.")
            return
        }
        
        viewModel.submitStudentLocationData(link: link, search: search, latitude: latitude, longitude: longitude) { [weak self] (success, error) in
            if success ?? false {
                self?.navigationController?.popViewController(animated: true)
                return
            }
            self?.showAlert(title: "Error", message: "Unable to save your location, please try again.")
        }
    }
    

}
