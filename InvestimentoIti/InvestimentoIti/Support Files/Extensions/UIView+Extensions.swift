//
//  UIView+Extensions.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            prepareForInterfaceBuilder()
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get { guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.borderColor = newValue?.cgColor
            prepareForInterfaceBuilder()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set {
            layer.borderWidth = newValue
            prepareForInterfaceBuilder()
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get { return layer.masksToBounds }
        set {
            layer.masksToBounds = newValue
            prepareForInterfaceBuilder()
        }
    }
}
