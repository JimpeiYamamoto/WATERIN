//
//  SetCharts.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/07.
//

import UIKit
import Charts

class LineChartsClass {
    let chartView = LineChartView()
    
    func setChartView(chartView:LineChartView){
        chartView.leftAxis.drawGridLinesEnabled = true
        chartView.legend.enabled = true
        chartView.xAxis.enabled = true
        chartView.leftAxis.drawLabelsEnabled = false
        chartView.leftAxis.labelFont = UIFont.systemFont(ofSize: 20)
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.xAxis.drawLabelsEnabled = false
        chartView.rightAxis.enabled = false
        chartView.leftAxis.enabled = true
        chartView.scaleXEnabled = false
        chartView.scaleYEnabled = false
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
    
    func setXYaxisRange(chartyView:LineChartView, c_info:Calender_Info, selectIndex:Int, subject:String) {
        let margin = 0.2
        if (subject == v.PH) {
            chartView.leftAxis.axisMaximum = 14
        } else {
            chartView.leftAxis.axisMaximum = 100
        }
        switch selectIndex {
        case 0:
            chartView.xAxis.axisMaximum = 6 + margin
        case 1:
            chartView.xAxis.axisMaximum = Double(c_info.ld) + margin
        case 2:
            if isLeapYear(year: c_info.fy){
                chartView.xAxis.axisMaximum = 366 + margin
            }else{
                chartView.xAxis.axisMaximum = 365 + margin
            }
        default:
            print("IndexError")
        }
    }
    
    func getEntry(contents: [Contents], c_info:Calender_Info, selectIndex:Int) -> [ChartDataEntry]{
        var ret = [ChartDataEntry]()
        var monthMaxDay = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30,
                           7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
        if isLeapYear(year: c_info.fy) {
            monthMaxDay[2] = 29
        }
        for content in contents {
            var x = 0.0
            if selectIndex == 0 || selectIndex == 1 {
                let xOrigin = Double(c_info.f_str)
                let xDiff = Double((content.time?.prefix(8))!)
                x = xDiff! - xOrigin!
            } else {
                for i in 1..<Int(content.month!)! {
                    x += Double(monthMaxDay[i]!)
                }
                x += Double(content.day!)!
            }
            let y = content.atai
            ret.append(ChartDataEntry(x: x, y: y!))
        }
        return ret
    }
    
    func drawChart(contents: [Contents], c_info: Calender_Info, chartView:LineChartView, selectIndex:Int, subject:String) {
        setXYaxisRange(chartyView: chartView, c_info: c_info, selectIndex: selectIndex, subject: subject)
        let entry = getEntry(contents: contents, c_info: c_info, selectIndex: selectIndex)
        let dataSet = LineChartDataSet(entries: entry)
        dataSet.highlightColor = .clear
        dataSet.colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        dataSet.lineWidth = 2.0
        dataSet.circleRadius = 3
        dataSet.drawValuesEnabled = false
        chartView.data = LineChartData(dataSets: [dataSet])
    }
    
    func isLeapYear(year: Int) -> Bool {
        return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
    }
}
