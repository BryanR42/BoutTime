//
//  WebViewController.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/22/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var EventWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
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
