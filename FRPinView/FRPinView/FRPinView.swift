//
//  FRPinTextField.swift
//  FRPinTextField
//
//  Created by Harditya on 10/24/16.
//  Copyright © 2016 PT DOT Indonesia. All rights reserved.
//

import UIKit

protocol FRPinDelegate {
    
    func frPin(didFinishInput frPinView: FRPinView)
    
}

class FRPinView: UIView, UITextFieldDelegate {

    var delegate: FRPinDelegate?
    
    var pin: String = ""
    var textFields = [UITextField]()
    var hasBeenSelected = false
    
    var pinCount: Int = 6
    var pinSpacing: Int = 4
    var pinWidth: Int = 36
    var pinHeight: Int = 36
    var pinViewWidth: Int {
        return (pinWidth * pinCount) + (pinSpacing * pinCount)
    }
    
    init(size: Int, frame: CGRect) {
        super.init(frame: frame)
        
        // Styling textfield
        self.pinCount = size
        
        createTextFields()
        addRoundedTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        // Add text fields
        createTextFields()
        addRoundedTextField()
    }
    
    // MARK: - Functions
    
    func createTextFields() {
        // Create textfield based on size
        for _ in 0..<self.pinCount {
            let textField = UITextField()
            
            // Set textfield params
            textField.keyboardType = .numberPad
            textField.textAlignment = .center
            textField.backgroundColor = UIColor.white
            textField.delegate = self
            textField.isSecureTextEntry = true
            
            // Styling textfield
            textField.layer.cornerRadius = 10
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00).cgColor
            
            textFields.append(textField)
        }
    }
    
    func addRoundedTextField() {
        var nextX: Int = pinSpacing
        
        for i in 0..<pinCount {
            textFields[i].frame = CGRect(x: nextX,
                                         y: 10,
                                         width: pinWidth,
                                         height: pinHeight)
            nextX = nextX + pinSpacing + pinWidth
            self.addSubview(textFields[i])
        }
    }
    
    func moveFrom(currentTextField textField: UITextField) {
        if hasBeenSelected {
            for i in 0..<pinCount {
                if textField == textFields[i] {
                    textFields[i+1].becomeFirstResponder()
                    
                    break
                }
            }
        }
        
        hasBeenSelected = true
    }
    
    func moveBackwardFrom(currentTextField textField: UITextField) {
        if hasBeenSelected {
            for i in 0..<pinCount {
                if textField == textFields[i] {
                    textFields[i].text = ""
                    textFields[i-1].becomeFirstResponder()
                    
                    break
                }
            }
        }
        
        hasBeenSelected = true
    }
    
    func getText() -> String {
        var results = ""
        
        for i in 0..<pinCount {
            if let text = textFields[i].text {
                results = results + text
            }
        }
        
        return results
    }
    
    // MARK: - Textfield delegate1
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if let _ = textField.text {
            for i in 0..<pinCount {
                // Backspace detected. Delete all PIN.
                if (isBackSpace == -92) {
                    textFields[i].text = ""
                    textFields[0].becomeFirstResponder()
                    
                // Not backspace
                } else {
                    // Last textfield
                    if (i == pinCount - 2) || (textField == textFields[pinCount - 2]) {
                        textFields[pinCount - 1].text = string
                        textField.resignFirstResponder()
                        
                        delegate?.frPin(didFinishInput: self)
                        
                        break
                    }
                    
                    // Move to next field
                    if textField == textFields[i] {
                        moveFrom(currentTextField: textFields[i])
                        
                        break
                    }
                }
            }
        }
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        hasBeenSelected = false
        
        return true
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
