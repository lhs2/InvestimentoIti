//
//  DetailInvestmentViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

class DetailInvestmentViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func test(_ sender: UIButton) {
        do {
            try InvestmentAPIProcessor.getPrice(for: "IBM") { (result) in
                do {
                    let investment = try result()
                    print(investment)
                } catch {
                    print("error")
                }
            }
        } catch {
            print("error2")
        }
    }
    
}
