//
//  ConformUpViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/07.
//

import UIKit
import Firebase

class ConformUpViewController: UIViewController {

    var name = String()
    var pass = String()
    var mail = String()
    
    @IBOutlet weak var mail_label: UILabel!
    @IBOutlet weak var mail_tf: UITextField!
    @IBOutlet weak var pass_label: UILabel!
    @IBOutlet weak var pass_tf: UITextField!
    @IBOutlet weak var confirm_label: UILabel!
    @IBOutlet weak var fix_button: UIButton!
    @IBOutlet weak var register_button: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
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
        mail_label.frame = CGRect(x: width/40*4, y: height/40*10, width: width/40*32, height: height/40*2)
        mail_tf.frame = CGRect(x: width/40*4, y: height/40*12, width: width/40*32, height: height/40*2)
        pass_label.frame = CGRect(x: width/40*4, y: height/40*15, width: width/40*32, height: height/40*2)
        pass_tf.frame = CGRect(x: width/40*4, y: height/40*17, width: width/40*32, height: height/40*2)
        confirm_label.frame = CGRect(x: width/40*2, y: height/40*21, width: width/40*36, height: height/40*2)
        fix_button.frame = CGRect(x: width/40*4, y: height/40*27, width: width/40*12, height: height/40*4)
        register_button.frame = CGRect(x: width/40*24, y: height/40*27, width: width/40*12, height: height/40*4)
        fix_button.layer.cornerRadius = 30.0
        register_button.layer.cornerRadius = 30.0
        pass_tf.isSecureTextEntry = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pass_tf.text = pass
        mail_tf.text = mail
    }
    
    @IBAction func fix_action(_ sender: Any)
    {
        let back_vc = storyboard?.instantiateViewController(identifier: "make") as! MkViewController
        back_vc.mail = mail
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func go_action(_ sender: Any)
    {
        let email = mail
        let password = pass
        let name = "WATER INの利用者"
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
                guard let self = self else { return }
                if let user = result?.user {
                    let req = user.createProfileChangeRequest()
                    req.displayName = self.name
                    req.commitChanges() { [weak self] error in
                        guard let self = self else { return }
                        if error == nil {
                            user.sendEmailVerification() { [weak self] error in
                                guard let self = self else { return }
                                if error == nil {
                                    // 仮登録完了画面へ遷移する処理
                                    UserDefaults.standard.setValue(email, forKey: "email")
                                    UserDefaults.standard.setValue(password, forKey: "password")
                                    UserDefaults.standard.setValue(name, forKey: "name")
                                    let alertContoller = UIAlertController(title: "仮登録完了", message: "メールアドレス確認メールを送信したので、URLから本登録をしてください", preferredStyle: .alert)
                                    alertContoller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                                    self.present(alertContoller, animated: true, completion: nil)
                                    //続けてログイン
                                    Auth.auth().signIn(withEmail: UserDefaults.standard.string(forKey: "email")!, password: UserDefaults.standard.string(forKey: "password")!) { [weak self] result, error in
                                        guard let self = self else { return }
                                        if let user = result?.user {
                                            print("自動ログイン成功")
                                            self.navigationController?.popToViewController(ofClass: SetMainViewController.self)
                                        }
                                        else
                                        {
                                            self.alert(title: "ログインに失敗しました", message: "設定>アカウント>ログイン からログインしてください")
                                        }
                                    }
                                }
                                self.showErrorIfNeeded(error)
                                print("kokoka?")
                            }
                        }
                        self.showErrorIfNeeded(error)
                    }
                }
                self.showErrorIfNeeded(error)
            }
    }
    
    private func showErrorIfNeeded(_ errorOrNil: Error?)
    {
        guard let error = errorOrNil else { return }
        let message = errorMessage(of: error) // エラーメッセージを取得
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    private func errorMessage(of error: Error) -> String {
        var message = "エラーが発生しました"
        guard let errcd = AuthErrorCode(rawValue: (error as NSError).code) else {
            return message
        }
        switch errcd {
        case .networkError: message = "ネットワークに接続できません"
        case .userNotFound: message = "ユーザが見つかりません"
        case .invalidEmail: message = "不正なメールアドレスです"
        case .emailAlreadyInUse: message = "このメールアドレスは既に使われています"
        case .wrongPassword: message = "入力した認証情報でサインインできません"
        case .userDisabled: message = "このアカウントは無効です"
        case .weakPassword: message = "パスワードが脆弱すぎます"
        default: break
        }
        return message
    }
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
}
