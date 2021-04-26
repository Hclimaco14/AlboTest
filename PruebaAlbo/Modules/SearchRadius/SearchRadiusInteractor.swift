//
//  SearchRadiusInteractor.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//  
//

import Foundation
import CoreLocation

class SearchRadiusInteractor: SearchRadiusInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: SearchRadiusInteractorOutputProtocol?
    let services = ServicesManager()
    
    func serchAirport(sender: Any?) {
        guard let distance = sender as? Int else { return }
        LocationAlbo.share.validateLocationPermissions() { (location) in
            self.services.airportSearch(distance: distance, location: location, loadFromFile: true){ (response, error) in
                if let res  =  response {
                    self.presenter?.airportResult(result: res,location: location)
                }
            }
        }
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
