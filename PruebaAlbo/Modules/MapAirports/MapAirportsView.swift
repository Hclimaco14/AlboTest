//
//  MapAirportsView.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//

import UIKit
import CoreLocation
import MapKit

class MapAirportsView: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var airportsMap: MKMapView!
    @IBOutlet weak var centerBtn: UIButton!
    
    // MARK: Properties
    var presenter: MapAirportsPresenterProtocol?
    var airports:[Airport] = []
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D()
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPins()
    }
    
    func loadPins() {
        centerBtn.layer.cornerRadius = 17.5
        centerBtn.backgroundColor = .systemBackground
        
        airportsMap.showsUserLocation = true
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        airportsMap.setRegion(region, animated: true)
        for airport in airports {
            addPin(airport)
        }
    }
    
    func addPin(_ airport:Airport) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = airport.getCoordinate2D()
        annotation.title = "Airport \(airport.shortName ?? "")"
        annotation.subtitle = airport.municipalityName
        airportsMap.addAnnotation(annotation)
    }
    
    @IBAction func centerAction(_ sender: Any) {
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        airportsMap.setRegion(region, animated: true)
    }
    
}

extension MapAirportsView: MapAirportsViewProtocol {
    // TODO: implement view output methods
}

