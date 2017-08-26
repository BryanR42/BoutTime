//
//  EndGameView.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/24/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class EndGameView: UIViewController {
    var scoreText: String!
    @IBOutlet weak var scoreLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        // show the score label.
        scoreLabel.text = scoreText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // dismiss function is handled by the parent ViewController
}
