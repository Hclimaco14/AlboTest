//
//  Airport.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation
import CoreLocation

public class Airport: NSObject,Codable {
    public var icao : String?
    public var iata : String?
    public var name : String?
    public var shortName : String?
    public var municipalityName : String?
    public var location : Location?
    public var countryCode : String?
    
    open override var description: String {
        var desc = ""
        desc += "\nicao: \(String(describing: icao))"
        desc += "\niata: \(String(describing: iata))"
        desc += "\nname: \(String(describing: name))"
        desc += "\nshortName: \(String(describing: shortName))"
        desc += "\nmunicipalityName: \(String(describing: municipalityName))"
        desc += "\nlocation: \(String(describing: location))"
        desc += "\ncountryCode: \(String(describing: countryCode))"
        
        return desc
    }
    
    public override init() { }
    
    public init(icao: String, iata: String, name: String, shortName: String, municipalityName: String, location: Location, countryCode: String) {
        self.icao = icao
        self.iata = iata
        self.name = name
        self.shortName = shortName
        self.municipalityName = municipalityName
        self.location = location
        self.countryCode = countryCode
    }
    
    enum CodingKeys: String, CodingKey {
        case icao
        case iata
        case name
        case shortName
        case municipalityName
        case location
        case countryCode
    }
    
    required public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        icao = try? values.decode(String.self, forKey: .icao )
        iata = try? values.decode(String.self, forKey: .iata )
        name = try? values.decode(String.self, forKey: .name )
        shortName = try? values.decode(String.self, forKey: .shortName )
        municipalityName = try? values.decode(String.self, forKey: .municipalityName )
        location = try? values.decode(Location.self, forKey: .location )
        countryCode = try? values.decode(String.self, forKey: .countryCode )
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if icao != nil {
            try? container.encode(icao, forKey: .icao )
        }
        
        if iata != nil {
            try? container.encode(iata, forKey: .iata )
        }
        
        if name != nil {
            try? container.encode(name, forKey: .name )
        }
        
        if shortName != nil {
            try? container.encode(shortName, forKey: .shortName )
        }
        
        if municipalityName != nil {
            try? container.encode(municipalityName, forKey: .municipalityName )
        }
        
        if location != nil {
            try? container.encode(location, forKey: .location )
        }
        
        if countryCode != nil {
            try? container.encode(countryCode, forKey: .countryCode )
        }
        
    }
    
}

extension Airport {
    func getCoordinate2D() -> CLLocationCoordinate2D {
        if let lat = self.location?.lat, let lon = self.location?.lon {
            return CLLocationCoordinate2D(latitude: lat, longitude: lon)
        }else {
            return CLLocationCoordinate2D()
        }
    }
    
    func getLocation() -> CLLocation {
        if let lat = self.location?.lat, let lon = self.location?.lon {
            return CLLocation(latitude: lat, longitude: lon)
        }else {
            return CLLocation()
        }
    }
}
