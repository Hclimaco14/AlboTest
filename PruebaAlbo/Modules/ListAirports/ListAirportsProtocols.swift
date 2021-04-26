//
//  ListAirportsProtocols.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation
import UIKit

protocol ListAirportsViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: ListAirportsPresenterProtocol? { get set }
}

protocol ListAirportsRouterProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createListAirportsModule(coordinator:Coordinator?) -> ListAirportsView
//    static func createListAirportsModule() -> UIViewController
}

protocol ListAirportsPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: ListAirportsViewProtocol? { get set }
    var interactor: ListAirportsInteractorInputProtocol? { get set }
    var router: ListAirportsRouterProtocol? { get set }
    
    func viewDidLoad()
}

protocol ListAirportsInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol ListAirportsInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: ListAirportsInteractorOutputProtocol? { get set }
}
