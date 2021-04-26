//
//  ListAirportsPresenter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation

class ListAirportsPresenter  {
    
    // MARK: Properties
    weak var view: ListAirportsViewProtocol?
    var interactor: ListAirportsInteractorInputProtocol?
    var router: ListAirportsRouterProtocol?
    
}

extension ListAirportsPresenter: ListAirportsPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
    }
}

extension ListAirportsPresenter: ListAirportsInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
