//
//  getTime.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/10.
//
import UIKit

class GetTime{
    func getTime() -> [String:String]{
        let now = NSDate()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        let yearString = yearFormatter.string(from: now as Date)
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "M"
        let monthSting = monthFormatter.string(from: now as Date)
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        let dayString = dayFormatter.string(from: now as Date)
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "H"
        let hourString = hourFormatter.string(from: now as Date)
        let minuteFormatter = DateFormatter()
        minuteFormatter.dateFormat = "m"
        let minuteString = minuteFormatter.string(from: now as Date)
        var timeDict:[String:String] = [:]
        timeDict.updateValue(yearString, forKey: "year")
        timeDict.updateValue(monthSting, forKey: "month")
        timeDict.updateValue(dayString, forKey: "day")
        timeDict.updateValue(hourString, forKey: "hour")
        timeDict.updateValue(minuteString, forKey: "minute")
        return (timeDict)
    }
}
