//
//  SearchRadiusPresenter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//  
//

import Foundation
import CoreLocation

class SearchRadiusPresenter  {
    
    // MARK: Properties
    weak var view: SearchRadiusViewProtocol?
    var interactor: SearchRadiusInteractorInputProtocol?
    var router: SearchRadiusRouterProtocol?
    
}

extension SearchRadiusPresenter: SearchRadiusPresenterProtocol {

    
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
    
    func serchAirport(distance: Int, location: CLLocation?) {
        
        interactor?.serchAirport(distance: distance, location: location)
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
}

extension SearchRadiusPresenter: SearchRadiusInteractorOutputProtocol {
    func airportResult(result: Any?,location:CLLocation?) {
        router?.goToTabBar(sender: result,location: location)
    }
    
}
