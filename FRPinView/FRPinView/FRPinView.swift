//
//  FRPinTextField.swift
//  FRPinTextField
//
//  Created by Harditya on 10/24/16.
//  Copyright © 2016 PT DOT Indonesia. All rights reserved.
//

import UIKit

protocol FRPinDelegate {
    
    /// User has been filled all the PIN delegate
    ///
    /// - Parameter frPinView: frPinView The PIN view
    func frPin(didFinishInput frPinView: FRPinView)
    
}

class FRPinView: UIView {

    var delegate: FRPinDelegate?
    
    var pin: String = ""
    var textFields = [UITextField]()
    var hasBeenSelected = false
    
    @IBInspectable var pinCount: Int = 6
    @IBInspectable var pinSpacing: Int = 4
    @IBInspectable var pinWidth: Int = 36
    @IBInspectable var pinHeight: Int = 36
    @IBInspectable var pinCornerRadius: CGFloat = 5
    @IBInspectable var pinBorderWidth: CGFloat = 1
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
    }
    
    override func layoutSubviews() {
        // Add textfields
        textFields = [UITextField]()
        
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
            textField.layer.cornerRadius = self.pinCornerRadius
            textField.layer.borderWidth = self.pinBorderWidth
            textField.layer.borderColor = UIColor(red: 0.91, green: 0.91, blue: 0.91, alpha: 1.00).cgColor
            
            textField.addTarget(self, action: #selector(FRPinView.textFieldDidChange), for: UIControlEvents.editingChanged)
            
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
        for i in 0..<pinCount {
            if textField == textFields[i] {
                textFields[i+1].becomeFirstResponder()
                
                break
            }
        }
    }
    
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
        var results = ""
        
        for i in 0..<pinCount {
            if let text = textFields[i].text {
                results = results + text
            }
        }
        
        return results
    }
    
    func resetText() {
        for i in 0..<pinCount {
            textFields[i].text = ""
        }
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
