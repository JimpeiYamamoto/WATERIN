//
//  Contents.swift
//  WaterChecker1
//
//  Created by 水代謝システム工学研究室 on 2020/07/11.
//  Copyright © 2020 水代謝システム工学研究室. All rights reserved.
//

import Foundation

class Contents
{
    var atai:Double?
    var address:String?
    var lat:String?
    var lot:String?
    var time:String?
    var year:String?
    var month :String?
    var day:String?
    var hour:String?
    var minute:String?
    var second:String?
    var sikensi:String?
    var category :String?
    
    init(atai:Double, address:String, lat:String, lot:String,
         time:String, year:String, month:String, day:String, hour:String, minute:String, second:String,
         category:String, sikensi:String){
        
        self.atai = atai
        self.address = address
        self.lat = lat
        self.lot = lot
        self.time = time
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        self.second = second
        self.sikensi = sikensi
        self.category = category
    }
}

class operate_contents
{
    func get_time_string(year:String, month:String, day:String, hour:String, minute:String, second:String) -> String
    {
        var time_str = String()
        
        time_str += year
        time_str += month
        time_str += day
        time_str += hour
        time_str += minute
        time_str += second
        return (time_str)
    }
    
    func filter_content_by_time(contents:[Contents],
                                start:String, stop:String) -> [Contents]
    {
        let start_int = Int(start)
        let stop_int = Int(stop)
        var filtered_contents = [Contents]()
        for content in contents {
            let time = String(content.time!.prefix(8))
            if (Int(time)! >= start_int!) && (Int(time)! <= stop_int!){
                filtered_contents.append(content)
            }
        }
        return (filtered_contents)
    }
}

extension Contents: Equatable {
    public static func ==(con1:Contents, con2:Contents) -> Bool {
        return con1.year==con2.year && con1.month==con2.month && con1.day==con2.day && con1.hour==con2.hour && con1.minute==con2.minute && con1.address==con2.address
    }
}
