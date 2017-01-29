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
            
            delegate?.frPin?(didDeletePin: self)
        } else {
            pin += string
            tempPin += string + ","
//            print("PIN: \(pin)")
            
            let arrayString = tempPin.components(separatedBy: ",")
            var index: Int = 0
            resetText()
            
//            print("Jumlah array: \(arrayString.count)")
            for thePin in arrayString {
                if index >= pinCount {
                    break
                }
                
                if !thePin.isEmpty {
//                    print("thePin: \(thePin)")
                    
//                    print("TextField Index: \(index)")
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
    
}
