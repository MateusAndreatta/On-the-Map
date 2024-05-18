//
//  MapViewController.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import UIKit

class MapViewController: UIViewController {
    
    private lazy var mapView: MapView = {
        let mapView = MapView()
        return mapView
    }()
    
    override func loadView() {
        super.loadView()
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    public func setData(with locations: [StudentLocation]) {
        mapView.setup(with: locations)
    }
    
}
