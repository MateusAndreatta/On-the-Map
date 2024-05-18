//
//  MapView.swift
//  On the Map
//
//  Created by Mateus Andreatta on 11/05/24.
//

import Foundation
import UIKit
import MapKit

protocol MapViewDelegate: AnyObject {
    func setupPins(with: StudentLocationResponse)
}

class MapView: UIView {
    
    private lazy var mkMapView: MKMapView = {
        let mkMapView = MKMapView()
        mkMapView.translatesAutoresizingMaskIntoConstraints = false
        mkMapView.delegate = self
        return mkMapView
    }()

    init() {
        super.init(frame: .zero)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        addSubview(mkMapView)

        NSLayoutConstraint.activate([
            mkMapView.topAnchor.constraint(equalTo: topAnchor),
            mkMapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mkMapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mkMapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    public func setup(with locations: [StudentLocation]) {
        var annotations = [MKPointAnnotation]()
        for location in locations {
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
            annotation.title = "\(location.firstName) \(location.lastName)"
            annotation.subtitle = location.mediaURL

            annotations.append(annotation)
        }
        mkMapView.addAnnotations(annotations)
    }
    
}

extension MapView: MKMapViewDelegate {
    
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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            if let toOpen = view.annotation?.subtitle {
                guard let stringUrl = toOpen, let url = URL(string: stringUrl) else { return }
                UIApplication.shared.open(url)
            }
        }
    }
}
