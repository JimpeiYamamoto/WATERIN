//
//  Calender.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/04/03.
//

import Foundation

class Calender_Info
{
    var fy = Int()
    var ly = Int()
    var fm = Int()
    var lm = Int()
    var fd = Int()
    var ld = Int()
    var f_str = String()
    var l_str = String()
    
    init(fy:Int, ly:Int, fm:Int, lm:Int, fd:Int, ld:Int)
    {
        self.fy = fy
        self.ly = ly
        self.fm = fm
        self.lm = lm
        self.fd = fd
        self.ld = ld
        f_str = String(format: "%04d", fy) +
                String(format: "%02d", fm) +
                String(format: "%02d", fd)
        l_str = String(format: "%04d", ly) +
                String(format: "%02d", lm) +
                String(format: "%02d", ld)
    }
    
    func init_max_day(year:Int) -> [Int:Int]
    {
        var month_max_day = [1:31, 2:28, 3:31, 4:30, 5:31, 6:30, 7:31, 8:31, 9:30, 10:31, 11:30, 12:31]
        if (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)
        {
            month_max_day[2] = 29
        }
        return (month_max_day)
    }
    
    func get_yobi(_ year: Int, _ month: Int, _ day: Int) -> Int
    {
        var year = year
        var month = month
        if month == 1 || month == 2 {
            year -= 1
            month += 12
        }
        return ((year + year/4 - year/100 + year/400 + (13 * month + 8)/5 + day) % 7)
    }
}

