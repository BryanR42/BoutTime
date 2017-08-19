//
//  ViewController.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Treehouse on 12/8/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var EventButton1: UIButton!
    @IBOutlet weak var EventButton2: UIButton!
    @IBOutlet weak var EventButton3: UIButton!
    @IBOutlet weak var EventButton4: UIButton!

    
    @IBOutlet weak var Down1Button: UIButton!
    @IBOutlet weak var Down2Button: UIButton!
    @IBOutlet weak var Down3Button: UIButton!
    @IBOutlet weak var Up2Button: UIButton!
    @IBOutlet weak var Up3Button: UIButton!
    @IBOutlet weak var Up4Button: UIButton!
 

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }
    override func viewDidLayoutSubviews() {
        let radii = EventButton1.frame.size.height / 15
        EventButton1.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton2.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton3.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton4.round(corners: [.bottomLeft, .topLeft], radius: radii)
        Down1Button.round(corners: [.topRight, .bottomRight], radius: radii)
        Down2Button.round(corners: .bottomRight, radius: radii)
        Down3Button.round(corners: .bottomRight, radius: radii)
        Up2Button.round(corners: .topRight, radius: radii)
        Up3Button.round(corners: .topRight, radius: radii)
        Up4Button.round(corners: [.topRight,.bottomRight], radius: radii)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

