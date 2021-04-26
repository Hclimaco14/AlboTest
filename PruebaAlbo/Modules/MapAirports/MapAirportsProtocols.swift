//
//  MapAirportsProtocols.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation
import UIKit

protocol MapAirportsViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: MapAirportsPresenterProtocol? { get set }
}

protocol MapAirportsRouterProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMapAirportsModule(coordinator:Coordinator?) -> MapAirportsView
//    static func createMapAirportsModule() -> UIViewController
}

protocol MapAirportsPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MapAirportsViewProtocol? { get set }
    var interactor: MapAirportsInteractorInputProtocol? { get set }
    var router: MapAirportsRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol MapAirportsInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol MapAirportsInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MapAirportsInteractorOutputProtocol? { get set }
}
