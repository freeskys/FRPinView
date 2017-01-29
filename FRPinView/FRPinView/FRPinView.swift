//
//  FRPinTextField.swift
//  FRPinTextField
//
//  Created by Harditya on 10/24/16.
//  Copyright © 2016 PT DOT Indonesia. All rights reserved.
//

import UIKit

@objc
protocol FRPinDelegate {
    
    /// User has been filled all the PIN delegate
    ///
    /// - Parameter frPinView: frPinView The PIN view
    func frPin(didFinishInput frPinView: FRPinView)
    
    /// User delete PIN value
    ///
    /// - Parameter frPinView: frPinView The PIN view
    @objc optional func frPin(didDeletePin frPinView: FRPinView)
    
}

class FRPinView: UIView {

    // Variables
    var delegate: FRPinDelegate?
    var pin: String = ""
    var tempPin: String = ""
    var textFields = [UITextField]()
    var keyboardType: UIKeyboardType = .numberPad
    var pinViewWidth: Int {
        return (pinWidth * pinCount) + (pinSpacing * pinCount)
    }
    
    // Outlets
    @IBInspectable var pinCount: Int = 6
    @IBInspectable var pinSpacing: Int = 4
    @IBInspectable var pinWidth: Int = 36
    @IBInspectable var pinHeight: Int = 36
    @IBInspectable var pinCornerRadius: CGFloat = 5
    @IBInspectable var pinBorderWidth: CGFloat = 1
    
    init(size: Int, frame: CGRect) {
        super.init(frame: frame)
        
        // Styling textfield
        self.pinCount = size
        
       self.renderTextFields()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        // Add textfields
        textFields = [UITextField]()
        
        self.renderTextFields()
    }
    
    // MARK: - Functions
    
    func renderTextFields() {
        self.createTextFields()
        self.addRoundedTextField()
    }
    
    /// Generate textfield
    func createTextFields() {
        // Create textfield based on size
        for i in 0..<self.pinCount {
            let textField = UITextField()
            
            // Set textfield params
            textField.keyboardType = keyboardType
            textField.textAlignment = .center
            textField.backgroundColor = UIColor.white
            textField.tintColor = textField.backgroundColor
            textField.delegate = self
            textField.isSecureTextEntry = true
            
            // Styling textfield
            textField.layer.cornerRadius = self.pinCornerRadius
            textField.layer.borderWidth = self.pinBorderWidth
            textField.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00).cgColor
            
            if i > 0 {
                textField.isUserInteractionEnabled = false
            }
            
            textFields.append(textField)
        }
    }
    
    /// Make textfield rounded
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
    
    /// Move forward to textfield
    ///
    /// - Parameter textField: textField Current textfield
    func moveFrom(currentTextField textField: UITextField) {
        for i in 0..<pinCount {
            if textField == textFields[i] {
                textFields[i+1].becomeFirstResponder()
                
                break
            }
        }
    }
    
    /// Move backward from textfield
    ///
    /// - Parameter textField: textField Current textfield
    func moveBackwardFrom(currentTextField textField: UITextField) {
        for i in 0..<pinCount {
            if textField == textFields[i] {
                textFields[i].text = ""
                textFields[i-1].becomeFirstResponder()
                
                break
            }
        }
    }
    
    /// Get text from all pin textfields
    ///
    /// - Returns: return String Text from all pin textfields
    func getText() -> String {
        return pin
    }
    
    /// Reset text values
    func resetText() {
        for i in 0..<pinCount {
            textFields[i].text = ""
        }
    }
    
    /// Make the first textfield become first responder
    func focus() {
        textFields[0].becomeFirstResponder()
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
