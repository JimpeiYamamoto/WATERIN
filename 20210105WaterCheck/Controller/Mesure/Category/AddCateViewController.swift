//
//  AddCateViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/13.
//

import UIKit

class AddCateViewController: UIViewController, UITextFieldDelegate {
    
    let ud = UserDefaults.standard
    @IBOutlet weak var AddButton: UIButton!
    @IBOutlet weak var cateTF: UITextField!
    var whichSubject = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cateTF.delegate = self
        cateTF.backgroundColor = .white
        cateTF.textColor = .black
        cateTF.returnKeyType = UIReturnKeyType.done
        set_view()
    }
    

    @IBAction func AddAction(_ sender: Any) {
        let nav = self.navigationController!
        let preVC = nav.viewControllers[nav.viewControllers.count-2] as! SelectCategoryMesureViewController
        var tyohukuCheck = 0
        print(cateTF.text!)
        let txt = cateTF.text?.trimmingCharacters(in: .whitespaces)
        for cate in preVC.cateList{
            if (cate == cateTF.text) || "未分類"==cateTF.text{
                print("カテゴリー名が重複しています")
                tyohukuCheck = 1
            }else if (cateTF.text == ""){
                print("文字が入力されていない")
                tyohukuCheck = 2
            }
        }
        if (txt != cateTF.text)
        {
            tyohukuCheck = 3
        }
        if (tyohukuCheck == 1){
            //アラート
            let dialog = UIAlertController(title: "既にあるカテゴリー名を追加することはできません", message: "異なる名前を入力してください", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
        else if (tyohukuCheck == 3)
        {
            let dialog = UIAlertController(title: "カテゴリー名にスペースを入れることはできません", message: "異なる名前を入力してください", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
        else if (tyohukuCheck == 2)
        {
            let dialog = UIAlertController(title: "文字が入力されていません", message: "", preferredStyle: .alert)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(dialog, animated: true, completion: nil)
        }
        else
        {
            //重複がないため、リストに追加して画面を戻る
            preVC.cateList.append(cateTF.text!)
            switch whichSubject {
            case "pH":
                ud.set(preVC.cateList, forKey: "pH_category_list")
            case "COD":
                ud.set(preVC.cateList, forKey: "COD_category_list")
            case "亜鉛":
                ud.set(preVC.cateList, forKey: "亜鉛_category_list")
            case "Cl":
                ud.set(preVC.cateList, forKey: "Cl_category_list")
            default:
                print("")
            }
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //Enterキーが押された時に呼ばれるメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        self.view.endEditing(true)
        return (true)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
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
        cateTF.frame = CGRect(x: width/40*3, y: height/40*6, width: width/40*36, height: height/40*3)
        AddButton.frame = CGRect(x: width/40*5, y: height/40*11, width: width/40*30, height: height/40*3)
    }
}
