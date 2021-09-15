//
//  LogMainViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit

class LogMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var reCall = ResultCall()
    var proCheck = Procheck()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*31)
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
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return (1)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let name_label = tableView.viewWithTag(1) as! UILabel
        let when_label = tableView.viewWithTag(2) as! UILabel
        let times_label = tableView.viewWithTag(3) as! UILabel
        when_label.numberOfLines = 2
        cell.backgroundColor = .white
        cell.detailTextLabel?.textColor = .black
        cell.textLabel?.textColor = .black
        let height_cell = cell.frame.size.height
        let width_cell = cell.frame.size.width
        name_label.frame = CGRect(x: width_cell/40*2, y: height_cell/40*5, width: width_cell/40*13, height: height_cell/40*30)
        when_label.frame = CGRect(x: width_cell/40*17, y: height_cell/40*2, width: width_cell/40*21, height: height_cell/40*22)
        times_label.frame = CGRect(x: width_cell/40*17, y: height_cell/40*26, width: width_cell/40*21, height: height_cell/40*12)
        var index_num = 0
        switch indexPath.row {
        case 0:
            reCall.whichSubject = "pH"
            name_label.text = "pH"
        case 1:
            reCall.whichSubject = "Cl"
            name_label.text = "残留塩素"
        case 2:
            reCall.whichSubject = "亜鉛"
            name_label.text = "硬度"
        default:
            cell.backgroundView?.backgroundColor = .clear
            cell.backgroundColor = .clear
        }
        reCall.getContents()
        index_num = reCall.yearList.count
        print("check=\(proCheck.check_mesure())")
        print("num = \(index_num)")
        if (index_num == 0 || proCheck.check_mesure() < 0)
        {
            when_label.text = "最終測定：\nなし"
            times_label.text = "回数：0"
        }
        else
        {
            times_label.text = "回数：\(reCall.yearList.count)"
            when_label.text = "最終測定：\n\(reCall.yearList[index_num-1])年 \(reCall.monthList[index_num-1])月\(reCall.dayList[index_num-1])日\(reCall.hourList[index_num-1])時\(reCall.minuteList[index_num-1])分"
        }
        return (cell)
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return (view.frame.height / 6)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let logVC = (storyboard?.instantiateViewController(identifier: "log"))! as LogDetaillViewController
        switch indexPath.row {
        case 0:
            logVC.whichSubject = "pH"
        case 1:
            logVC.whichSubject = "Cl"
        case 2:
            logVC.whichSubject = "硬度"
        default:
            print("")
        }
        navigationController?.pushViewController(logVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func goSetAction(_ sender: Any)
    {
        let setVC = storyboard?.instantiateViewController(identifier: "setting") as! SetMainViewController
        navigationController?.pushViewController(setVC, animated: true)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
}
