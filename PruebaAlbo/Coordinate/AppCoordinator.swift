//
//  AppCoordinator.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//


import UIKit
import CoreLocation

class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SearchRadiusRouter.createSearchRadiusModule(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func tabBar(sender: Any? = nil,location:CLLocation?) {
        DispatchQueue.main.async {
            let tabBarController = UITabBarController()
            
            let map = MapAirportsRouter.createMapAirportsModule(coordinator: self)
            map.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName:"location"), tag: 1)
           
            let list = ListAirportsRouter.createListAirportsModule(coordinator: self)
            list.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName:"list.bullet"), tag: 1)
           
            if let airresponse = sender as? AirportsResponse,let listAirports = airresponse.items {
                map.airports = listAirports
                list.airports = listAirports
            }
            
            if let loc = location {
                map.location = loc.coordinate
                list.location = loc.coordinate
            }
            
            tabBarController.viewControllers = [map,list]
            self.navigationController.isNavigationBarHidden = false
            self.navigationController.pushViewController(tabBarController, animated: true)
        }
    }
    
}
