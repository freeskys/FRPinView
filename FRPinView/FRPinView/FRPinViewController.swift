//
//  FRPinViewController.swift
//  FRPinView
//
//  Created by Harditya on 1/11/17.
//  Copyright © 2017 Blezcode. All rights reserved.
//

import UIKit

class FRPinViewController: UIAlertController {

    var delegate: FRPinDelegate?
    var frPinView = FRPinView(size: 4, frame: CGRect.zero)
    
//    init() {
//        super.init()
//    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        frPinView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: CGFloat(frPinView.pinViewWidth) + 8,
                                 height: frPinView.frame.size.height)
        frPinView.focus()
        frPinView.delegate = self.delegate
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
