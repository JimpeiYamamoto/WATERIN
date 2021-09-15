//
//  Graph.swift
//  WaterChecker1
//
//  Created by 水代謝システム工学研究室 on 2020/07/12.
//  Copyright © 2020 水代謝システム工学研究室. All rights reserved.
//

import Foundation
import Charts
//getEntryはこっちに宣言しておく
extension LogDetaillViewController{
    
    func getEntry_week(){
        entry.removeAll()
        if cate_tf.text == "全てのデータ"
        {
            if WeekGraphClass.fM != WeekGraphClass.lM
            {
                filterdContents = contents.filter {(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Fyear && Int(contents.month!)! == WeekGraphClass.fM && Int(contents.day!)! >= WeekGraphClass.fD
                }
                for F in filterdContents
                {
                    let x_f = WeekGraphClass.dayOfWeek(Int(F.year!)!, Int(F.month!)!, Int(F.day!)!)
                    let y_f = F.atai
                    entry.append(ChartDataEntry(x: Double(x_f), y: y_f!))
                }
                filterdContents = self.contents.filter {(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Lyear && Int(contents.month!)! == WeekGraphClass.lM && Int(contents.day!)! <= WeekGraphClass.lD
                }
                for L in filterdContents
                {
                    let x_l = WeekGraphClass.dayOfWeek(Int(L.year!)!, Int(L.month!)!, Int(L.day!)!)
                    let y_l = L.atai
                    entry.append(ChartDataEntry(x: Double(x_l), y: y_l!))
                }
            }
            else
            {
                filterdContents = self.contents.filter{(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Fyear && Int(contents.month!)! == WeekGraphClass.fM && Int(contents.day!)! >= WeekGraphClass.fD && Int(contents.day!)! <= WeekGraphClass.lD
                }
                for fi in filterdContents
                {
                    let x = WeekGraphClass.dayOfWeek(Int(fi.year!)!, Int(fi.month!)!, Int(fi.day!)!)
                    let y = fi.atai
                    entry.append(ChartDataEntry(x: Double(x), y: y!))
                }
            }
        }
        else
        {
            if WeekGraphClass.fM != WeekGraphClass.lM{
                filterdContents = contents.filter {(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Fyear && Int(contents.month!)! == WeekGraphClass.fM && Int(contents.day!)! >= WeekGraphClass.fD && contents.category == cate_tf.text
                }
                for F in filterdContents{
                    let x_f = WeekGraphClass.dayOfWeek(Int(F.year!)!, Int(F.month!)!, Int(F.day!)!)
                    let y_f = F.atai
                    entry.append(ChartDataEntry(x: Double(x_f), y: y_f!))
                }
                filterdContents = self.contents.filter {(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Lyear && Int(contents.month!)! == WeekGraphClass.lM && Int(contents.day!)! <= WeekGraphClass.lD && contents.category == cate_tf.text
                }
                for L in filterdContents{
                    let x_l = WeekGraphClass.dayOfWeek(Int(L.year!)!, Int(L.month!)!, Int(L.day!)!)
                    let y_l = L.atai
                    entry.append(ChartDataEntry(x: Double(x_l), y: y_l!))
                }
            }else{
                filterdContents = self.contents.filter{(contents: Contents) -> Bool in return
                    Int(contents.year!)! == WeekGraphClass.Fyear && Int(contents.month!)! == WeekGraphClass.fM && Int(contents.day!)! >= WeekGraphClass.fD && Int(contents.day!)! <= WeekGraphClass.lD && contents.category == cate_tf.text
                }
                for fi in filterdContents{
                    let x = WeekGraphClass.dayOfWeek(Int(fi.year!)!, Int(fi.month!)!, Int(fi.day!)!)
                    let y = fi.atai
                    entry.append(ChartDataEntry(x: Double(x), y: y!))
                }
            }
        }
        let datSet = LineChartDataSet(entries: entry)
        datSet.highlightColor = .clear
        datSet.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        datSet.lineWidth = 2.0
        datSet.circleRadius = 3
        datSet.drawValuesEnabled = false
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        let data = LineChartData(dataSet: datSet)
        chartView.data = data
        print("週チャートの使用されるentry:", entry)
        print("週チャートの使用されるdata:", datSet.entries)
    }
    
    func getEntry_month(){
        entry.removeAll()
        if cate_tf.text == "全てのデータ"{
            filterdContents = self.contents.filter{(contents:Contents)-> Bool in return
                Int(contents.year!)! == MonthGraphClass.Fyear && Int(contents.month!)! == MonthGraphClass.fM
            }
            for filter in filterdContents{
                let x = filter.day!
                let y = filter.atai
                entry.append(ChartDataEntry(x: Double(x)!, y: y!))
            }
        }else{
            filterdContents = self.contents.filter{(contents:Contents)-> Bool in return
                Int(contents.year!)! == MonthGraphClass.Fyear && Int(contents.month!)! == MonthGraphClass.fM && contents.category == cate_tf.text
            }
            for filter in filterdContents{
                let x = filter.day!
                let y = filter.atai
                entry.append(ChartDataEntry(x: Double(x)!, y: y!))
            }
        }
        let datSet = LineChartDataSet(entries: entry)
        datSet.highlightColor = .clear
        datSet.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        datSet.lineWidth = 2.0
        datSet.circleRadius = 3
        datSet.drawValuesEnabled = false
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        
        let data = LineChartData(dataSet: datSet)
        chartView.data = data
        print("月チャートの使用されるentry:", entry)
        print("月チャートの使用されるdata:", datSet.entries)
    }
    
    func getEntry_year(){
        entry.removeAll()
        print("categoryLabel.text", cate_tf.text as Any)
        if cate_tf.text == "全てのデータ"{
            filterdContents = self.contents.filter{(contents:Contents)-> Bool in return
                (Int(contents.year!)! == YearGraphClass.Fyear)
            }
            for filter in filterdContents{
                let x = get_x_year(month: filter.month!, day: filter.day!, year:filter.year!)
                let y = filter.atai!
                entry.append(ChartDataEntry(x: x, y: y))
            }
        }else{
            filterdContents = self.contents.filter{(contents)-> Bool in return
                ((Int(contents.year!)! == YearGraphClass.Fyear) && (contents.category == cate_tf.text))
            }
            for filter in filterdContents{
                let x = get_x_year(month: filter.month!, day: filter.day!, year:filter.year!)
                let y = filter.atai!
                entry.append(ChartDataEntry(x: x, y: y))
            }
        }
        let datSet = LineChartDataSet(entries: entry)
        datSet.highlightColor = .clear
        datSet.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        datSet.lineWidth = 2.0
        datSet.circleRadius = 3
        datSet.drawValuesEnabled = false
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        
        let data = LineChartData(dataSet: datSet)
        chartView.data = data
        print("年チャートの使用されるentry:", entry)
        print("fileterdContents:", filterdContents)
    }
}

class WeekGraph{
    
    var year = Int()
    var month = Int()
    var day = Int()
    var Yobi = Int()
    
    var Fyear = Int()
    var Lyear = Int()
    var fM = Int()
    var fD = Int()
    var lM = Int()
    var lD = Int()
    
    var monthMaxDay = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
    
    //最初に今日の日の週を表示させる
    func First() -> [String:Int]{
        getDate()
        if (month == 1 && day - Yobi < 1){
            Fyear = year - 1
            Lyear = year
            fM = 12
            fD = 31 - (Yobi - day)
            lM = 1
            lD = day + 6 - Yobi
            
        }else if (month == 12 && day + 6 - Yobi > monthMaxDay[fM]!){
            Fyear = year
            Lyear = year + 1
            fM = 12
            fD = day - Yobi
            lM = 1
            lD = (6 - Yobi) - (monthMaxDay[fM]! - day)
            
        }else if (day - Yobi < 1){
            Fyear = year
            Lyear = year
            fM = month - 1
            fD = monthMaxDay[fM]! - (Yobi - day)
            lM = month
            lD = day + (6 - Yobi)
            
        }else if (day + 6 - Yobi > monthMaxDay[month]!){
            Fyear = year
            Lyear = year
            fM = month
            fD = day - Yobi
            lM = month + 1
            lD = 6 - Yobi - (monthMaxDay[fM]! - day)
            
        }else{
            Fyear = year
            Lyear = year
            fM = month
            fD = day - Yobi
            lM = month
            lD = day + 6 - Yobi
        }
        var setDict:[String:Int] = [:]
        
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        return (setDict)
    }
    
    func getNew()->[String:Int]{
        
        if (lM == 12 && lD == 31){
            Fyear += 1
            Lyear = Fyear
            checkURU()
            fM = 1
            fD = 1
            lM = 1
            lD = 7
                
        }else if (lM == 12 && lD > 24){
            Lyear = Fyear + 1
            checkURU()
            fM = 12
            fD = lD + 1
            lM = 1
            lD = 6 - (monthMaxDay[fM]! - fD)
                
        }else if (fM == 12 && lM == 1){
            Fyear += 1
            Lyear = Fyear
            checkURU()
            fM = 1
            fD = lD + 1
            lM = 1
            lD = fD + 6
            
        }else if (lD == monthMaxDay[lM]){
            //Fyear = Fyear
            //Lyear = Lyear
            checkURU()
            fM = lM + 1
            fD = 1
            lM = fM
            lD = 7
                
        }else if (lD + 7 > monthMaxDay[lM]!){
            //Fyear = Fyear
            //Lyear = Lyear
            checkURU()
            fM = lM
            fD = lD + 1
            lM = fM + 1
            lD = 6 - (monthMaxDay[fM]! - fD)
                
        }else{
            Lyear = Fyear
            checkURU()
            fM = lM
            fD = lD + 1
            lM = fM
            lD = fD + 6
        }
        var setDict:[String:Int] = [:]
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        return (setDict)
    }
        
    func getOld()->[String:Int]{
        
        if (fM == 1 && fD == 1){
            Fyear -= 1
            Lyear -= 1
            checkURU()
            lM = 12
            lD = 31
            fM = 12
            fD = 25
                
        }else if (fM == 1 && fD < 8){
            Lyear = Fyear
            Fyear -= 1
            checkURU()
            lM = 1
            lD = fD - 1
            fM = 12
            fD = monthMaxDay[fM]! - (6 - lD)
            
        }else if (fM == 12 && lM == 1){
            //Fyear = Fyear
            Lyear = Fyear
            checkURU()
            lM = 12
            lD = fD - 1
            fM = 12
            fD = lD - 6
            
        }else if (fD == 1){
    //            Lyear = Lyear
    //            Fyear = Fyear
            checkURU()
            lM = fM - 1
            lD = monthMaxDay[lM]!
            fM = lM
            fD = monthMaxDay[lM]! - 6
            
        }else if (fD < 8){
    //           Lyear = Lyear
    //           Fyear = Fyear
            checkURU()
            lM = fM
            lD = fD - 1
            fM = lM - 1
            fD = monthMaxDay[fM]! - (6 - lD)
                
        }else{
    //           Lyear = Lyear
    //            Fyear = Fyear
            checkURU()
            lM = fM
            lD = fD - 1
            fM = lM
            fD = lD - 6
            
        }
        var setDict:[String:Int] = [:]
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        return (setDict)
    }
        
    func getDate(){
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.dateComponents([.year, .month, .day], from: Date())
        year = date.year!
        month = date.month!
        day = date.day!
        Yobi = dayOfWeek(year, month, day)
            //もしうるう年なら、2月29日とする
        if isLeapYear(year: year) == true{
            monthMaxDay[2] = 29
        }
    }
    //もし閏年だったなら、trueを返す
    func isLeapYear(year: Int) -> Bool {
        return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
    }
    
    func dayOfWeek(_ year: Int, _ month: Int, _ day: Int) -> Int
    {
        let zellerCongruence = { (year: Int, month: Int, day: Int) in (year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7 }
        var year = year
        var month = month
        if month == 1 || month == 2 {
            year -= 1
            month += 12
        }
        return zellerCongruence(year, month, day)
    }
        
    func checkURU()
    {
        if isLeapYear(year: Fyear) == true
        {
            monthMaxDay[2] = 29
        }
        else
        {
            monthMaxDay[2] = 28
        }
    }
}
