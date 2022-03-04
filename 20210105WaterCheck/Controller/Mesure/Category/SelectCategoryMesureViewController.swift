//
//  SelectCategoryMesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/12.
//

import UIKit

class SelectCategoryMesureViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ud = UserDefaults.standard
    var cateList = [String]()
    var whichSubject = String()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*33)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        switch whichSubject {
        case "pH":
            cateList = saveDataGetString(key: "pH_category_list", Array: cateList)
        case "Cl":
            cateList = saveDataGetString(key: "Cl_category_list", Array: cateList)
        case "硬度":
            cateList = saveDataGetString(key: "塩素_category_list", Array: cateList)
        case "亜鉛":
            cateList = saveDataGetString(key: "亜鉛_category_list", Array: cateList)
        default:
            print("")
        }
        
        tableView.reloadData()
    }
    func saveDataGetString(key:String, Array:[String]) -> [String]{
        var saveArray = Array
        if ud.array(forKey: key) != nil{
            saveArray = ud.array(forKey: key) as! [String]
        }
        return saveArray
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cateList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = ""
        cell.textLabel?.textColor = .black
        cell.backgroundColor = .white
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "＋ 新規作成"
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            print("")
            let addVC = (storyboard?.instantiateViewController(identifier: "addCate"))! as AddCateViewController
            addVC.whichSubject = whichSubject
            navigationController?.pushViewController(addVC, animated: true)
        case 1:
            let nav = self.navigationController!
            let preVC = nav.viewControllers[nav.viewControllers.count-2] as! OutcomeViewController
            preVC.t_info.category = "未分類"
            self.navigationController?.popViewController(animated: true)
        default:
            let nav = self.navigationController!
            let preVC = nav.viewControllers[nav.viewControllers.count-2] as! OutcomeViewController
            preVC.t_info.category = cateList[indexPath.row-2]
            self.navigationController?.popViewController(animated: true)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height/8
    }

}
