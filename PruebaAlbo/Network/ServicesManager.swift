//
//  ServicesManager.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation
import CoreLocation

internal class ServicesManager {
    public var showLoading: (() -> ())?
    public var hideLoading: (() -> ())?
    
    public func airportSearch(distance:Int,location:CLLocation?,loadFromFile:Bool = false,_ completion: @escaping (_ response: AirportsResponse?,_ error:String?) -> Void) {
        self.showLoading?()
        
        if loadFromFile {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                completion(self.readLocalFile(forName: "AeroDataBox"),nil)
                self.hideLoading?()
            }
            return
        }
        
        let maximunAirports = 16
        let service = "/airports/search/location/\(location?.coordinate.latitude ?? 0)/\(location?.coordinate.longitude ?? 0)/km/\(distance)/\(maximunAirports)?withFlightInfoOnly=false"
        
        guard let request = NetworkUtils.createRequest(urlString: service, HTTPMethod: .get) else { return }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard let httpResp = response as? HTTPURLResponse else { return completion(nil, "Error desconocido") }
            
            let statusCode = httpResp.statusCode
            
            if let dataReponse = data, let resonseTrans = Mapper<AirportsResponse>().map(object: dataReponse) {
                
                completion(resonseTrans, nil)
            }else {
                print("error")
            }
            
        })
        
        task.resume()

    }
    
    
    public func readLocalFile(forName name: String) -> AirportsResponse? {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                let resonse = Mapper<AirportsResponse>().map(object: jsonResult)
                return resonse
            }
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
    
}
