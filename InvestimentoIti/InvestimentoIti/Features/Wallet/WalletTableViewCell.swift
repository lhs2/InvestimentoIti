//
//  WalletTableViewCell.swift
//  InvestimentoIti
//
//  Created by Ricardo Espirito Santo Bailoni on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

class WalletTableViewCell: UITableViewCell {
    @IBOutlet weak var labelActive: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with investment: Investiment?) {
        labelActive.text = investment?.active
        labelAmount.text = "\((investment?.price ?? 0) * Double(investment?.quantity ?? 0))"
    }
}
