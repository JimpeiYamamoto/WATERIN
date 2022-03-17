//
//  Contents.swift
//  WaterChecker1
//
//  Created by 水代謝システム工学研究室 on 2020/07/11.
//  Copyright © 2020 水代謝システム工学研究室. All rights reserved.
//

import Foundation

class Contents{
    
    var atai:Double?
    var address:String?
    var lat:String?
    var lot:String?
    
    var year:String?
    var month :String?
    var day:String?
    var hour:String?
    var minute:String?
    
    var sikensi:String?
    var category :String?
    
    
    init(atai:Double, address:String, lat:String, lot:String, year:String, month:String, day:String, hour:String, minute:String, category:String, sikensi:String){
        self.atai = atai
        self.address = address
        self.lat = lat
        self.lot = lot
        
        self.year = year
        self.month = month
        self.day = day
        self.hour = hour
        self.minute = minute
        
        self.sikensi = sikensi
        self.category = category
    }
    
}

extension Contents: Equatable {
    public static func ==(con1:Contents, con2:Contents) -> Bool {
        return con1.year==con2.year && con1.month==con2.month && con1.day==con2.day && con1.hour==con2.hour && con1.minute==con2.minute && con1.address==con2.address
    }
}
