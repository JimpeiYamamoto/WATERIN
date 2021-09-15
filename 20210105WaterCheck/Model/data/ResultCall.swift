//
//  ResultCall.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/16.
//

import Foundation

class ResultCall
{
    let ud = UserDefaults.standard
    var whichSubject = String()
    var yearList = [Int]()
    var monthList = [Int]()
    var dayList = [Int]()
    var hourList = [Int]()
    var minuteList = [Int]()
    var ataiList = [Double]()
    var latList = [String]()
    var lotList = [String]()
    var addressList = [String]()
    var sikensiList = [String]()
    var categoryList = [String]()
    var penList = [String]()
    var contents = [Contents]()
    
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
    
    func getContents()
    {
        contents.removeAll()
        switch whichSubject {
        case "pH":
            ataiList = saveDataGetDouble(key: "pH", Array: ataiList)
            addressList = saveDataGetString(key: "pH_add", Array: addressList)
            latList = saveDataGetString(key: "pH_lat", Array: latList)
            lotList = saveDataGetString(key: "pH_lot", Array: lotList)
            yearList = saveDataGetInt(key: "pH_year", Array: yearList)
            monthList = saveDataGetInt(key: "pH_month", Array: monthList)
            dayList = saveDataGetInt(key: "pH_day", Array: dayList)
            hourList = saveDataGetInt(key: "pH_hour", Array: hourList)
            minuteList = saveDataGetInt(key: "pH_minute", Array: minuteList)
            categoryList = saveDataGetString(key: "pH_cate", Array: categoryList)
            sikensiList = saveDataGetString(key: "pH_sike", Array: sikensiList)
            penList = saveDataGetString(key: "pH_pen", Array: penList)
        case "COD":
            ataiList = saveDataGetDouble(key: "COD", Array: ataiList)
            addressList = saveDataGetString(key: "COD_add", Array: addressList)
            latList = saveDataGetString(key: "COD_lat", Array: latList)
            lotList = saveDataGetString(key: "COD_lot", Array: lotList)
            yearList = saveDataGetInt(key: "COD_year", Array: yearList)
            monthList = saveDataGetInt(key: "COD_month", Array: monthList)
            dayList = saveDataGetInt(key: "COD_day", Array: dayList)
            hourList = saveDataGetInt(key: "COD_hour", Array: hourList)
            minuteList = saveDataGetInt(key: "COD_minute", Array: minuteList)
            categoryList = saveDataGetString(key: "COD_cate", Array: categoryList)
            sikensiList = saveDataGetString(key: "COD_sike", Array: sikensiList)
            penList = saveDataGetString(key: "COD_pen", Array: penList)
        case "Cl":
            ataiList = saveDataGetDouble(key: "Cl", Array: ataiList)
            addressList = saveDataGetString(key: "Cl_add", Array: addressList)
            latList = saveDataGetString(key: "Cl_lat", Array: latList)
            lotList = saveDataGetString(key: "Cl_lot", Array: lotList)
            yearList = saveDataGetInt(key: "Cl_year", Array: yearList)
            monthList = saveDataGetInt(key: "Cl_month", Array: monthList)
            dayList = saveDataGetInt(key: "Cl_day", Array: dayList)
            hourList = saveDataGetInt(key: "Cl_hour", Array: hourList)
            minuteList = saveDataGetInt(key: "Cl_minute", Array: minuteList)
            categoryList = saveDataGetString(key: "Cl_cate", Array: categoryList)
            sikensiList = saveDataGetString(key: "Cl_sike", Array: sikensiList)
            penList = saveDataGetString(key: "Cl_pen", Array: penList)
        case "亜鉛":
            ataiList = saveDataGetDouble(key: "亜鉛", Array: ataiList)
            addressList = saveDataGetString(key: "亜鉛_add", Array: addressList)
            latList = saveDataGetString(key: "亜鉛_lat", Array: latList)
            lotList = saveDataGetString(key: "亜鉛_lot", Array: lotList)
            yearList = saveDataGetInt(key: "亜鉛_year", Array: yearList)
            monthList = saveDataGetInt(key: "亜鉛_month", Array: monthList)
            dayList = saveDataGetInt(key: "亜鉛_day", Array: dayList)
            hourList = saveDataGetInt(key: "亜鉛_hour", Array: hourList)
            minuteList = saveDataGetInt(key: "亜鉛_minute", Array: minuteList)
            categoryList = saveDataGetString(key: "亜鉛_cate", Array: categoryList)
            sikensiList = saveDataGetString(key: "亜鉛_sike", Array: sikensiList)
            penList = saveDataGetString(key: "亜鉛_pen", Array: penList)
        default:
            print("UserDefault_key_miss")
        }
        //取り出したデータをコンテンツクラスへ移動
        var index_num = 0
        if (ataiList.count != 0)
        {
            for _ in ataiList
            {
                contents.append(Contents(atai: ataiList[index_num], address: addressList[index_num], lat: latList[index_num], lot: lotList[index_num], year: String(yearList[index_num]), month: String(monthList[index_num]), day: String(dayList[index_num]), hour: String(hourList[index_num]), minute: String(minuteList[index_num]), category: categoryList[index_num], sikensi: sikensiList[index_num], pen: penList[index_num]))
                index_num += 1
            }
        }
    }
    
