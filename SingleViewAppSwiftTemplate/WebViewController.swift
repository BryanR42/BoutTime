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
        
        EventWebView.delegate = self
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            EventWebView.loadRequest(request)
        }
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
 

    func loadWebPage(at urlString: String) {
        let url = URL(string: urlString)
        if let unwrappedUrl = url {
            let request = URLRequest(url: unwrappedUrl)
            let session = URLSession.shared
     
            let task = session.dataTask(with: unwrappedUrl, completionHandler: { (data, response, error) in
                if error == nil {
                    self.EventWebView.loadRequest(request)
                } else {
                    print("ERROR: \(error)")
                }
            })
            task.resume
        }
    }
 
 */
}
