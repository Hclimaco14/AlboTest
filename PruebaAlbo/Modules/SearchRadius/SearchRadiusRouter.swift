//
//  SearchRadiusRouter.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//  
//

import Foundation
import UIKit
import CoreLocation

class SearchRadiusRouter: SearchRadiusRouterProtocol {
    

     fileprivate weak var coordinator:Coordinator?
      
      init(coordinator:Coordinator?) {
          self.coordinator = coordinator
      }


    class func createSearchRadiusModule(coordinator:Coordinator? = nil) -> SearchRadiusView {

            let view = SearchRadiusView ()
            let presenter: SearchRadiusPresenterProtocol & SearchRadiusInteractorOutputProtocol = SearchRadiusPresenter()
            let interactor: SearchRadiusInteractorInputProtocol = SearchRadiusInteractor()
            let router: SearchRadiusRouterProtocol = SearchRadiusRouter(coordinator:coordinator)
            
            view.presenter = presenter
            presenter.view = view
            presenter.router = router
            presenter.interactor = interactor
            interactor.presenter = presenter
            
            return view
       
    }
    
    func goToTabBar(sender: Any?,location:CLLocation?) {
        guard let coor = coordinator as? AppCoordinator else { return }
        coor.tabBar(sender: sender,location: location)
    }
    
    
}
