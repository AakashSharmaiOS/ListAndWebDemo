//
//  WebViewController.swift
//  PlayoDemo
//
//  Created by Dev iOS on 7/14/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.openWeb(newsURL)
    }
    //MARK: Variables
    var newsURL = String()
    
    //MARK: Outlets
    @IBOutlet weak var webView: WKWebView!
    
    
    //MARK: Actions
    
    
    //MARK: Functions
    func openWeb(_ url : String){
        let url = URL (string: url)
        let requestObj = URLRequest(url: url!)
        webView.load(requestObj)
    }

}
