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
    
    var timestrList = [String]()
    var yearList = [String]()
    var monthList = [String]()
    var dayList = [String]()
    var hourList = [String]()
    var minuteList = [String]()
    var secondList = [String]()
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
                                         lat: latList[index_num], lot: lotList[index_num], time: String(timestrList[index_num]),
                                         year: String(yearList[index_num]), month: String(monthList[index_num]),
                                         day: String(dayList[index_num]), hour: String(hourList[index_num]),
                                         minute: String(minuteList[index_num]), second: String(secondList[index_num]),
                                         category: categoryList[index_num], sikensi: sikensiList[index_num]))
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
        timestrList = saveDataGetString(key: subject + v.UD_TIME, Array: timestrList)
        yearList = saveDataGetString(key: subject + v.UD_YEAR, Array: yearList)
        monthList = saveDataGetString(key: subject + v.UD_MONTH, Array: monthList)
        print("monthlst=",monthList)
        dayList = saveDataGetString(key: subject + v.UD_DAY, Array: dayList)
        hourList = saveDataGetString(key: subject + v.UD_HOUR, Array: hourList)
        minuteList = saveDataGetString(key: subject + v.UD_MINUTE, Array: minuteList)
        secondList = saveDataGetString(key: subject + v.UD_SECOND, Array: secondList)
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
        
        let ope_con = operate_contents()
        timestrList.append(ope_con.get_time_string(year: time_info.year, month: time_info.month, day: time_info.day, hour: time_info.hour, minute: time_info.minute, second: time_info.second))
        yearList.append(time_info.year)
        monthList.append(time_info.month)
        dayList.append(time_info.day)
        hourList.append(time_info.hour)
        minuteList.append(time_info.minute)
        secondList.append(time_info.second)
    }
    
    func ud_data_save(subject : String)
    {
        ud.set(outcomeList, forKey: subject + v.UD_OUTCOME)
        ud.set(addressList, forKey: subject + v.UD_ADDRESS)
        ud.set(latList, forKey: subject + v.UD_LAT)
        ud.set(lotList, forKey: subject + v.UD_LOT)
        ud.set(timestrList, forKey: subject + v.UD_TIME)
        ud.set(yearList, forKey: subject + v.UD_YEAR)
        ud.set(monthList, forKey: subject + v.UD_MONTH)
        ud.set(dayList, forKey: subject + v.UD_DAY)
        ud.set(hourList, forKey: subject + v.UD_HOUR)
        ud.set(minuteList, forKey: subject + v.UD_MINUTE)
        ud.set(secondList, forKey: subject + v.UD_SECOND)
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
