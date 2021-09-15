//
//  SelectSikensiViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit

class SelectSikensiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var pen_or_paper = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        let width = view.frame.size.width
        let height = view.frame.size.height
        tableView.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*36, height: height/40*33)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if (pen_or_paper == 1)
        {
            self.navigationItem.title = "三菱鉛筆のプロパス・ウインドウ"
        }
        else
        {
            self.navigationItem.title = "試験紙を選択してください"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.textColor = .black
        cell.textLabel?.numberOfLines = 2
        if (pen_or_paper == 1)
        {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "橙・空色・緑"
            case 1:
                cell.textLabel?.text = "桃・空色・緑"
            case 2:
                cell.textLabel?.text = "蛍光ペンなし"
            default:
                print("")
            }
        }
        else
        {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "MACHERY-NAGEL Universal-Indikatorpaper"
            case 1:
                cell.textLabel?.text = "ADVANTEC TEST PAPER"
            case 2:
                cell.textLabel?.text = "MQuant pH-indicator strips"
            default:
                print("")
            }
        }
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let nav = self.navigationController!
        let preVC = nav.viewControllers[nav.viewControllers.count-2] as! PreMesureViewController
        var text = String()
        if (pen_or_paper == 1)
        {
            switch indexPath.row {
            case 0:
                text = "橙・空色・緑"
            case 1:
                text = "桃・空色・緑"
            default:
                text = "蛍光ペンなし"
            }
            preVC.whichPen = text
        }
        else
        {
            switch indexPath.row {
            case 0:
                text = "MACHERY-NAGEL Universal-Indikatorpaper"
            case 1:
//                text = "ADVANTEC TEST PAPER"
                alert(title: "現在開発中です", message: "大変申し訳ございません。\n近日公開するのでお楽しみに。")
            default:
                //text = "MQuant pH-indicator strips"
                alert(title: "現在開発中です", message: "大変申し訳ございません。\n近日公開するのでお楽しみに。")
            }
            preVC.whichSikensi = text
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return (1)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return (view.frame.size.height / 10)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
    }
}
