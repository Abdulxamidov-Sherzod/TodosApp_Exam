//
//  WebviewVC.swift
//  TodosApp_Exam
//
//  Created by Sherzod on 25/02/22.
//

import UIKit
import WebKit

class WebviewVC: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    var url = URL(string: "https://www.apple.com/")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        webView.load(URLRequest(url: url!))
        
        
    }



}
