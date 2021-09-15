//
//  YearGraph.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/06.
//

import Foundation
import Charts

class YearGraph{
 
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
    
    func First()->[String:Int]{
        getDate()
        
        Fyear = year
        Lyear = year
        fM = 1
        lM = 12
        fD = 1
        lD = 31
        
        var setDict:[String:Int] = [:]
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        
        return setDict
    }
    
    func getNew()->[String:Int]{
        
        Fyear += 1
        Lyear += 1
        checkURU()
        fM = 1
        lM = 12
        fD = 1
        lD = 31
        
        var setDict:[String:Int] = [:]
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        
        return setDict
    }
    
    func getOld()->[String:Int]{
        Fyear -= 1
        Lyear -= 1
        checkURU()
        fM = 1
        lM = 12
        fD = 1
        lD = 31
        var setDict:[String:Int] = [:]
        setDict.updateValue(Fyear, forKey: "Fyear")
        setDict.updateValue(Lyear, forKey: "Lyear")
        setDict.updateValue(fM, forKey: "fM")
        setDict.updateValue(fD, forKey: "fD")
        setDict.updateValue(lM, forKey: "lM")
        setDict.updateValue(lD, forKey: "lD")
        
        return setDict
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
    
    func dayOfWeek(_ year: Int, _ month: Int, _ day: Int) -> Int {
        let zellerCongruence = { (year: Int, month: Int, day: Int) in (year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7 }
        var year = year
        var month = month
        if month == 1 || month == 2 {
            year -= 1
            month += 12
        }
        return zellerCongruence(year, month, day)
    }
    func checkURU(){
        if isLeapYear(year: Fyear) == true{
            monthMaxDay[2] = 29
        }else{
            monthMaxDay[2] = 28
        }
    }
}
