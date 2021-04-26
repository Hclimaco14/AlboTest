//
//  Mapper.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation

public class Mapper<T:Codable> {
  
  public init() {}
  
  public func toJSONString(_ object: T?) -> String? {
    DispatchQueue.global().sync {
      let enconder = JSONEncoder()
      guard let obj = object else { return nil }
      guard let data = try? enconder.encode(obj) else { return nil }
      return String(data: data, encoding: String.Encoding.utf8)
    }
  }
  
  public func map(object: Any?) -> T? {
    DispatchQueue.global().sync {
      if let objectData = object as? Data {
        return map(JSONData: objectData)
      }
      
      if let objectString = object as? String {
        return map(JSONString: objectString)
      }
      
      if let objectJSON = object as? [String:Any] {
        return map(JSONObject: objectJSON)
      }
      
      return nil
    }
  }
  
  public func map(JSONData: Data?) -> T? {
    DispatchQueue.global().sync {
      guard let jsonData = JSONData else { return nil }
      let decoder = JSONDecoder()
      guard let object = try? decoder.decode(T.self, from: jsonData) else { return nil }
      return object
    }
  }
  
  public func map(JSONString: String?) -> T? {
    DispatchQueue.global().sync {
      guard let jsonString = JSONString else { return nil }
      guard let JSONObject = jsonString.data(using: .utf8) else { return nil }
      let decoder = JSONDecoder()
      guard let object = try? decoder.decode(T.self, from: JSONObject) else { return nil }
      return object
    }
  }
  
  public func map(JSONObject: [String:Any]?) -> T? {
    DispatchQueue.global().sync {
      guard let JSONObj = JSONObject else { return nil }
      guard let JSON = JsonUtils.JSONToData(JSON: JSONObj) else { return nil }
      let decoder = JSONDecoder()
      guard let object = try? decoder.decode(T.self, from: JSON) else { return nil }
      return object
    }
  }
  
  public func mapArray(object: Any?) -> [T]? {
    DispatchQueue.global().sync {
      if let objectData = object as? Data {
        return mapArray(JSONData: objectData)
      }
      
      if let objectString = object as? String {
        return mapArray(JSONString: objectString)
      }
      
      if let objectJSON = object as? [String:Any] {
        return mapArray(JSONObject: objectJSON)
      }
      
      return nil
    }
  }
  
  public func mapArray(JSONData: Data?) -> [T]? {
    DispatchQueue.global().sync {
      let decoder = JSONDecoder()
      guard let jsonData = JSONData else { return nil }
      guard let object = try? decoder.decode([T].self, from: jsonData) else { return nil }
      return object
    }
  }
  
  public func mapArray(JSONString: String?) -> [T]? {
    DispatchQueue.global().sync {
      guard let jsonString = JSONString else { return nil }
      guard let JSONObject = jsonString.data(using: .utf8) else { return nil }
      let decoder = JSONDecoder()
      guard let object = try? decoder.decode([T].self, from: JSONObject) else { return nil }
      return object
    }
  }
  
  public func mapArray(JSONObject: [String:Any]?) -> [T]? {
    DispatchQueue.global().sync {
      guard let JSONObj = JSONObject else { return nil }
      guard let JSON = JsonUtils.JSONToData(JSON: JSONObj) else { return nil }
      let decoder = JSONDecoder()
      guard let object = try? decoder.decode([T].self, from: JSON) else { return nil }
      return object
    }
  }
  
}

