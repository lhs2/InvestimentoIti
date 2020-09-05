//
//  ItiFormUIView.swift
//  InvestimentoIti
//
//  Created by Luiz Henrique de Sousa (P) on 05/09/20.
//  Copyright © 2020 Luiz Henrique de Sousa. All rights reserved.
//

import UIKit

@IBDesignable
public class ItiFormUIView: UIView {
    
    // MARK:- Outlets
    @IBOutlet var content: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueTextField: UITextField!
    
    // MARK:- IBInspectable
    @IBInspectable var errorColor: UIColor = .red
    @IBInspectable var errorMessage: String = "Campo Obrigatório"
    @IBInspectable var isOptionalField: Bool = true
    @IBInspectable var isCurrency: Bool = false
    @IBInspectable var highlightedColor: UIColor = .lightGray
    @IBInspectable var title: String = "" {
        didSet {
            if titleLabel != nil {
                titleLabel.text = self.title
            }
        }
    }
    
    @IBInspectable var placeholder: String = "" {
        didSet {
            if valueTextField != nil {
                valueTextField.placeholder = self.placeholder
            }
        }
    }
    
    @IBInspectable var key: String = ""
    
    // MARK:- Private variables
    private var isInvalid: Bool = false
    private var previousTitleColor: UIColor = .clear
    private var previousValueColor: UIColor = .clear
    private var datePicker: UIDatePicker?
    
    // MARK:- Init
    override init(frame: CGRect) {
     super.init(frame: frame)
     initSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      initSubviews()
    }
    
    func initSubviews() {
        translatesAutoresizingMaskIntoConstraints = false
        let nib = UINib(nibName: "ItiFormUIView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        content.frame = bounds
        titleLabel.text = title
        valueTextField.placeholder = placeholder
        valueTextField.delegate = self
        addSubview(content)
        
    }
    
//    override public var intrinsicContentSize: CGSize {
//        let height = btn.frame.size.height
//        let width =  btn.frame.origin.x + btn.frame.size.width
//        return CGSize(width: width, height: height)
//    }
    
    // MARK:- Functions
    func validateAndRaiseError()-> Bool {
        if isOptionalField {
            return true
        }
        
        if valueTextField.text.isNilOrEmpty || isInvalid {
            raiseError()
            return false
        }
        return true
    }
    
    func raiseError() {
        isInvalid = true
        previousTitleColor = titleLabel.textColor
        previousValueColor = valueTextField.textColor ?? .lightGray
        titleLabel.textColor = errorColor
        valueTextField.textColor = errorColor
        valueTextField.text = errorMessage
    }
    
    func updateTextField() {
        isInvalid = false
        valueTextField.text = ""
        titleLabel.textColor = previousTitleColor
        valueTextField.textColor = previousValueColor
    }
    
    
    func configure(with title:String, and placeholder:String = "") {
        self.title = title
        self.placeholder = placeholder
    }
    
   
    
    // MARK:- Static Functions
    static func validateForm(with views:[ItiFormUIView]) -> Bool {
        var validForm: Bool = true
        views.forEach { view in
            validForm = validForm && view.validateAndRaiseError()
        }
        
        return validForm
    }
    
}

extension ItiFormUIView: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        if isInvalid {
           updateTextField()
        }
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if isCurrency,
           let text = textField.text,
           let textRange = Range(range, in: text) {
           let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            valueTextField.text = updatedText.currencyMask()
           return false
        }
        return true
    }
}
