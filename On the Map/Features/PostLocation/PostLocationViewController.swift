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
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [postLocationInformationView, postLocationSubmitView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
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
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.isHidden = true
        return indicator
    }()
    
    init(viewModel: PostLocationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        title = "Add Location"
        setupNavigationBar()
        setupConstraints()
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
    
    private func setupConstraints() {
        view.addSubview(containerView)
        containerView.addSubview(contentStackView)
        containerView.addSubview(activityIndicator)
        containerView.setupToSuperview()
        contentStackView.setupToSuperview()
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func showSubmitView() {
        postLocationInformationView.isHidden = true
        postLocationSubmitView.isHidden = false
    }
    
    @objc
    private func cancelDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    private func showSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
    }

    private func hideSpinner() {
        activityIndicator.startAnimating()
        activityIndicator.isHidden = true
    }
}

extension PostLocationViewController: PostLocationInformationViewDelegate {
    
    func searchFor(location: String?) {
        guard let location, !location.isEmpty else {
            showAlert(title: "Ops", message: "You should fill the location field")
            return
        }
        postLocationSubmitView.searchLocation(for: location)
        showSpinner()
        showSubmitView()
    }
    
}

extension PostLocationViewController: PostLocationSubmitViewDelegate {
    
    func geocodeDidFinish(success: Bool) {
        if !success {
            showAlert(title: "Error", message: "Unable to get your geocoding information, please try again.")
        }
        hideSpinner()
    }
    
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
