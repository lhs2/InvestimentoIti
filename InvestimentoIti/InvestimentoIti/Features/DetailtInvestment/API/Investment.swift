//
//  Investment.swift
//  InvestimentoIti
//
//  Created by Henrique de Souza Nobrega on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

struct Quote: Codable {
    let investment: Investment
    
    private enum CodingKeys : String, CodingKey {
        case investment = "Global Quote"
    }
}

struct Investment: Codable {
    let symbol: String
    let open: String
    let high: String
    let low: String
    let price: String
    let volume: String
    let trading: String
    let previous: String
    let change: String
    let percent: String

    private enum CodingKeys : String, CodingKey {
        case symbol = "01. symbol"
        case open = "02. open"
        case high = "03. high"
        case low = "04. low"
        case price = "05. price"
        case volume = "06. volume"
        case trading = "07. latest trading day"
        case previous = "08. previous close"
        case change = "09. change"
        case percent = "10. change percent"
    }
}
