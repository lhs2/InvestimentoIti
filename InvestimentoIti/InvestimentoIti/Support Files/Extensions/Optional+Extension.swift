//
//  Optional+Extension.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        switch self {
        case .none:
            return true
        case .some(let content):
            if content.isEmpty {
                return true
            } else {
                return false
            }
        }
    }
}
