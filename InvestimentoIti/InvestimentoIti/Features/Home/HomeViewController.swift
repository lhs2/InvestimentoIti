//
//  HomeViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
  @IBOutlet weak var scrollOptions: UIScrollView!
  @IBOutlet weak var labelSaldo: UILabel!
  @IBOutlet weak var buttonEye: UIButton!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    buttonEye.isSelected = true
    showHideSaldo(buttonEye)
  }
  
  @IBAction func callLeft(_ sender: Any) {
    let title = "futura implementação botão esquerda"
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func callRight(_ sender: Any) {
    let title = "futura implementação botão direita"
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func callWallet(_ sender: Any) {
    performSegue(withIdentifier: "showWallet", sender: self)
    
  }
  @IBAction func showHideSaldo(_ sender: UIButton) {
    buttonEye.isSelected.toggle()
    
    if buttonEye.isSelected {
      labelSaldo.text = "R$ 20.000,00"
    } else {
      labelSaldo.text = "- - - -"
    }
  }
}
