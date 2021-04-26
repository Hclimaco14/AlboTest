//
//  Location.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation

public class Location: NSObject,Codable{
 public var lat : Double?
 public var lon : Double?

open override var description: String {
 var desc = ""
 desc += "\nlat: \(String(describing: lat))"
 desc += "\nlon: \(String(describing: lon))"

 return desc
}

public override init() { }

public init(lat: Double, lon: Double) {
 self.lat = lat
 self.lon = lon
}

enum CodingKeys: String, CodingKey {
 case lat
 case lon
}

required public init(from decoder: Decoder) throws {
 let values = try decoder.container(keyedBy: CodingKeys.self)

 lat = try? values.decode(Double.self, forKey: .lat )
 lon = try? values.decode(Double.self, forKey: .lon )
}

public func encode(to encoder: Encoder) throws {
 var container = encoder.container(keyedBy: CodingKeys.self)
 if lat != nil {
 try? container.encode(lat, forKey: .lat )
 }

 if lon != nil {
 try? container.encode(lon, forKey: .lon )
 }

}

}
