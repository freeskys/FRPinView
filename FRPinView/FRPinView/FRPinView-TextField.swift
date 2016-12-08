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
//        
//        if textField == textFields[pinCount-1] {
//            textFields[pinCount-1].text = string
//            delegate?.frPin(didFinishInput: self)
//            textField.resignFirstResponder()
//        }
//        
//        if (isBackSpace == -92) {
//            resetText()
//            textFields[0].becomeFirstResponder()
//        } else {
//            if textField != textFields[pinCount-1] {
//                if !textField.text!.isEmpty {
//                    moveFrom(currentTextField: textField)
//                }
//            }
//        }
//        
//        return true
//    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let isBackSpace = strcmp(string, "\\b")
        
        if (isBackSpace == -92) {
            resetText()
            textFields[0].becomeFirstResponder()
        } else {
            for theTextfield: UITextField in textFields {
                if theTextfield.text!.isEmpty {
                    theTextfield.text = string
                    
                    if getText().characters.count == pinCount {
                        delegate?.frPin(didFinishInput: self)
                        textField.resignFirstResponder()
                    }
                    
                    return false
                }
            }
        }
        
        return true
    }
    
//    func textFieldDidChange(textField: UITextField) {
//        let char = textField.text?.cString(using: String.Encoding.utf8)!
//        let isBackSpace = strcmp(char, "\\b")
//        
//        if (isBackSpace == -92) {
//            resetText()
//            textFields[0].becomeFirstResponder()
//        } else {
//            for theTextfield: UITextField in textFields {
//                if theTextfield.text!.isEmpty {
//                    theTextfield.text = textField.text
//                    break
//                }
//            }
//            
//            if textField == textFields[pinCount-1] {
//                delegate?.frPin(didFinishInput: self)
//                textField.resignFirstResponder()
//            }
        
//            if textField != textFields[pinCount-1] {
//                if !textField.text!.isEmpty {
//                    moveFrom(currentTextField: textField)
//                }
//            } else if textField == textFields[pinCount-1] {
//                delegate?.frPin(didFinishInput: self)
//                textField.resignFirstResponder()
//            }
//        }
//    }
    
}