class Year_Calender
{
    func init_info(c_info:Calender_Info) -> Calender_Info
    {
        c_info.ly = c_info.fy
        c_info.lm = c_info.fm
        c_info.ld = c_info.fd
        c_info.fd = 1
        c_info.ld = 31
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func proceed_year(c_info:Calender_Info) -> Calender_Info
    {
        c_info.fy += 1
        c_info.ly += 1
        c_info.fm = 1
        c_info.lm = 12
        c_info.fd = 1
        c_info.ld = 31
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func back_year(c_info:Calender_Info) -> Calender_Info
    {
        c_info.fy -= 1
        c_info.ly -= 1
        c_info.fm = 1
        c_info.lm = 12
        c_info.fd = 1
        c_info.ld = 31
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
}

class Month_Calender
{
    func init_info(c_info:Calender_Info) -> Calender_Info
    {
        c_info.ly = c_info.fy
        c_info.lm = c_info.fm
        c_info.fd = 1
        c_info.ld = c_info.init_max_day(year: c_info.fy)[c_info.fm]!
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func proceed_month(c_info:Calender_Info) -> Calender_Info
    {
        if (c_info.fm == 12)
        {
            c_info.fy += 1
            c_info.ly += 1
            c_info.fm = 1
            c_info.lm = 1
        }
        else
        {
            c_info.fm += 1
            c_info.lm += 1
        }
        c_info.fd = 1
        c_info.ld = c_info.init_max_day(year: c_info.fy)[c_info.lm]!
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func back_week(c_info:Calender_Info) -> Calender_Info
    {
        if (c_info.fm == 1)
        {
            c_info.fy -= 1
            c_info.ly -= 1
            c_info.fm = 12
            c_info.lm = 12
        }
        else
        {
            c_info.fm -= 1
            c_info.lm -= 1
        }
        c_info.fd = 1
        c_info.ld = c_info.init_max_day(year: c_info.fy)[c_info.fm]!
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
}

class Week_Calender
{
    func init_info(c_info:Calender_Info) -> Calender_Info
    {
        let year = c_info.fy
        let month = c_info.fm
        let day = c_info.fd
        let yobi = c_info.get_yobi(year, month, day)
        let month_max_day = c_info.init_max_day(year: year)
        
        c_info.fy = year
        c_info.ly = year
        c_info.fm = month
        c_info.fd = day - yobi
        c_info.lm = month
        c_info.ld = day + 6 - yobi
        if (day - yobi < 1)
        {
            if (month == 1)
            {
                c_info.fy = year - 1
                c_info.ly = year - 1
                c_info.fm = 12
            }
            else
            {
                c_info.fm = month - 1
            }
            c_info.fd = month_max_day[c_info.fm]! - (yobi - day)
        }
        else if (day + 6 - yobi > month_max_day[month]!)
        {
            if (month == 12)
            {
                c_info.ly = year + 1
                c_info.lm = 1
            }
            else
            {
                c_info.lm = month + 1
            }
            c_info.ld = (6 - yobi) - (month_max_day[month]! - day)
        }
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func proceed_week(c_info:Calender_Info) -> Calender_Info
    {
        if (c_info.fm == 12 && c_info.lm == 1)
        {
            c_info.fy += 1
            c_info.ly = c_info.fy
            c_info.fm = 1
            c_info.fd = c_info.ld + 1
            c_info.lm = 1
            c_info.ld = c_info.fd + 6
        }
        else if (c_info.ld == c_info.init_max_day(year: c_info.ly)[c_info.lm]!)
        {
            if (c_info.lm == 12)
            {
                c_info.fy += 1
                c_info.ly = c_info.fy
                c_info.fm = 1
            }
            else
            {
                c_info.fm = c_info.lm + 1
            }
            c_info.fd = 1
            c_info.lm = c_info.fm
            c_info.ld = c_info.fd + 6
        }
        else if (c_info.ld + 7 > c_info.init_max_day(year: c_info.ly)[c_info.lm]!)
        {
            if (c_info.lm == 12)
            {
                c_info.ly = c_info.fy + 1
                c_info.fm = 1
                c_info.fd = 1
                c_info.lm = 1
                c_info.ld = c_info.fd + 6
            }
            else
            {
                c_info.fm = c_info.lm
                c_info.fd = c_info.ld + 1
                c_info.lm = c_info.fm + 1
                c_info.ld = 6 - (c_info.init_max_day(year: c_info.fy)[c_info.fm]! - c_info.fd)
            }
        }
        else
        {
            c_info.ly = c_info.fy
            c_info.fm = c_info.lm
            c_info.fd = c_info.ld + 1
            c_info.lm = c_info.fm
            c_info.ld = c_info.fd + 6
        }
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func back_week(c_info:Calender_Info) -> Calender_Info
    {
        if (c_info.fm == 12 && c_info.lm == 1)
        {
            c_info.ly = c_info.fy
            c_info.lm = 12
            c_info.ld = c_info.fd - 1
            c_info.fm = 12
            c_info.fd = c_info.ld - 6
        }
        else if (c_info.fd == 1)
        {
            if (c_info.fm == 1)
            {
                c_info.fy -= 1
                c_info.ly -= 1
                c_info.lm = 12
            }
            else
            {
                c_info.lm = c_info.fm - 1
            }
            c_info.ld = c_info.init_max_day(year: c_info.ly)[c_info.lm]!
            c_info.fm = c_info.lm
            c_info.fd = c_info.init_max_day(year: c_info.ly)[c_info.lm]! - 6
        }
        else if (c_info.fd < 8)
        {
            c_info.lm = c_info.fm
            c_info.ld = c_info.fd - 1
            if (c_info.fm == 1)
            {
                c_info.ly = c_info.fy
                c_info.fy -= 1
                c_info.fm = 12
            }
            else
            {
                c_info.fm = c_info.lm - 1
            }
            c_info.fd = c_info.init_max_day(year: c_info.fy)[c_info.fm]! - (6 - c_info.ld)
        }
        else
        {
            c_info.lm = c_info.fm
            c_info.ld = c_info.fd - 1
            c_info.fm = c_info.lm
            c_info.fd = c_info.ld - 6
        }
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }

}

class Day_Calender
{
    func init_info(c_info:Calender_Info) -> Calender_Info
    {
        c_info.ly = c_info.fy
        c_info.lm = c_info.fm
        c_info.ld = c_info.fd
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func proceed_day(c_info:Calender_Info) -> Calender_Info
    {
        let monthMaxDay = c_info.init_max_day(year: c_info.fy)
        
        if (c_info.fd == monthMaxDay[c_info.fm])
        {
            c_info.fd = 1
            c_info.ld = 1
            if (c_info.fm == 12)
            {
                c_info.fm = 1
                c_info.lm = 1
                c_info.fy = c_info.fy + 1
                c_info.ly = c_info.ly + 1
            }
            else
            {
                c_info.fm = c_info.fm + 1
                c_info.lm = c_info.lm + 1
            }
        }
        else
        {
            c_info.fd = c_info.fd + 1
            c_info.ld = c_info.ld + 1
        }
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
    
    func back_day(c_info:Calender_Info) -> Calender_Info
    {
        let monthMaxDay = c_info.init_max_day(year: c_info.fy)
        
        if (c_info.fd == 1)
        {
            if (c_info.fm == 1)
            {
                c_info.fm = 12
                c_info.lm = 12
                c_info.fy = c_info.fy - 1
                c_info.ly = c_info.ly - 1
            }
            else
            {
                c_info.fm = c_info.fm - 1
                c_info.lm = c_info.lm - 1
            }
            c_info.fd = monthMaxDay[c_info.fm]!
            c_info.ld = monthMaxDay[c_info.lm]!
        }
        else
        {
            c_info.fd = c_info.fd - 1
            c_info.ld = c_info.ld - 1
        }
        return (Calender_Info(fy: c_info.fy, ly: c_info.ly, fm: c_info.fm, lm: c_info.lm,
                              fd: c_info.fd, ld: c_info.ld))
    }
}

