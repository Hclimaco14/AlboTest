//
//  ServicesManager.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import Foundation
import CoreLocation

struct RequestError: Error {
    let statusCode: Int
    let description: String
    var data: Data?
}

internal class ServicesManager {
    
    private let session = URLSession.shared
    private static let share = ServicesManager()
    private var retries = 0
    private let retryLimit = 3
    
    public var showLoading: (() -> ())?
    public var hideLoading: (() -> ())?

    
    public func readLocalFile<T:Codable>(forName name: String) -> T? {
        
        do {
            if let bundlePath = Bundle.main.path(forResource: name,ofType: "json") {
                let data = try Data(contentsOf: URL(fileURLWithPath: bundlePath), options: .mappedIfSafe)
                
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                let resonse = Mapper<T>().map(object: jsonResult)
                return resonse
            }
            
        } catch {
            print(error)
            return nil
        }
        
        return nil
    }
    
    public func fetchRequest<T: Codable>(with request: URLRequest,
                                         completion: @escaping(Result<T, RequestError>) -> Void) {
        self.showLoading?()
        self.session.dataTask(with: request, completionHandler: { data, response, error in
            self.hideLoading?()
            //MARK: validated error
            if let err = error {
                let nsError = err as NSError
                let possibleInternetErrors = [
                    NSURLErrorNotConnectedToInternet,
                    NSURLErrorNetworkConnectionLost,
                    NSURLErrorCannotConnectToHost,
                    NSURLErrorCannotFindHost,
                ]
                if possibleInternetErrors.contains(nsError.code) && self.retries < self.retryLimit {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        ServicesManager.share.fetchRequest(with: request, completion: completion)
                    }
                } else {
                    completion(.failure(RequestError(statusCode: nsError.code, description: nsError.description, data: data)))
                }
                
            }
            
            guard let response = response, let data = data else {
                return completion(.failure(
                    RequestError(statusCode: 0, description: "Error desconocido", data: data))
                )
            }
            
            //MARK: validated response
            guard let httpResp = response as? HTTPURLResponse,
            (200...299).contains(httpResp.statusCode) else {
                completion(.failure(self.getError(response: response, data: data)))
                return
            }
            
            if let respData = Mapper<T>().map(object: data) {
                completion(.success(respData))
            } else {
                completion(.failure(
                    RequestError( statusCode: 0,description: "Error in decoder", data: data))
                )
            }
            
        }).resume()
    }
    
    fileprivate func getError(response: URLResponse, data: Data) -> RequestError {
        
        guard let httpResponse = response as? HTTPURLResponse else {
            return RequestError(statusCode: 00, description: "Error getting description of server error.")
        }
        
        switch httpResponse.statusCode {
        case 400:
            return RequestError(statusCode: 400, description: "Invalid Request", data: data)
        case 401:
            return RequestError(statusCode: 401, description: "Unauthorized", data: data)
        case 404:
            return RequestError(statusCode: 404, description: "Not found", data: data)
        case 500:
            return RequestError(statusCode: 500, description: "Server unavailable", data: data)
        default:
            return RequestError(statusCode: 00, description: "Tuvimos un problema, vuelve a intentarlo más tarde", data: data)
        }
    }
    
}
