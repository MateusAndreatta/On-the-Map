//
//  PostLocationSubmitView.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit
import MapKit

protocol PostLocationSubmitViewDelegate: AnyObject {
    func submit(link: String?, coordinate: CLLocationCoordinate2D?, search: String?)
}

class PostLocationSubmitView: UIView {
    
    weak var delegate: PostLocationSubmitViewDelegate?
    private var coordinate: CLLocationCoordinate2D?
    private var searchQuery: String?
    
    private lazy var textFieldView: UIView = {
        let textFieldView = UIView()
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        return textFieldView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.attributedPlaceholder = NSAttributedString(string: "Enter a link to share here", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textField.backgroundColor = .udacityColor
        textField.textAlignment = .center
        textField.textColor = .white
        return textField
    }()
    
    private lazy var mkMapView: MKMapView = {
        let mkMapView = MKMapView()
        mkMapView.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.delegate = self
        return mkMapView
    }()
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Find on the map"
        configuration.contentInsets = .init(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.udacityColor, for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
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
        addSubview(textFieldView)
        textFieldView.addSubview(textField)
        addSubview(mkMapView)
        addSubview(button)

        NSLayoutConstraint.activate([
            textFieldView.topAnchor.constraint(equalTo: safeTopAnchor),
            textFieldView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textFieldView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textFieldView.heightAnchor.constraint(equalToConstant: 160),
            
            textField.topAnchor.constraint(equalTo: safeTopAnchor),
            textField.leadingAnchor.constraint(equalTo: textFieldView.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: textFieldView.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: textFieldView.bottomAnchor),
            
            mkMapView.topAnchor.constraint(equalTo: textFieldView.bottomAnchor),
            mkMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mkMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mkMapView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            button.centerXAnchor.constraint(equalTo: centerXAnchor),
            button.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: -60)
        ])
    }
    
    public func searchLocation(for text: String) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = text
        searchQuery = text
        let search = MKLocalSearch(request: searchRequest)
        search.start { [weak self] response, error in
            guard let response = response else {
                return
            }
            if let responseCoordinate = response.mapItems.first?.placemark.location?.coordinate {
                self?.coordinate = responseCoordinate
                let annotation = MKPointAnnotation()
                annotation.coordinate = responseCoordinate
                self?.mkMapView.addAnnotation(annotation)
                self?.mkMapView.setCenter(responseCoordinate, animated: false)
            }
        }
    }
    
    @objc
    private func didTapButton() {
        delegate?.submit(link: textField.text, coordinate: coordinate, search: searchQuery)
    }
}

extension PostLocationSubmitView: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKMarkerAnnotationView {
            annotationView.annotation = annotation
            return annotationView
        }
        let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
        annotationView.canShowCallout = true
        annotationView.markerTintColor = .red
        annotationView.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        return annotationView
    }
}
