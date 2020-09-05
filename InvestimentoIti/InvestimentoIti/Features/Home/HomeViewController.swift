//
//  HomeViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    // MARK: - IBOutlets
  @IBOutlet weak var scrollOptions: UIScrollView!
  @IBOutlet weak var labelSaldo: UILabel!
  @IBOutlet weak var buttonEye: UIButton!
  @IBOutlet weak var imageviewPerson: UIImageView!
  
  // MARK: - Properties
  var person =  Person()
  
  // MARK: - Super Methods
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    setupView()
  }
  // MARK: - Methods

  private func setupView() {
    buttonEye.isSelected = true
    showHideSaldo(buttonEye)
    imageviewPerson.image = UIImage(named: person.photo)
  }
  
  // MARK: - IBActions
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
  
  @IBAction func callCadastro(_ sender: UIButton) {
    let title = "chamada da view de cadastro"
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func callTransfer(_ sender: UIButton) {
    let title = "chamada da view de transaferencia"
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func callFavorite(_ sender: UIButton) {
    let title = "chamada da view de favoritos"
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
    alert.addAction(okAction)
    present(alert, animated: true, completion: nil)
  }
  
  @IBAction func showHideSaldo(_ sender: UIButton) {
    buttonEye.isSelected.toggle()
    
    if buttonEye.isSelected {
      labelSaldo.text = person.formattedBalance
    } else {
      labelSaldo.text = "- - - -"
    }
  }
}
