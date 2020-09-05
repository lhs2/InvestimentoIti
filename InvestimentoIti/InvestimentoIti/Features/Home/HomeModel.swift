//
//  HomeModel.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

class Person: Codable {
  let name: String = "Eric Brito"
  let balance: Double = 20000
  let photo: String = "eric"
  
  
  var formattedBalance: String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "pt_BR")
    return formatter.string(from: NSNumber(value: balance))  ??  "R$ \(balance)"
  }
}
