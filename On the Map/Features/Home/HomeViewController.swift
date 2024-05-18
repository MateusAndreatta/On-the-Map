//
//  HomeViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit

class HomeViewController: UITabBarController {
    
    private let viewModel: HomeViewModel
    
    private lazy var mapViewController: MapViewController = {
        let mapViewController = MapViewController()
        return mapViewController
    }()
    
    private lazy var listViewController: ListViewController = {
        let listViewController = ListViewController()
        return listViewController
    }()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupNavigationBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "On The Map"
        setupTabBar()
        loadData()
    }
    
    private func setupNavigationBar() {
        let refreshItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise"), style: .plain, target: self, action: #selector(refreshItemDidTap))
        let logoutItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(logoutItemDidTap))
        let pinItem = UIBarButtonItem(image: UIImage(systemName: "mappin.and.ellipse"), style: .plain, target: self, action: #selector(pinItemDidTap))

        navigationItem.rightBarButtonItems = [pinItem, refreshItem]
        navigationItem.leftBarButtonItem = logoutItem
    }
    
    private func setupTabBar() {
        setViewControllers([mapViewController, listViewController], animated: true)
        tabBar.backgroundColor = .white
        
        guard let items = tabBar.items else { return }
        items[0].image = UIImage(systemName: "map")
        items[1].image = UIImage(systemName: "list.bullet")
    }
    
    private func loadData() {
        viewModel.loadStudentLocations { [weak self] success in
            DispatchQueue.main.async {
                if success {
                    self?.setViewControllersData()
                } else {
                    self?.showAlert(title: "Error", message: "Unable to fetch location data")
                }
            }
        }
    }
    
    private func setViewControllersData() {
        mapViewController.setData(with: viewModel.locationData)
        listViewController.setData(with: viewModel.locationData)
    }
    
    @objc
    private func refreshItemDidTap() {
        loadData()
    }
    
    @objc
    private func pinItemDidTap() {
        navigationController?.pushViewController(PostLocationViewController(viewModel: PostLocationViewModel()), animated: true)
    }
    
    @objc
    private func logoutItemDidTap() {
        UdacityAPI.logout()
        navigationController?.popToRootViewController(animated: true)
    }
    
}