    func DataAppendSave()
    {
        switch whichSubject {
        case "pH":
            ud.set(ataiList, forKey: "pH")
            ud.set(addressList, forKey: "pH_add")
            ud.set(latList, forKey: "pH_lat")
            ud.set(lotList, forKey: "pH_lot")
            ud.set(yearList, forKey: "pH_year")
            ud.set(monthList, forKey: "pH_month")
            ud.set(dayList, forKey: "pH_day")
            ud.set(hourList, forKey: "pH_hour")
            ud.set(minuteList, forKey: "pH_minute")
            ud.set(categoryList, forKey: "pH_cate")
            ud.set(sikensiList, forKey: "pH_sike")
            ud.set(penList, forKey: "pH_pen")
        case "COD":
            ud.set(ataiList, forKey: "COD")
            ud.set(addressList, forKey: "COD_add")
            ud.set(latList, forKey: "COD_lat")
            ud.set(lotList, forKey: "COD_lot")
            ud.set(yearList, forKey: "COD_year")
            ud.set(monthList, forKey: "COD_month")
            ud.set(dayList, forKey: "COD_day")
            ud.set(hourList, forKey: "COD_hour")
            ud.set(minuteList, forKey: "COD_minute")
            ud.set(categoryList, forKey: "COD_cate")
            ud.set(sikensiList, forKey: "COD_sike")
            ud.set(penList, forKey: "COD_pen")
        case "Cl":
            ud.set(ataiList, forKey: "Cl")
            ud.set(addressList, forKey: "Cl_add")
            ud.set(latList, forKey: "Cl_lat")
            ud.set(lotList, forKey: "Cl_lot")
            ud.set(yearList, forKey: "Cl_year")
            ud.set(monthList, forKey: "Cl_month")
            ud.set(dayList, forKey: "Cl_day")
            ud.set(hourList, forKey: "Cl_hour")
            ud.set(minuteList, forKey: "Cl_minute")
            ud.set(categoryList, forKey: "Cl_cate")
            ud.set(sikensiList, forKey: "Cl_sike")
            ud.set(penList, forKey: "Cl_pen")
        case "亜鉛":
            ud.set(ataiList, forKey: "亜鉛")
            ud.set(addressList, forKey: "亜鉛_add")
            ud.set(latList, forKey: "亜鉛_lat")
            ud.set(lotList, forKey: "亜鉛_lot")
            ud.set(yearList, forKey: "亜鉛_year")
            ud.set(monthList, forKey: "亜鉛_month")
            ud.set(dayList, forKey: "亜鉛_day")
            ud.set(hourList, forKey: "亜鉛_hour")
            ud.set(minuteList, forKey: "亜鉛_minute")
            ud.set(categoryList, forKey: "亜鉛_cate")
            ud.set(sikensiList, forKey: "亜鉛_sike")
            ud.set(penList, forKey: "亜鉛_pen")
        default:
            print("")
        }
    }
}
