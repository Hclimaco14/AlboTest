//
//  MapAirportsRouter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation
import UIKit

class MapAirportsRouter: MapAirportsRouterProtocol {

     fileprivate weak var coordinator:Coordinator?
      
      init(coordinator:Coordinator?) {
          self.coordinator = coordinator
      }


    class func createMapAirportsModule(coordinator:Coordinator? = nil) -> MapAirportsView {
//    class func createMapAirportsModule() -> UIViewController {

            let view = MapAirportsView ()
            let presenter: MapAirportsPresenterProtocol & MapAirportsInteractorOutputProtocol = MapAirportsPresenter()
            let interactor: MapAirportsInteractorInputProtocol = MapAirportsInteractor()
//            let router: MapAirportsRouterProtocol = MapAirportsRouter()
            let router: MapAirportsRouterProtocol = MapAirportsRouter(coordinator:coordinator)
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view
       
    }
    
   
    
}
