//
//  PreMesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit

class PreMesureViewController: UIViewController {

    //測定項目がどれかがわかる変数
    var whichSubject = String()
    //どの試験紙を使うか
    var whichSikensi = String()
    var whichPen = "桃・空色・緑"
    var which_acount = String()
    
    @IBOutlet weak var sikensiTF: UITextField!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var pen_change_button: UIButton!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var pen_tf: UITextField!
    @IBOutlet weak var paper_label: UILabel!
    @IBOutlet weak var pen_label: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
        print("測定項目は\(whichSubject)です")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        sikensiTF.isUserInteractionEnabled = false
        pen_tf.isUserInteractionEnabled = false
        UITabBarItem.appearance().setTitleTextAttributes( [ .font : UIFont.init(name: "HelveticaNeue-Bold", size: 10) as Any,.foregroundColor : UIColor.blue ],for: .normal)
    }

    override func viewWillAppear(_ animated: Bool) {
        presentingViewController?.beginAppearanceTransition(false, animated: animated)
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        print(whichSikensi)
        if (whichSubject == "pH")
        {
            whichSikensi = "MACHERY-NAGEL Universal-Indikatorpaper"
        }
        else
        {
            whichSikensi = "I_foget_cl_name"
        }
        sikensiTF.text = whichSikensi
        pen_tf.text = whichPen
        self.navigationItem.title = "\(whichSubject)-測定準備"
    }
    
    @IBAction func changeAction(_ sender: Any)
    {
        let selectSVC = storyboard?.instantiateViewController(identifier: "select") as! SelectSikensiViewController
        selectSVC.pen_or_paper = -1
        navigationController?.pushViewController(selectSVC, animated: true)
    }

    @IBAction func pen_change_action(_ sender: Any)
    {
        let select_vc = storyboard?.instantiateViewController(identifier: "select") as! SelectSikensiViewController
        select_vc.pen_or_paper = 1
        navigationController?.pushViewController(select_vc, animated: true)
    }
    
    @IBAction func startAction(_ sender: Any)
    {
        if ((sikensiTF.text != nil) || pen_tf.text != nil){
            checkAlert()
        }else{
            let dialog = UIAlertController(title: "試験紙を選択してください", message: "変更ボタンを押すと選択できます", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
    }

    func checkAlert()
    {
        let alertSheet = UIAlertController(title: "測定条件が正しいですか？", message: "測定対象：\(whichSubject)\n試験紙：\(whichSikensi)\n補正用カラー：\(whichPen)", preferredStyle: UIAlertController.Style.actionSheet)
        let action1 = UIAlertAction(title: "はい", style: UIAlertAction.Style.default, handler:
        { [self]
            (action: UIAlertAction!) in
            if (whichSubject == "pH")
            {

            }
        })
        let action3 = UIAlertAction(title: "いいえ", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
        })
        alertSheet.addAction(action1)
        alertSheet.addAction(action3)
        self.present(alertSheet, animated: true, completion: nil)
    }

    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        let width_view = view.frame.size.width
        let height_view = view.frame.size.height
        paper_label.frame = CGRect(x: width_view/40*3, y: height_view/40*28, width: width_view/40*9, height: height_view/40*2)
        pen_label.frame = CGRect(x: width_view/40*3, y: height_view/40*31, width: width_view/40*9, height: height_view/40*2)
        sikensiTF.frame = CGRect(x: width_view/40*13, y: height_view/40*28, width: width_view/40*20, height: height_view/40*2)
        pen_tf.frame = CGRect(x: width_view/40*13, y: height_view/40*31, width: width_view/40*20, height: height_view/40*2)
        changeButton.frame = CGRect(x: width_view/40*34, y: height_view/40*28, width: width_view/40*3, height: height_view/40*2)
        pen_change_button.frame = CGRect(x: width_view/40*34, y: height_view/40*31, width: width_view/40*3, height: height_view/40*2)
        startButton.frame = CGRect(x: width_view/40*3, y: height_view/40*35, width: width_view/40*34, height: height_view/40*4)
    }

}
