//
//  NetworkUtils.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation

/**
 
 */
public class NetworkUtils {
  
  private static let timeOutInterval: Double = 60
    
  public static func createRequest(urlString: String?, HTTPMethod: HTTPMethod, body: String? =  nil) -> URLRequest?{
    
    var urlStr = "https://aerodatabox.p.rapidapi.com"
    
    if let url = urlString {
      urlStr += url
    }
    
    guard let urlConexion = URL(string: urlStr) else { return nil }
    
    var urlRequest = URLRequest(url: urlConexion)
    
    
    let headers = [
        "x-rapidapi-key": Constants.x_rapidapi_key,
        "x-rapidapi-host": "aerodatabox.p.rapidapi.com"
    ]
    urlRequest.allHTTPHeaderFields = headers
    urlRequest.httpMethod = HTTPMethod.rawValue
    urlRequest.timeoutInterval = timeOutInterval
    if let dataBody = body {
      urlRequest.httpBody =  dataBody.data(using: String.Encoding.utf8)
    }
    
    return urlRequest
    
  }
  
}
