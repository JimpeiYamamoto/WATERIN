//
//  SubscriptionViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/04/28.
//

import UIKit
import SwiftyStoreKit

class SubscriptionViewController: UIViewController {

    @IBOutlet weak var explain_view: UIView!
    @IBOutlet weak var sub_aciton: UIButton!
    @IBOutlet weak var service_button: UIButton!
    @IBOutlet weak var and_label: UILabel!
    @IBOutlet weak var privacy_button: UIButton!
    @IBOutlet weak var restore_button: UIButton!
    
    @IBOutlet weak var one: UILabel!
    @IBOutlet weak var two: UILabel!
    @IBOutlet weak var three: UILabel!
    @IBOutlet weak var four: UILabel!
    @IBOutlet weak var five: UILabel!
    @IBOutlet weak var six: UILabel!
    @IBOutlet weak var seven: UILabel!
    @IBOutlet weak var eight: UILabel!
    @IBOutlet weak var nine: UILabel!
    @IBOutlet weak var ten: UILabel!
    @IBOutlet weak var eleven: UILabel!
    
    var Store = StoreClass()
    var activityIndicatorView = UIActivityIndicatorView()

    
    func set_explain_view()
    {
        let width = view.frame.size.width
        let height = view.frame.size.height
        explain_view.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*22)
        let e_w = explain_view.frame.size.width
        let e_h = explain_view.frame.size.height
        one.frame = CGRect(x: e_w/40*1, y: e_h/40*1, width: e_w/40*38, height: e_h/40*3)
        
        two.frame = CGRect(x: e_w/40*3, y: e_h/40*6, width: e_w*34, height: e_h/40*2)
        three.frame = CGRect(x: e_w/40*5, y: e_h/40*9, width: e_w/40*33, height: e_h/40*2)
        four.frame = CGRect(x: e_w/40*5, y: e_h/40*12, width: e_w/40*33, height: e_h/40*2)
        
        five.frame = CGRect(x: e_w/40*3, y: e_h/40*17, width: e_w*34, height: e_h/40*2)
        six.frame = CGRect(x: e_w/40*5, y: e_h/40*20, width: e_w/40*33, height: e_h/40*2)
        
        seven.frame = CGRect(x: e_w/40*3, y: e_h/40*24, width: e_w*34, height: e_h/40*2)
        eight.frame = CGRect(x: e_w/40*5, y: e_h/40*27, width: e_w/40*33, height: e_h/40*2)
        
        nine.frame = CGRect(x: e_w/40*3, y: e_h/40*31, width: e_w*34, height: e_h/40*2)
        ten.frame = CGRect(x: e_w/40*5, y: e_h/40*34, width: e_w/40*33, height: e_h/40*2)
        
        eleven.frame = CGRect(x: e_w/40*1, y: e_h/40*37, width: e_w/40*38, height: e_h/40*3)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
        set_explain_view()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        Store.get_receipt()
        Store.check_receipt()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    @IBAction func sub_ac(_ sender: Any)
    {
        print("purchace")
        activityIndicatorView.startAnimating()
        DispatchQueue.global(qos: .default).async { [self] in
            Store.purchace()
            Thread.sleep(forTimeInterval: 5)
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
        }
        DispatchQueue.global(qos: .default).async { [self] in
            Thread.sleep(forTimeInterval: 3)
            DispatchQueue.main.async {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
    @IBAction func service_action(_ sender: Any)
    {
        let ruleVC = storyboard?.instantiateViewController(identifier: "rule") as! RuleViewController
        ruleVC.kind = "service"
        navigationController?.pushViewController(ruleVC, animated: true)
    }
    
    @IBAction func privacy_action(_ sender: Any)
    {
        let ruleVC = storyboard?.instantiateViewController(identifier: "rule") as! RuleViewController
        ruleVC.kind = "privacy"
        navigationController?.pushViewController(ruleVC, animated: true)
    }
    
    @IBAction func restore_action(_ sender: Any)
    {
        if (UserDefaults.standard.value(forKey: "purchace") != nil)
        {
            if (UserDefaults.standard.value(forKey: "purchace") as! Int == 0)
            {
                alert(title: "未購入", message: "プロ版を使用する場合はサブスクリプション登録を押してください")
            }
            else if (UserDefaults.standard.value(forKey: "purchace") as! Int == 1)
            {
                alert(title: "期限切れ", message: "期限を延長する場合はサブスクリプション登録を押してください")
            }
            else
            {
                alert(title: "購入済み", message: "")
            }
        }
        else
        {
            activityIndicatorView.startAnimating()
            DispatchQueue.global(qos: .default).async { [self] in
                Store.restore()
                Thread.sleep(forTimeInterval: 5)
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                }
            }
        }
        
    }
    
    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        let width = view.frame.size.width
        let height = view.frame.size.height
        explain_view.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*22)
        sub_aciton.frame = CGRect(x: width/40*3, y: height/40*28, width: width/40*34, height: height/40*3)
        service_button.frame = CGRect(x: width/40*2, y: height/40*32, width: width/40*16, height: height/40*2)
        and_label.frame = CGRect(x: width/40*17, y: height/40*32, width: width/40*4, height: height/40*2)
        privacy_button.frame = CGRect(x: width/40*22, y: height/40*32, width: width/40*16, height: height/40*2)
        restore_button.frame = CGRect(x: width/40*8, y: height/40*34, width: width/40*24, height: height/40*2)
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .gray
        view.addSubview(activityIndicatorView)
    }
    

    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
}
