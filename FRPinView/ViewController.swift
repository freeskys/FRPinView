//
//  ViewController.swift
//  FRPinTextField
//
//  Created by Harditya on 10/24/16.
//  Copyright © 2016 PT DOT Indonesia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pin: FRPinView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        pin.frame = CGRect(origin: pin.frame.origin,
                           size: CGSize(width: CGFloat(pin.pinViewWidth) + 8,
                                        height: pin.frame.size.height))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doPrint(_ sender: UIButton) {
        print("PIN = \(pin.getText())")
    }

}
