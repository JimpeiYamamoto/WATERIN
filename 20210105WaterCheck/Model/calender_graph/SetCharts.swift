//
//  SetCharts.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/07.
//


extension LogDetaillViewController{
    func setCharts(year:Int, month:Int){
        var monthMaxDay = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
        if isLeapYear(year: year)==true{
            monthMaxDay[2] = 29
        }else{
            monthMaxDay[2] = 28
        }
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.legend.enabled = true
        chartView.xAxis.enabled = true
        //左のラベルをなくす
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = true
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
        if WeekOrMonthOrYear == "週"{
            chartView.xAxis.axisMaximum = 6.2
        }else if WeekOrMonthOrYear == "月"{
            chartView.xAxis.axisMaximum = Double(monthMaxDay[month]!) + 0.2
        }else if WeekOrMonthOrYear == "年"{
            if isLeapYear(year: year)==true{
                chartView.xAxis.axisMaximum = 366 + 0.2
            }else{
                chartView.xAxis.axisMaximum = 365 + 0.2
            }
        }
        if (whichSubject == "pH")
        {
            chartView.leftAxis.axisMaximum = 14
        }
        else
        {
            chartView.leftAxis.axisMaximum = 100
        }
        chartView.leftAxis.axisMinimum = 0
        chartView.xAxis.axisMinimum = 0
        chartView.leftAxis.labelTextColor = .black
        chartView.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        chartView.legend.enabled = false
        chartView.extraTopOffset = 0.0
        chartView.extraLeftOffset = 0.0
        chartView.extraRightOffset = 0.0
        chartView.extraBottomOffset = 0.0
    }
    //もし閏年だったなら、trueを返す
    func isLeapYear(year: Int) -> Bool {
        return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
    }
    
    func get_x_year(month:String, day:String, year:String)->Double{
        var x = 0.0
        let month = Int(month)
        let day = Int(day)
        var monthMaxDay = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
        
        if isLeapYear(year: Int(year)!)==true{
            monthMaxDay[2] = 29
        }else{
            monthMaxDay[2] = 28
        }
        
        if month == 1{
            x = Double(day!)
        }else if month == 2{
            x = Double(monthMaxDay[1]!+day!)
        }else if month == 3{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+day!)
        }else if month == 4{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+day!)
        }else if month == 5{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+day!)
        }else if month == 6{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+day!)
        }else if month == 7{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+day!)
        }else if month == 8{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+monthMaxDay[7]!+day!)
        }else if month == 9{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+monthMaxDay[7]!+monthMaxDay[8]!+day!)
        }else if month == 10{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+monthMaxDay[7]!+monthMaxDay[8]!+monthMaxDay[9]!+day!)
        }else if month == 11{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+monthMaxDay[7]!+monthMaxDay[8]!+monthMaxDay[9]!+monthMaxDay[10]!+day!)
        }else if month == 12{
            x = Double(monthMaxDay[1]!+monthMaxDay[2]!+monthMaxDay[3]!+monthMaxDay[4]!+monthMaxDay[5]!+monthMaxDay[6]!+monthMaxDay[7]!+monthMaxDay[8]!+monthMaxDay[9]!+monthMaxDay[10]!+monthMaxDay[11]!+day!)
        }
        
        return x
    }
}
