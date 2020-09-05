//
//  InvestimentoItiAPIError.swift
//  InvestimentoIti
//
//  Created by Henrique de Souza Nobrega on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

enum APIError: Error {
    case noConnection
    case badURL
    case taskError
    case noResponse
    case invalidStatusCode(Int)
    case noData
    case invalidJSON
    case invalidRequest
}
