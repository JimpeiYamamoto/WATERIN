//
//  RuleViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/13.
//

import UIKit
import WebKit

class RuleViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var kind = String()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        webView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if (kind == "service")
        {
            if let url = NSURL(string: "https://republicwater.co.jp/water-in-privacy/") {
                       let request = NSURLRequest(url: url as URL)
                       webView.load(request as URLRequest)
            }
        }
        else if (kind == "privacy")
        {
            if let url = NSURL(string: "https://republicwater.co.jp/water-in-privacy/") {
                       let request = NSURLRequest(url: url as URL)
                       webView.load(request as URLRequest)
            }
        }
        else if (kind == "toiawase")
        {
            if let url = NSURL(string: "https://republicwater.co.jp/water-in/") {
                       let request = NSURLRequest(url: url as URL)
                       webView.load(request as URLRequest)
            }
        }
    }

    
    
}
