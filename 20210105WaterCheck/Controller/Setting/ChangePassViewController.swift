//
//  ChangePassViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/05/08.
//

import UIKit
import Firebase

class ChangePassViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var explain_label: UILabel!
    @IBOutlet weak var mail_label: UILabel!
    @IBOutlet weak var mail_tf: UITextField!
    @IBOutlet weak var send_button: UIButton!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    func set_view()
    {
        let width = view.frame.size.width
        let height = view.frame.size.height
        explain_label.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*8)
        mail_label.frame = CGRect(x: width/40*3, y: height/40*15, width: width/40*34, height: height/40*2)
        mail_tf.frame = CGRect(x: width/40*3, y: height/40*17, width: width/40*34, height: height/40*2)
        send_button.frame = CGRect(x: width/40*3, y: height/40*22, width: width/40*34, height: height/40*3)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
    }
    
    @IBAction func send_action(_ sender: Any)
    {
        let email = mail_tf.text ?? ""
        if (email == "")
        {
            alert(title: "エラー", message: "メールアドレスを入力してください")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { [weak self] error in
                guard let self = self else
                {
                    return
                }
                if error == nil {
                    print("era-nasi")
                    // 送信完了画面へ
                    self.alert(title: "メールを送信しました", message: "メールの指示に従ってパスワードの変更をしてください")
                    self.mail_tf.text = ""
                }
                self.showErrorIfNeeded(error)
            return
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        return textField.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }


}
