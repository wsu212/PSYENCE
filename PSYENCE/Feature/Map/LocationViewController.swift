//
//  LocationViewController.swift
//  PSYENCE
//
//  Created by Wei-Lun Su on 2021/10/20.
//

import UIKit
import MapKit

class LocationViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        return mapView
    }()
    
    private var viewModel: LocationViewModelType
    
    // MARK: - Initializer
        
    init(viewModel: LocationViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()
        configureConstraints()
        configureBindings()
        
        viewModel.findLocation()
    }
    
    // MARK: - Private Helper Methods
    
    private func configureSubviews() {
        view.addSubview(mapView)
    }
    
    private func configureConstraints() {
        mapView.pin(to: view)
    }
    
    private func configureBindings() {
        viewModel.didFindLocation = { [weak self] location, meters in
            self?.zoom(to: location, with: meters)
            self?.dropPin(on: location)
        }
        
        viewModel.didAccessProfile = { [weak self] name in
            self?.presentProfileView(name)
        }
    }
    
    private func zoom(to location: CLLocation, with meters: CLLocationDistance) {
        let viewRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: meters,
            longitudinalMeters: meters
        )
        mapView.setRegion(viewRegion, animated: true)
    }
    
    private func dropPin(on location: CLLocation) {
        let coordinate: CLLocationCoordinate2D = .init(
            latitude: location.coordinate.latitude,
            longitude: location.coordinate.longitude
        )
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }
    
    private func presentProfileView(_ name: String) {
        print("**** \(name)")
    }
}

extension LocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        viewModel.accessProfile()
    }
}
