//
//  LogMainViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit

class LogMainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ud_data = UD_data()
    var proCheck = Procheck()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (2)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let subjectLabel = tableView.viewWithTag(1) as! UILabel
        let lastTimeLabel = tableView.viewWithTag(2) as! UILabel
        let cntLabel = tableView.viewWithTag(3) as! UILabel
        func setView() {
            cell.backgroundColor = .white
            cell.detailTextLabel?.textColor = .black
            cell.textLabel?.textColor = .black
            lastTimeLabel.numberOfLines = 2
            let cellHeight = cell.frame.size.height
            let cellWidth = cell.frame.size.width
            subjectLabel.frame = CGRect(x: cellWidth/40*2, y: cellHeight/40*5, width: cellWidth/40*13, height: cellHeight/40*30)
            lastTimeLabel.frame = CGRect(x: cellWidth/40*17, y: cellHeight/40*2, width: cellWidth/40*21, height: cellHeight/40*22)
            cntLabel.frame = CGRect(x: cellWidth/40*17, y: cellHeight/40*26, width: cellWidth/40*21, height: cellHeight/40*12)
        }
        setView()
        switch indexPath.row {
        case 0:
            ud_data.getContents(subject: v.PH)
            subjectLabel.text = "pH"
        case 1:
            ud_data.getContents(subject: v.CL)
            subjectLabel.text = "残留塩素"
        default:
            print("Error")
        }
        let udCnt = ud_data.yearList.count
        var lastTime = "なし"
        if udCnt != 0 {
            lastTime = "\(ud_data.yearList[udCnt-1])年 \(ud_data.monthList[udCnt-1])月\(ud_data.dayList[udCnt-1])日\(ud_data.hourList[udCnt-1])時\(ud_data.minuteList[udCnt-1])分"
        }
        lastTimeLabel.text = "最終測定：\n" + lastTime
        cntLabel.text = "回数：" + String(udCnt)
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let logVC = (storyboard?.instantiateViewController(identifier: "log"))! as LogDetaillViewController
        switch indexPath.row {
        case 0:
            logVC.subject = v.PH
        case 1:
            logVC.subject = v.CL
        default:
            print("Error")
        }
        navigationController?.pushViewController(logVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    @IBAction func goSetAction(_ sender: Any) {
        let setVC = storyboard?.instantiateViewController(identifier: "setting") as! SetMainViewController
        navigationController?.pushViewController(setVC, animated: true)
    }
}
