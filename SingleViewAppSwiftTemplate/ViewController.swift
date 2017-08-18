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
        EventButton1.round(corners: .topLeft, radius: 20)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

