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
    
    func serchAirport(distance: Int, location: CLLocation?) {
        
        self.airporWorker(distance: distance, location: location, loadFromFile: false){ (response) in
            switch response {
            case .success(let response):
                print(response)
                self.presenter?.airportResult(result: response, location: location)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    
    fileprivate func airporWorker(distance:Int,
                                  location:CLLocation?,
                                  loadFromFile:Bool ,
                                  result: @escaping(Result<AirportsResponse, RequestError>) -> Void) {
        
        
        if loadFromFile {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let resp: AirportsResponse = self.services.readLocalFile(forName: "AeroDataBox") else {
                    return result(.failure(RequestError( statusCode: 0,
                                                             description: "Error read local file",
                                                             data: nil)))
                }
                return result(.success(resp))
                
            }
        }
        
        let maximunAirports = 16
        let service = "/airports/search/location/\(location?.coordinate.latitude ?? 0)/\(location?.coordinate.longitude ?? 0)/km/\(distance)/\(maximunAirports)?withFlightInfoOnly=false"
        
        guard let request = NetworkUtils.createRequest(urlString: service, HTTPMethod: .get) else
        { return }
        
        self.services.fetchRequest(with: request,completion: result)
       
        
        
    }
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}
