//
//  SelectCateViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/06.
//

import UIKit

class SelectCateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let ud = UserDefaults.standard
    var whichSubject = String()
    var cateList = [String]()
    var ud_data = UD_data()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView.frame = CGRect(x: width/40*2, y: height/40*5,
                                 width: width/40*36, height: height/40*33)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switch whichSubject {
        case "pH":
            cateList = saveDataGetString(key: "pH_category_list", Array: cateList)
        case "Cl":
            cateList = saveDataGetString(key: "Cl_category_list", Array: cateList)
        default:
            print("")
        }
        ud_data.getContents(subject : whichSubject)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateList.count+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = .black
        switch indexPath.row{
        case 0:
            cell.textLabel?.text = "全てのデータ"
        case 1:
            cell.textLabel?.text = "未分類"
        default:
            cell.textLabel?.text = cateList[indexPath.row-2]
        }
        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let nav = self.navigationController!
        let preVC = nav.viewControllers[nav.viewControllers.count-2] as! LogDetaillViewController
        switch indexPath.row {
        case 0:
            preVC.cate_tf.text = "全てのデータ"
        case 1:
            preVC.cate_tf.text = "未分類"
        default:
            if cateList.count != 0{
                preVC.cate_tf.text = cateList[indexPath.row-2]
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func saveDataGetString(key:String, Array:[String]) -> [String]{
        var saveArray = Array
        if ud.array(forKey: key) != nil{
            saveArray = ud.array(forKey: key) as! [String]
        }
        return saveArray
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> (Bool)
    {
        if (indexPath.row == 0 || indexPath.row == 1)
        {
            return (false)
        }
        return (true)
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let message =  "\(cateList[indexPath.row - 2])を削除しますか？"
            let alertSheet = UIAlertController(title: "\(cateList[indexPath.row - 2])のデータのカテゴリーは未分類になります", message:message, preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [self]
                (action: UIAlertAction!) in
                var num = 0
                for _ in ud_data.categoryList
                {
                    if (ud_data.categoryList[num] == cateList[indexPath.row - 2])
                    {
                        ud_data.categoryList[num] = "未分類"
                    }
                    num += 1
                }
                ud_data.ud_data_save(subject: whichSubject)
                cateList.remove(at: indexPath.row - 2)
                switch whichSubject {
                case v.PH:
                    ud.set(cateList, forKey: "pH_category_list")
                case "COD":
                    ud.set(cateList, forKey: "COD_category_list")
                case "亜鉛":
                    ud.set(cateList, forKey: "亜鉛_category_list")
                case v.CL:
                    ud.set(cateList, forKey: "Cl_category_list")
                default:
                    print("")
                }
                tableView.reloadData()
            })
            let action3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
                (action: UIAlertAction!) in
            })
            alertSheet.addAction(action1)
            alertSheet.addAction(action3)
            self.present(alertSheet, animated: true, completion: nil)
        }
        
    }
}
