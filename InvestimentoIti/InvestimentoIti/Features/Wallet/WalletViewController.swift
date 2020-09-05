//
//  WalletViewController.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit
import CoreData

class WalletViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        loadInvestiments()
    }
    
    lazy var walletModel: WalletModel = {[weak self] in
        let walletModel = WalletModel()
        walletModel.delegate = self
        return walletModel
    }()
    
    func loadInvestiments() {
        walletModel.performFetch()
    }
    
    @IBAction func newInvestiment(_ sender: UIButton) {
        performSegue(withIdentifier: Segue.form, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Segue.detail {
            guard let detailViewController = segue.destination as? DetailInvestmentViewController else { return }
            detailViewController.view.backgroundColor = .blue
        }
    }
}

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        walletModel.totalInvestiments
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? WalletTableViewCell else {
            return UITableViewCell()
        }
        let investiment = walletModel.getInvestimentAt(indexPath)
        cell.configure(with: investiment)
        cell.selectionStyle = .none
        return cell
    }
}

extension WalletViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.detail, sender: nil)
    }
}

extension WalletViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
