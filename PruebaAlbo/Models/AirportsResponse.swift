//
//  AirportsResponse.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation

public class AirportsResponse: NSObject,Codable {
    public var items : [Airport]?

   open override var description: String {
    var desc = ""
    desc += "\nitems: \(String(describing: items))"

    return desc
   }

   public override init() { }

   public init(items: [Airport]) {
    self.items = items
   }

   enum CodingKeys: String, CodingKey {
    case items
   }

   required public init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    items = try? values.decode([Airport].self, forKey: .items )
   }

   public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    if items != nil {
    try? container.encode(items, forKey: .items )
    }

   }

   }
