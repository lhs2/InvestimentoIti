//
//  String+Extension.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import Foundation

extension String {
    func currencyMask() -> String {
        
        let defaultString = "R$ 00,00"
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currencyAccounting
        formatter.currencySymbol = "R$ "
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        
        var amount = self
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amount = regex.stringByReplacingMatches(in: amount, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: "")
        } catch {
            return defaultString
        }
        
        let double = (amount as NSString).doubleValue
        let number = NSNumber(value: (double / 100))
        
        if let currencyString = formatter.string(from: number) {
            return currencyString
        }
        
        return defaultString

    }
}
