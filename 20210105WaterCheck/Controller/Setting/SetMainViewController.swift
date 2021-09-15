//
//  SetMainViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import Firebase

class SetMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let section_title:NSArray = ["メニュー"]
    var login_user = Int()

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
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
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (3)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = .black
        switch (indexPath.section) {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "問い合わせ"
            case 1:
                cell.textLabel?.text = "サービス規約"
            case 2:
                cell.textLabel?.text = "プライバシーポリシー"
            default:
                print("")
            }
        default:
            print("")
        }
        return (cell)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (section_title.count)
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        return (section_title[section] as? String)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return view.frame.size.height/10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let ruleVC = storyboard?.instantiateViewController(identifier: "rule") as! RuleViewController
                ruleVC.kind = "toiawase"
                navigationController?.pushViewController(ruleVC, animated: true)
            case 1:
                let ruleVC = storyboard?.instantiateViewController(identifier: "rule") as! RuleViewController
                ruleVC.kind = "service"
                navigationController?.pushViewController(ruleVC, animated: true)
            case 2:
                let ruleVC = storyboard?.instantiateViewController(identifier: "rule") as! RuleViewController
                ruleVC.kind = "privacy"
                navigationController?.pushViewController(ruleVC, animated: true)
                print("")
            default:
                print("")
            }
        default:
            print("")
        }
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        view.tintColor = .darkGray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .white
    }
}
