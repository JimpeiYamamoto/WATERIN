//
//  getTime.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/10.
//
import UIKit

class TimeClass{
    
    var year = String()
    var month = String()
    var day = String()
    var hour = String()
    var minute = String()
    var second = String()
    
    func get_now_time()
    {
        let now = NSDate()
        
        let year_format = DateFormatter()
        year_format.dateFormat = "yyyy"
        year = year_format.string(from:now as Date)
        let month_format = DateFormatter()
        month_format.dateFormat = "MM"
        month = month_format.string(from: now as Date)
        let day_format = DateFormatter()
        day_format.dateFormat = "dd"
        day = day_format.string(from: now as Date)
        let hour_format = DateFormatter()
        hour_format.dateFormat = "HH"
        hour = hour_format.string(from: now as Date)
        let minute_format = DateFormatter()
        minute_format.dateFormat = "mm"
        minute = minute_format.string(from: now as Date)
        let second_format = DateFormatter()
        second_format.dateFormat = "ss"
        second = second_format.string(from: now as Date)
    }
}
