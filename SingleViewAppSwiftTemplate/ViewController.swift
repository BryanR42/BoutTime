//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
extension UILabel {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var EventLabel1: UILabel!
    @IBOutlet weak var EventLabel2: UILabel!
    @IBOutlet weak var EventLabel3: UILabel!
    @IBOutlet weak var EventLabel4: UILabel!
    
    @IBOutlet weak var Down1Button: UIButton!
    @IBOutlet weak var Down2Button: UIButton!
    @IBOutlet weak var Down3Button: UIButton!
    @IBOutlet weak var Up2Button: UIButton!
    @IBOutlet weak var Up3Button: UIButton!
    @IBOutlet weak var Up4Button: UIButton!
 
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
            EventLabel1.roundCorners(corners: [.topLeft , .bottomLeft], radius: 5)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

