//
//  DetailInvestmentViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

class DetailInvestmentViewController: UIViewController {
    
    // MARK: - Properties
    
    var investment: Investiment?
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var labelSymbol: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelPriceOnBuy: UILabel!
    @IBOutlet weak var labelDateOfBuy: UILabel!
    @IBOutlet weak var labelTotalValueOfBuy: UILabel!
    @IBOutlet weak var labelQuotationToday: UILabel!
    @IBOutlet weak var labelTotalValueToday: UILabel!
    @IBOutlet weak var labelProfitability: UILabel!
    @IBOutlet weak var buttonEdit: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if self.investment == nil {
//            self.investment = Investiment(context: context)
//        }
//        
//        self.investment?.active = "IBM"
//        self.investment?.price = 51.54
//        self.investment?.quantity = 100
//        self.investment?.startDate = "12/08/2020"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupElements()
        self.setupInvestmentValues()
        
        guard let symbol = self.investment?.active else {
            return
        }

        self.requestQuote(for: symbol)
    }
    
    // MARK: - IBAction
    
    @IBAction func close(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Methods
    
    private func setupElements() {
        self.buttonEdit.cornerRadius = 25
        self.buttonEdit.clipsToBounds = true
        self.buttonEdit.applyDefaultBackgroundColor()
    }
    
    private func setupInvestmentValues() {
        guard let investment = investment else {
            self.labelSymbol.text = "-"
            self.labelQuantity.text = "-"
            self.labelPriceOnBuy.text = "-"
            self.labelDateOfBuy.text = "-"
            self.labelTotalValueOfBuy.text = "-"
            
            return
        }
        
        self.labelSymbol.text = investment.active
        self.labelQuantity.text = "\(investment.quantity)"
        self.labelPriceOnBuy.text = self.formatCurrency(value: investment.price)
        self.labelDateOfBuy.text = investment.startDate
        self.labelTotalValueOfBuy.text = self.formatCurrency(value: investment.price * Double(investment.quantity))
    }
    
    private func setupQuoteInvestmentValues(quoteInvestment: Quote.Investment) {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            if let price = Double(quoteInvestment.price) {
                self.labelQuotationToday.text = self.formatCurrency(value: price)
                
                if let quantity = self.investment?.quantity {
                    self.labelTotalValueToday.text = self.formatCurrency(value: price * Double(quantity))
                } else {
                    self.labelTotalValueToday.text = "-"
                }
                
                if let boughtPrice = self.investment?.price {
                    let profitability = (abs(boughtPrice - price) / max(boughtPrice, price)) * 100
                    
                    self.labelProfitability.text = self.formatProfitability(profit: profitability)
                    
                    if boughtPrice > price {
                        self.labelProfitability.textColor = .red
                        self.labelTotalValueToday.textColor = .red
                        self.labelQuotationToday.textColor = .red
                    } else if boughtPrice < price {
                        self.labelTotalValueToday.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                        self.labelQuotationToday.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                        self.labelProfitability.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
                    } else {
                        self.labelProfitability.textColor = .lightGray
                        self.labelTotalValueToday.textColor = .lightGray
                        self.labelQuotationToday.textColor = .lightGray
                    }
                } else {
                    self.labelProfitability.text = "-"
                }
            } else {
                self.labelQuotationToday.text = "-"
                self.labelTotalValueToday.text = "-"
            }
        }
    }
    
    private func formatCurrency(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        
        if let formattedValue = formatter.string(from: value as NSNumber) {
            return formattedValue
        }
        
        return "-"
    }
    
    private func formatProfitability(profit: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.numberStyle = .decimal

        guard let formattedValue = formatter.string(from: profit as NSNumber) else {
            return "-"
        }
        return "\(formattedValue) %"
    }
    
    private func requestQuote(for symbol: String) {
        do {
            self.activityIndicator.startAnimating()
            try InvestmentAPIProcessor.getPrice(for: "IBM") { [weak self] (result) in
                do {
                    let quoteInvestment = try result()
                    self?.setupQuoteInvestmentValues(quoteInvestment: quoteInvestment)
                } catch {
                    print("error")
                    DispatchQueue.main.async {
                        self?.activityIndicator.stopAnimating()
                    }
                }
            }
        } catch {
            print("error2")
            self.activityIndicator.stopAnimating()
        }
    }
    
}
