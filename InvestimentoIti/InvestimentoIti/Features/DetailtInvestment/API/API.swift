//
//  InvestimentoItiAPI.swift
//  InvestimentoIti
//
//  Created by Henrique de Souza Nobrega on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation
 
struct API {

    static func send(request: URLRequest, completion: @escaping (() throws -> Quote.Investment?) -> Void) throws {
        
        if API.isNetworkReachable() {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                API.processResponse(data, response, error, completion: completion)
            }
            
            task.resume()
        } else {
            throw APIError.noConnection
        }
    }
    
    private static func processResponse(_ data: Data?, _ response: URLResponse?, _ error: Error?, completion: (() throws -> Quote.Investment?) -> Void) {
        if error != nil {
            completion({ throw APIError.taskError })
            return
        }
        
        guard let response = response as? HTTPURLResponse else {
            completion({ throw APIError.noResponse })
            return
        }
        
        if !(200...299 ~= response.statusCode) {
            completion({ throw APIError.invalidStatusCode(response.statusCode) })
            return
        }
        
        guard let data = data else {
            completion({ throw APIError.noData })
            return
        }
        
        do {
            let quote = try JSONDecoder().decode(Quote.self, from: data)
            completion({ quote.investment })
        } catch {
            completion({ throw APIError.invalidJSON })
        }
    }
    
    private static func isNetworkReachable() -> Bool {
        return true
    }
}
