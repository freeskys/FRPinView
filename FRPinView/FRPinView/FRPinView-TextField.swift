//
//  FRPinView-TextField.swift
//  FRPinView
//
//  Created by Harditya on 12/6/16.
//  Copyright © 2016 Blezcode. All rights reserved.
//

import Foundation
import UIKit

extension FRPinView: UITextFieldDelegate {
    
    // MARK: - Textfield delegate
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let char = string.cString(using: String.Encoding.utf8)!
//        let isBackSpace = strcmp(char, "\\b")

//        if let _ = textField.text {
//            for i in 0..<pinCount {
                // Backspace detected. Delete all PIN.
//                print("isBack = \(isBackSpace)")
//                if (isBackSpace == -92) {
//                    resetText()
//                    textFields[0].becomeFirstResponder()
//                }
    
//                     Not backspace
//                } else {
//                    // Last textfield
//                    if (i == pinCount - 2) || (textField == textFields[pinCount - 2]) {
//                        textFields[pinCount - 1].text = string
//                        textField.resignFirstResponder()
//                        
//                        delegate?.frPin(didFinishInput: self)
//                        
//                        break
//                    }
//                    
//                    // Move to next field
//                    if textField == textFields[i] {
//                        moveFrom(currentTextField: textFields[i])
//                        
//                        break
//                    }
//                }
//            }
//        }
        
//        return true
//    }
    
    func textFieldDidChange(textField: UITextField) {
        let char = textField.text?.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            resetText()
            textFields[0].becomeFirstResponder()
        } else {
            if textField != textFields[pinCount-1] {
                moveFrom(currentTextField: textField)
            } else {
                delegate?.frPin(didFinishInput: self)
                textField.resignFirstResponder()
            }
        }
        
//        for i in 0..<pinCount {
//            // Backspace detected. Delete all PIN.
//            if (isBackSpace == -92) {
//                textFields[i].text = ""
//                textFields[0].becomeFirstResponder()
//                
//            // Not backspace
//            } else {
//                // Last textfield
//                if (i == pinCount - 2) || (textField == textFields[pinCount - 2]) {
//                    textFields[pinCount - 1].text = textField.text
//                    textField.resignFirstResponder()
//                    
//                    delegate?.frPin(didFinishInput: self)
//                    
//                    break
//                }
//                
//                // Move to next field
//                if textField == textFields[i] {
//                    moveFrom(currentTextField: textFields[i])
//                    
//                    break
//                }
//            }
//        }
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        hasBeenSelected = false
        
        return true
    }
    
}
