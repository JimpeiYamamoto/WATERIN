//
//  UserViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/07.
//

import UIKit
import Firebase

class UserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var intro_label: UILabel!
    @IBOutlet weak var mail_label: UILabel!
    @IBOutlet weak var mail_tf: UITextField!
    @IBOutlet weak var pass_label: UILabel!
    @IBOutlet weak var pass_tf: UITextField!
    @IBOutlet weak var login_button: UIButton!
    @IBOutlet weak var foget_button: UIButton!
    @IBOutlet weak var sign_up_label: UILabel!
    @IBOutlet weak var sigin_up_button: UIButton!

    var activityIndicatorView = UIActivityIndicatorView()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    @IBAction func loginAction(_ sender: Any)
    {
        if (mail_tf.text == "" || pass_tf.text == "")
        {
            alert(title: "エラー", message: "IDとパスワードを正しく入力してください")
            return
        }
        Auth.auth().signIn(withEmail: self.mail_tf.text!, password: self.pass_tf.text!) { [weak self] result, error in
            guard let self = self else { return }
            if let user = result?.user {
                self.mail_tf.text = ""
                self.pass_tf.text = ""
                self.alert(title: "ログイン完了", message: "WaterCheckerをお楽しみください")
                self.navigationController?.popToViewController(ofClass: SetMainViewController.self)
            }
            else
            {
                self.alert(title: "エラー", message: "IDとパスワードを正しく入力してください")
                return
            }
        }
        
    }
    
    @IBAction func forgetAction(_ sender: Any)
    {
        let change_vc = storyboard?.instantiateViewController(identifier: "change") as! ChangePassViewController
        navigationController?.pushViewController(change_vc, animated: true)
    }
    
    @IBAction func signupAction(_ sender: Any)
    {
        let make_vc = storyboard?.instantiateViewController(identifier: "make") as! MkViewController
        navigationController?.pushViewController(make_vc, animated: true)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
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
        intro_label.frame = CGRect(x: width/40*3, y: height/40*4, width: width/40*34, height: height/40*3)
        mail_label.frame = CGRect(x: width/40*5, y: height/40*8, width: width/40*30, height: height/40*2)
        mail_tf.frame = CGRect(x: width/40*5, y: height/40*10, width: width/40*30, height: height/40*2)
        pass_label.frame = CGRect(x: width/40*5, y: height/40*13, width: width/40*30, height: height/40*2)
        pass_tf.frame = CGRect(x: width/40*5, y: height/40*15, width: width/40*30, height: height/40*2)
        login_button.frame = CGRect(x: width/40*5, y: height/40*19, width: width/40*30, height: height/40*3)
        foget_button.frame = CGRect(x: width/40*8, y: height/40*25, width: width/40*24, height: height/40*2)
        sign_up_label.frame = CGRect(x: width/40*5, y: height/40*30, width: width/40*30, height: height/40*3)
        sigin_up_button.frame = CGRect(x: width/40*5, y: height/40*33, width: width/40*30, height: height/40*3)
        pass_tf.isSecureTextEntry = true
        activityIndicatorView.center = view.center
        activityIndicatorView.style = .medium
        activityIndicatorView.color = .gray
        view.addSubview(activityIndicatorView)
    }
    
}
