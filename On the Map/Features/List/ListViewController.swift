//
//  ListViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit

class ListViewController: UIViewController {
    
    private let viewModel: ListViewModel = ListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    public func setData(with locations: [StudentLocation]) {
        viewModel.updateData(with: locations)
        tableView.reloadData()
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLocation = viewModel.locationData[indexPath.row]
        guard let url = URL(string: selectedLocation.mediaURL) else { return }
        UIApplication.shared.open(url)
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.locationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "LocationTableViewCell")
        cell.textLabel?.text = "\(viewModel.locationData[indexPath.row].firstName) \(viewModel.locationData[indexPath.row].lastName)"
        cell.imageView?.image = UIImage(systemName: "link")
        return cell
    }
    
}
