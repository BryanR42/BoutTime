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
        scoreLabel.text = scoreText
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
