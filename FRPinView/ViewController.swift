//
//  ViewController.swift
//  FRPinTextField
//
//  Created by Harditya on 10/24/16.
//  Copyright © 2016 PT DOT Indonesia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FRPinDelegate {

    @IBOutlet weak var pin: FRPinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pin.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pin.frame = CGRect(origin: pin.frame.origin,
                           size: CGSize(width: CGFloat(pin.pinViewWidth) + 8,
                                        height: pin.frame.size.height))
        pin.focus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - FRPin delegate
    
    func frPin(didFinishInput frPinView: FRPinView) {
        print("Finish input")
    }

    // MARK: - Actions
    
    @IBAction func doPrint(_ sender: UIButton) {
        print("PIN = \(pin.getText())")
    }

}

