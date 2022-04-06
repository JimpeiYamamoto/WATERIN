//
//  LogDetaillViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import Charts
import Firebase

class LogDetaillViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let ud = UserDefaults.standard
    var yearList = [String]()
    var monthList = [String]()
    var dayList = [String]()
    var hourList = [String]()
    var minuteList = [String]()
    var ataiList = [Double]()
    var latList = [String]()
    var lotList = [String]()
    var addressList = [String]()
    var penList = [String]()
    var sikensiList = [String]()
    var categoryList = [String]()
    var whichSubject = String()
    var selectedCategory = String()
    var WeekOrMonthOrYear = "週"
    var dateDict = [String:Int]()
    var dateText = String()

    var ud_data = UD_data()
    var contents = [Contents]()
    var filterdContents = [Contents]()
    var cateContents = [Contents]()
    var Store = StoreClass()
    var proCheck = Procheck()
    var WeekGraphClass = WeekGraph()
    var MonthGraphClass = MonthGraph()
    var YearGraphClass = YearGraph()
    var entry = [ChartDataEntry]()
    let chartView = LineChartView()
    
    @IBOutlet weak var changeCategoryButton: UIButton!
    @IBOutlet weak var daySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cate_tf: UITextField!
   
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        set_view()
    }

    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title = "自分の結果"
        ud_data.getContents(subject : whichSubject)
        contents = ud_data.contents
        MakeCateFilList()
        //選択されたカテゴリーの名前を表示
        if (selectedCategory == "")
        {
            selectedCategory = "全てのデータ"
        }
        cate_tf.text = selectedCategory
        switch WeekOrMonthOrYear {
        case "週":
            dateDict = WeekGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/\(dateDict["fD"]!)~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        case "月":
            dateDict = MonthGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        case "年":
            dateDict = YearGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        default:
            print("")
        }
        tableView.reloadData()
    }
    
    @IBAction func changeCategoryAction(_ sender: Any)
    {
        let selectCateVC = storyboard?.instantiateViewController(identifier: "cate") as! SelectCateViewController
        selectCateVC.whichSubject = whichSubject
        navigationController?.pushViewController(selectCateVC, animated: true)
    }
    
    @IBAction func daySegementAction(_ sender: UISegmentedControl)
    {
        switch sender.selectedSegmentIndex {
        case 0:
            WeekOrMonthOrYear = "週"
            dateDict = WeekGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/\(dateDict["fD"]!)~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        case 1:
            WeekOrMonthOrYear = "月"
            dateDict = MonthGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        case 2:
            WeekOrMonthOrYear = "年"
            dateDict = YearGraphClass.First()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
        default:
            print("")
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        MakeCateFilList()
        return cateContents.count+3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCell(withIdentifier: "date")
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "date", for: indexPath)
            let back_button = tableView.viewWithTag(1) as! UIButton
            let next_button = tableView.viewWithTag(3) as! UIButton
            next_button.imageView?.contentMode = .scaleAspectFit
            next_button.contentHorizontalAlignment = .fill
            next_button.contentVerticalAlignment = .fill
            back_button.imageView?.contentMode = .scaleAspectFit
            back_button.contentHorizontalAlignment = .fill
            back_button.contentVerticalAlignment = .fill
            let date_tf = tableView.viewWithTag(100) as! UITextField
            date_tf.text = dateText
            date_tf.adjustsFontSizeToFitWidth = true
            date_tf.layer.borderWidth = 1
            date_tf.layer.borderColor = UIColor.black.cgColor
            
            cell!.backgroundColor = .white
            let c_w = (cell?.frame.size.width)! / 100
            let c_h = (cell?.frame.size.height)! / 100
            back_button.frame = CGRect(x: c_w * 3, y: c_h * 10, width: c_w * 20, height: c_h * 80)
            next_button.frame = CGRect(x: c_w * 77, y: c_h *  10, width: c_w * 20, height: c_h * 80)
            date_tf.frame = CGRect(x: c_w * 26, y: c_h * 10, width: c_w * 48, height: c_h * 80)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "chart", for: indexPath)
            cell!.selectionStyle = .none
            cell!.backgroundColor = .white
            switch WeekOrMonthOrYear {
            case "週":
                getEntry_week()
                setCharts(year: WeekGraphClass.Fyear, month: WeekGraphClass.fM)
            case "月":
                getEntry_month()
                setCharts(year: MonthGraphClass.Fyear, month: MonthGraphClass.fM)
            case "年":
                getEntry_year()
                setCharts(year: YearGraphClass.Fyear, month: YearGraphClass.fM)
            default:
                print("")
            }
            let fourteen = tableView.viewWithTag(24) as! UILabel
            let twelve = tableView.viewWithTag(22) as! UILabel
            let ten = tableView.viewWithTag(20) as! UILabel
            let eight = tableView.viewWithTag(18) as! UILabel
            let six = tableView.viewWithTag(16) as! UILabel
            let four = tableView.viewWithTag(14) as! UILabel
            let two = tableView.viewWithTag(12) as! UILabel
            let zero = tableView.viewWithTag(10) as! UILabel
            let c_w = cell!.frame.size.width
            let c_h = cell!.frame.size.height
            fourteen.frame = CGRect(x: c_w/80*2, y: c_h/80*4, width: c_h/80*3, height: c_h/80*3)
            twelve.frame = CGRect(x: c_w/80*2, y: c_h/80*14, width: c_h/80*3, height: c_h/80*3)
            ten.frame = CGRect(x: c_w/80*2, y: c_h/80*24, width: c_h/80*3, height: c_h/80*3)
            eight.frame = CGRect(x: c_w/80*2, y: c_h/80*34, width: c_h/80*3, height: c_h/80*3)
            six.frame = CGRect(x: c_w/80*2, y: c_h/80*44, width: c_h/80*3, height: c_h/80*3)
            four.frame = CGRect(x: c_w/80*2, y: c_h/80*54, width: c_h/80*3, height: c_h/80*3)
            two.frame = CGRect(x: c_w/80*2, y: c_h/80*64, width: c_h/80*3, height: c_h/80*3)
            zero.frame = CGRect(x: c_w/80*2, y: c_h/80*74, width: c_h/80*3, height: c_h/80*3)
            chartView.frame = CGRect(x: cell!.frame.size.width/40*3, y: cell!.frame.size.height/40, width: cell!.frame.size.width/40*36, height: cell!.frame.size.height/40*38)
            cell!.addSubview(chartView)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "log", for: indexPath)
            cell!.backgroundColor = .white
            let sokutei_label = tableView.viewWithTag(4) as! UILabel
            let sub_label = tableView.viewWithTag(10) as! UILabel
            let atai_label = tableView.viewWithTag(11) as! UILabel
            let height_cell = cell!.frame.size.height
            let width_cell = cell!.frame.size.width
            sub_label.frame = CGRect(x: width_cell/40*2, y: height_cell/40*2, width: width_cell/40*8, height: height_cell/40*36)
            sokutei_label.frame = CGRect(x: width_cell/40*12, y: height_cell/40*2, width: width_cell/40*12, height: height_cell/40*36)
            
            atai_label.frame = CGRect(x: width_cell/40*26, y: height_cell/40*2, width: width_cell/40*14, height: height_cell/40*36)
        default:
            MakeCateFilList()
            cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath)
            cell!.backgroundColor = .white
            let subject_label = tableView.viewWithTag(5) as! UILabel
            let date_label = tableView.viewWithTag(6) as! UILabel
            let year_label = tableView.viewWithTag(7) as! UILabel
            let outcome_label = tableView.viewWithTag(8) as! UILabel
            subject_label.text = whichSubject
            date_label.text = "\(cateContents[indexPath.row - 3].month!)/\(cateContents[indexPath.row - 3].day!) \(cateContents[indexPath.row - 3].hour!):\(cateContents[indexPath.row - 3].minute!)"
            year_label.text = "\(cateContents[indexPath.row - 3].year!)"
            outcome_label.text = "\(round(cateContents[indexPath.row - 3].atai! * 10) / 10)"
            let height_cell = cell!.frame.size.height
            let width_cell = cell!.frame.size.width
            subject_label.frame = CGRect(x: width_cell/40*2, y: height_cell/40*2, width: width_cell/40*8, height: height_cell/40*36)
            date_label.frame = CGRect(x: width_cell/40*12, y: height_cell/40*2, width: width_cell/40*12, height: height_cell/40*25)
            year_label.frame = CGRect(x: width_cell/40*12, y: height_cell/40*29, width: width_cell/40*12, height: height_cell/40*9)
            outcome_label.frame = CGRect(x: width_cell/40*26, y: height_cell/40*2, width: width_cell/40*14, height: height_cell/40*36)
        }
        return (cell!)
    }
    //削除できるように、編集を許可
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> (Bool)
    {
        var bool = false
        switch indexPath.row {
        case 0:
            bool = false
        case 1:
            bool = false
        case 2:
            bool = false
        default:
            bool = true
        }
        return bool
    }
    //セルの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let message =  "\(cateContents[indexPath.row-3].year!)年\(cateContents[indexPath.row-3].month!)月\(cateContents[indexPath.row-3].day!)日\(cateContents[indexPath.row-3].hour!)時\(cateContents[indexPath.row-3].minute!)分-\(whichSubject):\(cateContents[indexPath.row-3].atai!)"
            let alertSheet = UIAlertController(title: "選択したデータを削除します", message:message, preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { [self]
                (action: UIAlertAction!) in
                //削除するを選択したら呼ばれる
                let removeContents = Contents(atai: cateContents[indexPath.row-3].atai!, address: cateContents[indexPath.row-3].address!,
                                              lat: cateContents[indexPath.row-3].lat!, lot: cateContents[indexPath.row-3].lot!,
                                              time:cateContents[indexPath.row-3].time!, year:cateContents[indexPath.row-3].year!,
                                              month: cateContents[indexPath.row-3].month!, day: cateContents[indexPath.row-3].day!,
                                              hour: cateContents[indexPath.row-3].hour!, minute: cateContents[indexPath.row-3].minute!,
                                              second: cateContents[indexPath.row-3].second!,
                                              category: cateContents[indexPath.row-3].category!,
                                              sikensi: cateContents[indexPath.row-3].sikensi!)
                let index = contents.firstIndex(of: removeContents)
                print("削除する前", contents)
                print("削除するindex", index as Any)
                contents.remove(at: index!)
                print("削除した後", contents)
                ud_data.contents = contents
                //ここでyearListとかの中身を一度消さないといけない？
                yearList.removeAll()
                monthList.removeAll()
                dayList.removeAll()
                hourList.removeAll()
                minuteList.removeAll()
                ataiList.removeAll()
                latList.removeAll()
                lotList.removeAll()
                addressList.removeAll()
                sikensiList.removeAll()
                cateContents.removeAll()
                penList.removeAll()
                var num=0
                for _ in contents{
                    yearList.append(contents[num].year!)
                    monthList.append(contents[num].month!)
                    dayList.append(contents[num].day!)
                    hourList.append(contents[num].hour!)
                    minuteList.append(contents[num].minute!)
                    ataiList.append(contents[num].atai!)
                    latList.append(contents[num].lat!)
                    lotList.append(contents[num].lot!)
                    addressList.append(contents[num].address!)
                    sikensiList.append(contents[num].sikensi!)
                    categoryList.append(contents[num].category!)
                    num += 1
                }
                //データを更新
                ud_data.yearList = yearList
                ud_data.monthList = monthList
                ud_data.dayList = dayList
                ud_data.hourList = hourList
                ud_data.minuteList = minuteList
                ud_data.outcomeList = ataiList
                ud_data.latList = latList
                ud_data.lotList = lotList
                ud_data.addressList = addressList
                ud_data.sikensiList = sikensiList
                ud_data.categoryList = categoryList
                //保存
                ud_data.ud_data_save(subject: whichSubject)
                ud_data.getContents(subject: whichSubject)
                contents = ud_data.contents
                MakeCateFilList()
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
    
    func ActionSheet()
    {
        let alertSheet = UIAlertController(title: "以下のデータを削除してもよろしいですか？", message: "message", preferredStyle: UIAlertController.Style.actionSheet)
        let action1 = UIAlertAction(title: "削除する", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
        })
        let action3 = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: {
            (action: UIAlertAction!) in
        })
        alertSheet.addAction(action1)
        alertSheet.addAction(action3)
        self.present(alertSheet, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        var height = view.frame.size.height
        switch indexPath.row {
        case 0:
            height /= 10
        case 1:
            height /= 2
        case 2:
            height /= 12
        default:
            height /= 10
        }
        return height
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func MakeCateFilList()
    {
        if (cate_tf.text == "全てのデータ")
        {
            cateContents = ud_data.contents
        }
        else
        {
            cateContents = ud_data.contents.filter{ (contents) -> Bool in return
                cate_tf.text == contents.category
            }
        }
    }
    
    @IBAction func next_action(_ sender: Any)
    {
        switch WeekOrMonthOrYear {
        case "週":
            dateDict = WeekGraphClass.getNew()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/\(dateDict["fD"]!)~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_week()
            setCharts(year: WeekGraphClass.Fyear, month: WeekGraphClass.fM)
        case "月":
            dateDict = MonthGraphClass.getNew()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_month()
            setCharts(year: MonthGraphClass.Fyear, month: MonthGraphClass.fM)
        case "年":
            dateDict = YearGraphClass.getNew()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_year()
            setCharts(year: YearGraphClass.Fyear, month: YearGraphClass.fM)
        default:
            print("")
        }
        tableView.reloadData()
    }
    
    @IBAction func back_action(_ sender: Any)
    {
        switch WeekOrMonthOrYear {
        case "週":
            dateDict = WeekGraphClass.getOld()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/\(dateDict["fD"]!)~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_week()
            setCharts(year: WeekGraphClass.Fyear, month: WeekGraphClass.fM)
        case "月":
            dateDict = MonthGraphClass.getOld()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_month()
            setCharts(year: MonthGraphClass.Fyear, month: MonthGraphClass.fM)
        case "年":
            dateDict = YearGraphClass.getOld()
            dateText = "\(dateDict["Fyear"]!)年 \(dateDict["fM"]!)/1~\(dateDict["lM"]!)/\(dateDict["lD"]!)"
            getEntry_year()
            setCharts(year: YearGraphClass.Fyear, month: YearGraphClass.fM)
        default:
            print("")
        }
        tableView.reloadData()
    }

    @IBAction func shareAction(_ sender: Any)
    {
        let time_class = TimeClass()
        time_class.get_now_time()
        let fileName = "\(whichSubject)_\(String(cate_tf.text!))_\(time_class.year)_\(time_class.month)_\(time_class.day)_\(time_class.hour)_\(time_class.minute)"
        let message = makeCsv()
        print(message)
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = dir.appendingPathComponent(fileName)
        try! message.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        let activityViewController = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func makeCsv()->String
    {
        var csv = "time\tcategory\t\(whichSubject)"
        var row = ""
        for catecon in cateContents{
            let time = "\(catecon.year!)年\(catecon.month!)月\(catecon.day!)日\(catecon.hour!)時\(catecon.minute!)分"
            row = "\n\(time)\t\(catecon.category!)\t\(catecon.atai!)"
            
            csv += row
        }
        return (csv)
    }
    
    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        daySegment.backgroundColor = .white
        daySegment.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        let height = view.frame.size.height
        let width = view.frame.size.width
        cate_tf.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*30, height: height/40*3)
        changeCategoryButton.frame = CGRect(x: width/40*34, y: height/40*5, width: width/40*4, height: height/40*3)
        daySegment.frame = CGRect(x: width/40*2, y: height/40*9, width: width/40*36, height: height/40*2)
        tableView.frame = CGRect(x: 0, y: height/40*12, width: width, height: height/40*29)
    }
    
    func alert(title:String, message:String)
    {
        let alertController = UIAlertController(title: title,message: message,preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK",style: .default,handler: nil))
        present(alertController, animated: true)
   }
}
