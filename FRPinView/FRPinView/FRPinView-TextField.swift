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
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        if (isBackSpace == -92) {
            pin = ""
            tempPin = ""
            
            resetText()
        } else {
            pin += string
            tempPin += string + " "
//            print("PIN: \(pin)")
            
            let arrayString = tempPin.components(separatedBy: " ")
            var index: Int = 0
            resetText()
            
            for thePin in arrayString {
                if index >= pinCount {
                    break
                }
                
                if !thePin.isEmpty {
//                    print("thePin: \(thePin)")
                    
                    textFields[index].text = " "
                    index += 1
                    
                    if pin.characters.count == pinCount {
                        delegate?.frPin(didFinishInput: self)
                        textField.resignFirstResponder()
                    }
                }
            }
        }
        
        return true
    }
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        let char = string.cString(using: String.Encoding.utf8)!
//        let isBackSpace = strcmp(char, "\\b")
//        
//        print("String: \(string)")
//        if (isBackSpace == -92) {
//            resetText()
//            textFields[0].becomeFirstResponder()
//        } else {
//            for theTextfield: UITextField in textFields {
//                if theTextfield.text!.isEmpty {
//                    theTextfield.text = string
//                    
//                    if getText().characters.count == pinCount {
//                        delegate?.frPin(didFinishInput: self)
//                        textField.resignFirstResponder()
//                    }
//                    
//                    return false
//                }
//            }
//        }
//        
//        return true
//    }
    
//    func textFieldDidChange(textField: UITextField) {
//        let char = textField.text?.cString(using: String.Encoding.utf8)!
//        let isBackSpace = strcmp(char, "\\b")
//        
//        print("String: \(char)")
//        if (isBackSpace == -92) {
//            resetText()
//            textFields[0].becomeFirstResponder()
//        }
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
//        
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
