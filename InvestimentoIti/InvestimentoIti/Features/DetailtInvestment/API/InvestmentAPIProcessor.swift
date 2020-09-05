//
//  APIProcessor.swift
//  InvestimentoIti
//
//  Created by Henrique de Souza Nobrega on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

struct InvestmentAPIProcessor {
    private static let baseScheme: String = "https"
    private static let baseHost: String = "www.alphavantage.co"
    private static let basePath: String = "/query"

    static func getPrice(for symbol: String, completion: @escaping (() throws -> Quote.Investment) -> Void) throws {
        
        guard let request = self.createRequest(for: symbol) else {
            throw APIError.invalidRequest
        }
        
        try API.send(request: request, completion: { (result) in
            do {
                guard let investment = try result() else {
                    throw APIError.invalidJSON
                }

                completion({ investment })
            } catch {
                self.process(error: error, completion: completion)
            }
        })
    }
        
//    https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=IBM&apikey=demo
    private static func createRequest(for symbol: String) -> URLRequest? {
        var urlComponents = URLComponents()
        urlComponents.scheme = self.baseScheme
        urlComponents.host = self.baseHost
        urlComponents.path = self.basePath
        urlComponents.queryItems = [
           URLQueryItem(name: "function", value: "GLOBAL_QUOTE"),
           URLQueryItem(name: "symbol", value: symbol),
           URLQueryItem(name: "apikey", value: "W9BGSJ7MNNAJ06Z2")
        ]
        
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
     
        return request
    }

    private static func process(error: Error, completion: (() throws -> Quote.Investment) -> Void) {
        completion( { throw error } )
    }
}
