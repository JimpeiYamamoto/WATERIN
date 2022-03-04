//
//  ResultCall.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/16.
//

import Foundation

class UD_data
{
    let ud = UserDefaults.standard
    
    var yearList = [Int]()
    var monthList = [Int]()
    var dayList = [Int]()
    var hourList = [Int]()
    var minuteList = [Int]()
    var outcomeList = [Double]()
    var latList = [String]()
    var lotList = [String]()
    var addressList = [String]()
    var sikensiList = [String]()
    var categoryList = [String]()
    var contents = [Contents]()
    
    func getContents(subject:String)
    {
        ud_data_fetch(subject: subject)
        contents.removeAll()
        var index_num = 0
        if (outcomeList.count != 0)
        {
            for _ in outcomeList
            {
                contents.append(Contents(atai: outcomeList[index_num], address: addressList[index_num],
                                         lat: latList[index_num], lot: lotList[index_num],
                                         year: String(yearList[index_num]), month: String(monthList[index_num]),
                                         day: String(dayList[index_num]), hour: String(hourList[index_num]),
                                         minute: String(minuteList[index_num]), category: categoryList[index_num],
                                         sikensi: sikensiList[index_num]))
                index_num += 1
            }
        }
    }
    
    func ud_data_fetch(subject : String)
    {
        /** double */
        outcomeList = saveDataGetDouble(key: subject + v.UD_OUTCOME, Array: outcomeList)
        /** string*/
        addressList = saveDataGetString(key: subject + v.UD_ADDRESS, Array: addressList)
        latList = saveDataGetString(key: subject + v.UD_LAT, Array: latList)
        lotList = saveDataGetString(key: subject + v.UD_LOT, Array: lotList)
        categoryList = saveDataGetString(key: subject + v.UD_CATEGORY, Array: categoryList)
        sikensiList = saveDataGetString(key: subject + v.UD_PAPER, Array: sikensiList)
        /** int */
        yearList = saveDataGetInt(key: subject + v.UD_YEAR, Array: yearList)
        monthList = saveDataGetInt(key: subject + v.UD_MONTH, Array: monthList)
        dayList = saveDataGetInt(key: subject + v.UD_DAY, Array: dayList)
        hourList = saveDataGetInt(key: subject + v.UD_HOUR, Array: hourList)
        minuteList = saveDataGetInt(key: subject + v.UD_MINUTE, Array: minuteList)
    }
    
    func ud_data_append(subject : String, t_info:take_info, time_info:TimeClass, l_info:location_info)
    {
        ud_data_fetch(subject:subject)
        outcomeList.append(t_info.outcome!)
        
        addressList.append(l_info.address!)
        latList.append(l_info.lat!)
        lotList.append(l_info.lot!)
        categoryList.append(t_info.category!)
        sikensiList.append(t_info.paper!)
        
        yearList.append(Int(time_info.year)!)
        monthList.append(Int(time_info.month)!)
        dayList.append(Int(time_info.day)!)
        hourList.append(Int(time_info.hour)!)
        minuteList.append(Int(time_info.minute)!)
        
    }
    
    func ud_data_save(subject : String)
    {
        ud.set(outcomeList, forKey: subject + v.UD_OUTCOME)
        ud.set(addressList, forKey: subject + v.UD_ADDRESS)
        ud.set(latList, forKey: subject + v.UD_LAT)
        ud.set(lotList, forKey: subject + v.UD_LOT)
        ud.set(yearList, forKey: subject + v.UD_YEAR)
        ud.set(monthList, forKey: subject + v.UD_MONTH)
        ud.set(dayList, forKey: subject + v.UD_DAY)
        ud.set(hourList, forKey: subject + v.UD_HOUR)
        ud.set(minuteList, forKey: subject + v.UD_MINUTE)
        ud.set(categoryList, forKey: subject + v.UD_CATEGORY)
        ud.set(sikensiList, forKey: subject + v.UD_PAPER)
    }
    
    func saveDataGetString(key:String, Array:[String]) -> [String]
    {
        var saveArray = Array
        if ud.array(forKey: key) != nil{
            saveArray = ud.array(forKey: key) as! [String]
            return (saveArray)
        }
        return ([])
    }
    
    func saveDataGetInt(key:String, Array:[Int])->[Int]
    {
        var saveArray = Array
        if ud.array(forKey: key) != nil{
            saveArray = ud.array(forKey: key) as! [Int]
            return (saveArray)
        }
        return ([])
    }
    
    func saveDataGetDouble(key:String, Array:[Double]) -> [Double]
    {
        var saveArray = Array
        if ud.array(forKey: key) != nil{
            saveArray = ud.array(forKey: key) as! [Double]
            return (saveArray)
        }
        return ([])
    }
}
