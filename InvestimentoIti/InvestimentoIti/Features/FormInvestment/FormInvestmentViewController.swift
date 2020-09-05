//
//  FormInvestmentViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit


class FormInvestmentViewController: UIViewController {
    var model: FormInvestmentModel = FormInvestmentModel()
    
    @IBOutlet weak var activeForm: ItiFormUIView!
    @IBOutlet weak var priceForm: ItiFormUIView!
    @IBOutlet weak var startDateForm: ItiFormUIView!
    @IBOutlet weak var quantityForm: ItiFormUIView!
    
    @IBAction func performSave(_ sender: Any) {
        if ItiFormUIView.validateForm(with: [activeForm, priceForm,startDateForm,quantityForm]) {
            print("Form valido")
        }
    }
    
    
}
