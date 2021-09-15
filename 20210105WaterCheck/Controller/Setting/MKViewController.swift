//
//  MakeUserViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/07.
//

import UIKit
import FirebaseAuth

class MkViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var mail_label: UILabel!
    @IBOutlet weak var mail_tf: UITextField!
    @IBOutlet weak var pass_label: UILabel!
    @IBOutlet weak var pass_tf: UITextField!
    @IBOutlet weak var next_button: UIButton!
    @IBOutlet weak var hide_button: UIButton!
    
    var mail = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        mail_tf.text = mail
        pass_tf.text = ""
    }

    @IBAction func hide_action(_ sender: Any)
    {
        if (pass_tf.isSecureTextEntry == true)
        {
            pass_tf.isSecureTextEntry = false
        }
        else
        {
            pass_tf.isSecureTextEntry = true
        }
    }
    
    @IBAction func nextAction(_ sender: Any)
    {
        if (mail_tf.text != "" && pass_tf.text != "")
        {
            //画面遷移
            let conVC = storyboard?.instantiateViewController(identifier: "con") as! ConformUpViewController
            conVC.mail = mail_tf.text!
            conVC.name = "WATER INの利用者"
            conVC.pass = pass_tf.text!
            
            navigationController?.pushViewController(conVC, animated: true)
        }
        else
        {
            alert(title: "エラー", message: "正しく入力してください")
        }
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
    
    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil)
        let width = view.frame.size.width
        let height = view.frame.size.height
        mail_label.frame = CGRect(x: width/40*4, y: height/40*7, width: width/40*32, height: height/40*2)
        mail_tf.frame = CGRect(x: width/40*4, y: height/40*9, width: width/40*32, height: height/40*2)
        pass_label.frame = CGRect(x: width/40*4, y: height/40*14, width: width/40*14, height: height/40*2)
        hide_button.frame = CGRect(x: width/40*16, y: height/40*14, width: width/40*3, height: height/40*2)
        pass_tf.frame = CGRect(x: width/40*4, y: height/40*16, width: width/40*32, height: height/40*2)
        next_button.frame = CGRect(x: width/40*4, y: height/40*25, width: width/40*32, height: height/40*3)
        pass_tf.isSecureTextEntry = true
    }
}
