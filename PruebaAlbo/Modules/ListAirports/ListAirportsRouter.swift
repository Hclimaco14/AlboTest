//
//  ListAirportsRouter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//  
//

import Foundation
import UIKit

class ListAirportsRouter: ListAirportsRouterProtocol {

     fileprivate weak var coordinator:Coordinator?
      
      init(coordinator:Coordinator?) {
          self.coordinator = coordinator
      }


    class func createListAirportsModule(coordinator:Coordinator? = nil) -> ListAirportsView {
//    class func createListAirportsModule() -> UIViewController {

            let view = ListAirportsView ()
            let presenter: ListAirportsPresenterProtocol & ListAirportsInteractorOutputProtocol = ListAirportsPresenter()
            let interactor: ListAirportsInteractorInputProtocol = ListAirportsInteractor()
//            let router: ListAirportsRouterProtocol = ListAirportsRouter()
            let router: ListAirportsRouterProtocol = ListAirportsRouter(coordinator:coordinator)
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view
       
    }
    
   
    
}
