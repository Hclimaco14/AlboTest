//
//  DeviceLocation.swift
//
//  Created by Hector Climaco on 23/04/21.
//

import UIKit
import CoreLocation


class DeviceLocation:NSObject {
    public static let Share = DeviceLocation()
    public var locationManager =  CLLocationManager()
    public var currentLocation = CLLocation()
    public var changeAuthorization:(()->Void)? = nil
    
    override init() {
        super.init()
    }
    
    
    public func configure() {
        DeviceLocation.Share.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        DeviceLocation.Share.locationManager.delegate = self
    }
    
    public class func validateLocationPermissions(viewController: UIViewController? = nil ) -> Bool {
        
        print("validateLocationPermissions...")
        
        switch  CLLocationManager.authorizationStatus() {
            
        case .authorizedAlways,.authorizedWhenInUse:
            #if DEBUG
            print("Permisos de ubicacion autorizados")
            #endif
            DispatchQueue.main.async {
                DeviceLocation.Share.locationManager.startUpdatingLocation()
            }

            return true
        case .denied,.restricted:
            
            let alert = UIAlertController(title: "LOCATION_TITLE_ALERT".localized(), message: "LOCATION_BODY_ALERT".localized(), preferredStyle: .alert)
            
            let actionYes = UIAlertAction(title: "GO_TO_CONFIGURATION".localized(), style: .default) {  (Action) in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Se ejecuta completion de validateLocationPermissions")
                        
                    })
                }
            }
            
            let actionNo = UIAlertAction(title: "Cancelar", style: .default, handler: { (success) in
                
                print("Se ejecuta completion de validateLocationPermissions")
                print("AlertAction: NO")
                
            })
            
            alert.addAction(actionNo)
            alert.addAction(actionYes)
            
            
            guard let vc = viewController else {
    
                return false
            }
            
            vc.present(alert, animated: true, completion: nil)
            return false
            
        case .notDetermined:
            print("notDetermined")
            DeviceLocation.Share.locationManager.requestWhenInUseAuthorization()
            return false
        @unknown default:
            print("Error Desconocido")
            return false
        }
    }
    
    
    public class func getLocation(viewController: UIViewController? = nil ,_ completion:((CLLocation?) -> Void)) {
        
        if  DeviceLocation.validateLocationPermissions(viewController: viewController) {
            return completion( DeviceLocation.Share.currentLocation)
        } else {
            return completion(nil)
        }
        
    }
}


extension DeviceLocation: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        if location.coordinate.latitude != 0 &&
            location.coordinate.longitude != 0 {
            
            locationManager.stopUpdatingLocation()
            currentLocation = location
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) ||
            (status == CLAuthorizationStatus.notDetermined) ||
            (status == CLAuthorizationStatus.restricted) {
            
            self.changeAuthorization?()
            
        } else if  (status == CLAuthorizationStatus.authorizedAlways) ||
                    (status == CLAuthorizationStatus.authorizedWhenInUse) {
            
            DispatchQueue.main.async {
                self.locationManager.startUpdatingLocation()
            }
            
        }
    }
    
}
