//
//  MapAirportsPresenter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation

class MapAirportsPresenter  {
    
    // MARK: Properties
    weak var view: MapAirportsViewProtocol?
    var interactor: MapAirportsInteractorInputProtocol?
    var router: MapAirportsRouterProtocol?
    
}

extension MapAirportsPresenter: MapAirportsPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension MapAirportsPresenter: MapAirportsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
