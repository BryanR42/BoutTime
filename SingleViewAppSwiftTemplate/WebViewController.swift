//
//  WebViewController.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/22/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    var urlString: String!
    
    @IBOutlet weak var EventWebView: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // convert the passed string into a URL and load it into the webview
        EventWebView.delegate = self
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            EventWebView.loadRequest(request)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
