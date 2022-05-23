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
    var subject = String()
    var c_info = Calender_Info(fy: 0, ly: 0, fm: 0, lm: 0, fd: 0, ld: 0)
    var ud_data = UD_data()
    var contents = [Contents]()
    let lineChart = LineChartsClass()
    
    @IBOutlet weak var changeCategoryButton: UIButton!
    @IBOutlet weak var daySegment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cate_tf: UITextField!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        setView()
        lineChart.setChartView(chartView: lineChart.chartView)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        daySegment.selectedSegmentIndex = 0
        let date = Calendar(identifier: .gregorian).dateComponents([.year, .month, .day],
                                                                   from: Date())
        c_info = Calender_Info.init(fy: date.year!, ly: date.year!,
                                    fm: date.month!, lm: date.month!,
                                    fd: date.day!, ld: date.day!)
        c_info = Week_Calender().init_info(c_info: c_info)
        ud_data.getContents(subject : subject)
        contents = filterContents()
        lineChart.drawChart(contents: contents,
                            c_info: c_info,
                            chartView:lineChart.chartView,
                            selectIndex: daySegment.selectedSegmentIndex,
                            subject: subject)
        tableView.reloadData()
    }
    
    @IBAction func changeCategoryAction(_ sender: Any) {
        let selectCateVC = storyboard?.instantiateViewController(identifier: "cate") as! SelectCateViewController
        selectCateVC.whichSubject = subject
        navigationController?.pushViewController(selectCateVC, animated: true)
    }
    
    @IBAction func daySegementAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            c_info = Week_Calender().init_info(c_info: c_info)
        case 1:
            c_info = Month_Calender().init_info(c_info: c_info)
        case 2:
            c_info = Year_Calender().init_info(c_info: c_info)
        default:
            print("IndexError")
        }
        contents = filterContents()
        lineChart.drawChart(contents: contents,
                            c_info: c_info,
                            chartView: lineChart.chartView,
                            selectIndex: daySegment.selectedSegmentIndex,
                            subject: subject)
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count+3
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "date")
        tableView.backgroundColor = .white
        tableView.allowsSelection = false
        switch indexPath.row {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "date",
                                                 for: indexPath)
            let back_button = tableView.viewWithTag(1) as! UIButton
            let next_button = tableView.viewWithTag(3) as! UIButton
            let date_tf = tableView.viewWithTag(100) as! UITextField
            date_tf.text = getDateText(c_info: c_info)
            setCellView0(dateTf: date_tf, backButton: back_button,
                         nextButton: next_button, cell: cell!)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "chart", for: indexPath)
            setCellView1(tableView: tableView, cell: cell!,chartView: lineChart.chartView)
            lineChart.drawChart(contents: contents, c_info: c_info, chartView: lineChart.chartView,
                                selectIndex: daySegment.selectedSegmentIndex, subject: subject)
            cell!.addSubview(lineChart.chartView)
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "log", for: indexPath)
            setCellView2(tableView: tableView, cell: cell!)
        default:
            cell = tableView.dequeueReusableCell(withIdentifier: "other", for: indexPath)
            let subLabel = tableView.viewWithTag(5) as! UILabel
            let dateLabel = tableView.viewWithTag(6) as! UILabel
            let yearLabel = tableView.viewWithTag(7) as! UILabel
            let ataiLabel = tableView.viewWithTag(8) as! UILabel
            subLabel.text = subject
            let row = indexPath.row-3
            dateLabel.text = "\(contents[row].month!)/\(contents[row].day!) \(contents[row].hour!):\(contents[row].minute!)"
            yearLabel.text = "\(contents[row].year!)"
            ataiLabel.text = "\(round(contents[row].atai! * 10) / 10)"
            setOtherCellView(cell: cell!, subLabel: subLabel,
                             dateLabel: dateLabel, yearLabel: yearLabel,
                             ataiLabel: ataiLabel)
        }
        cell!.backgroundColor = .white
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let row = indexPath.row - 3
            let message =  "\(contents[row].year!)年\(contents[row].month!)月\(contents[row].day!)日\(contents[row].hour!)時\(contents[row].minute!)分-\(subject):\(round(contents[row].atai!*10)/10)"
            let alertSheet = UIAlertController(title: "選択したデータを削除します",
                                               message:message,
                                               preferredStyle: UIAlertController.Style.actionSheet)
            let action1 = UIAlertAction(title: "OK",
                                        style: UIAlertAction.Style.default,
                                        handler: { [self] (action: UIAlertAction!) in
                let removeContents = Contents(atai: contents[indexPath.row-3].atai!,
                                              address: contents[indexPath.row-3].address!,
                                              lat: contents[indexPath.row-3].lat!,
                                              lot: contents[indexPath.row-3].lot!,
                                              time: contents[indexPath.row-3].time!,
                                              year: contents[indexPath.row-3].year!,
                                              month: contents[indexPath.row-3].month!,
                                              day: contents[indexPath.row-3].day!,
                                              hour: contents[indexPath.row-3].hour!,
                                              minute: contents[indexPath.row-3].minute!,
                                              second: contents[indexPath.row-3].second!,
                                              category: contents[indexPath.row-3].category!,
                                              sikensi: contents[indexPath.row-3].sikensi!)
                let index = ud_data.contents.firstIndex(of: removeContents)
                ud_data.contents.remove(at: index!)
                ud_data.ud_data_save(subject: subject)
                contents = filterContents()
                tableView.reloadData()
            })
            let action2 = UIAlertAction(title: "キャンセル",
                                        style: UIAlertAction.Style.cancel,
                                        handler: { (action: UIAlertAction!) in })
            alertSheet.addAction(action1)
            alertSheet.addAction(action2)
            self.present(alertSheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func next_action(_ sender: Any)
    {
        switch daySegment.selectedSegmentIndex {
        case 0:
            c_info = Week_Calender().proceed_week(c_info: c_info)
        case 1:
            c_info = Month_Calender().proceed_month(c_info: c_info)
        case 2:
            c_info = Year_Calender().proceed_year(c_info: c_info)
        default:
            print("IndexError")
        }
        contents = filterContents()
        lineChart.drawChart(contents: contents, c_info: c_info, chartView: lineChart.chartView,
                            selectIndex: daySegment.selectedSegmentIndex, subject: subject)
        tableView.reloadData()
    }
    
    @IBAction func back_action(_ sender: Any)
    {
        switch daySegment.selectedSegmentIndex {
        case 0:
            c_info = Week_Calender().back_week(c_info: c_info)
        case 1:
            c_info = Month_Calender().back_week(c_info: c_info)
        case 2:
            c_info = Year_Calender().back_year(c_info: c_info)
        default:
            print("Error")
        }
        contents = filterContents()
        lineChart.drawChart(contents: contents, c_info: c_info, chartView: lineChart.chartView,
                            selectIndex: daySegment.selectedSegmentIndex, subject: subject)
        print(contents)
        tableView.reloadData()
    }

    @IBAction func shareAction(_ sender: Any) {
        let time_class = TimeClass()
        time_class.get_now_time()
        let fileName = "\(subject)_\(String(cate_tf.text!))_\(time_class.year)_\(time_class.month)_\(time_class.day)_\(time_class.hour)_\(time_class.minute)"
        let csv = makeCsv()
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let filePath = dir.appendingPathComponent(fileName)
        try! csv.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        let activityViewController = UIActivityViewController(activityItems: [filePath], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }
    
    func makeCsv()->String {
        var csv = "time\tcategory\t\(subject)"
        var row = ""
        for catecon in contents{
            let time = "\(catecon.year!)年\(catecon.month!)月\(catecon.day!)日\(catecon.hour!)時\(catecon.minute!)分"
            row = "\n\(time)\t\(catecon.category!)\t\(catecon.atai!)"
            
            csv += row
        }
        return csv
    }
    
    func filterContents() -> [Contents]{
        var ret = [Contents]()
        ret =  operate_contents().filter_content_by_time(contents: ud_data.contents,
                                                         start: c_info.f_str,
                                                         stop: c_info.l_str)
        if cate_tf.text != "全てのデータ" {
            ret = ret.filter({ content-> Bool  in return
                cate_tf.text == content.category
            })
        }
        print("filterdContents=", ret)
        return ret
    }
    
    func getDateText(c_info:Calender_Info) -> String{
        var ret = String()
        switch daySegment.selectedSegmentIndex {
        case 0:
            ret = "\(c_info.fy)年 \(c_info.fm)/\(c_info.fd)~\(c_info.lm)/\(c_info.ld)"
        case 1:
            ret = "\(c_info.fy)年 \(c_info.fm)月"
        case 2:
            ret = "\(c_info.fy)年"
        default:
            print("IndexError")
        }
        return ret
    }
    
}
