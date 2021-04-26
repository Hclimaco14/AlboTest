//
//  Coordinator.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//


import UIKit

protocol Coordinator:AnyObject {
    var navigationController:UINavigationController { get set }
    var childCoordinators:[Coordinator] { get set }
    func start()
}

