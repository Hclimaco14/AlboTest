//
//  SearchRadiusProtocols.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//  
//

import Foundation
import UIKit
import CoreLocation

protocol SearchRadiusViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: SearchRadiusPresenterProtocol? { get set }
}

protocol SearchRadiusRouterProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createSearchRadiusModule(coordinator:Coordinator?) -> SearchRadiusView
    func goToTabBar(sender: Any?,location:CLLocation?)
}

protocol SearchRadiusPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: SearchRadiusViewProtocol? { get set }
    var interactor: SearchRadiusInteractorInputProtocol? { get set }
    var router: SearchRadiusRouterProtocol? { get set }
    
    func viewDidLoad()
    func serchAirport(distance: Int, location: CLLocation?)
    func showLoading()
    func hideLoading()
}

protocol SearchRadiusInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func airportResult(result:Any?,location:CLLocation?)
    func showLoading()
    func hideLoading()

}

protocol SearchRadiusInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: SearchRadiusInteractorOutputProtocol? { get set }
    func serchAirport(distance: Int, location: CLLocation?)
    func showLoading()
    func hideLoading()
}
