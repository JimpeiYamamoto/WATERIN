//
//  define_constant.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/02/28.
//

import Foundation

class v
{
    /* measurement_item */
    static let PH = "pH"
    static let CL = "Cl"
    /* paper_name */
    static let MARCHERY = "MARCHERY-NAGEL"
    static let SERIM = "Serim MONITOR FOR CHLORINE"
    /* paper_package_image_path */
    static let MARCHERY_PACK_IMG_PATH = "marchery_nagel_pack_img"
    static let SERIM_PACK_IMG_PATH = "serim_pack_img"
    
    /* category */
    static let UNCATEGORIZE = "未分類"
    
    /* user_default_keys */
    //double
    static let UD_OUTCOME = ""
    //int
    static let UD_TIME = "_time"
    static let UD_YEAR = "_year"
    static let UD_MONTH = "_month"
    static let UD_DAY = "_day"
    static let UD_HOUR = "_hour"
    static let UD_MINUTE = "_minute"
    static let UD_SECOND = "_second"
    //string
    static let UD_ADDRESS = "_add"
    static let UD_LAT = "_lat"
    static let UD_LOT = "_lot"
    static let UD_CATEGORY = "_cate"
    static let UD_PAPER = "_sike"
    
    /** rgb */
    static let R = 0
    static let G = 1
    static let B = 2
    

    
    /** Firebase_Database */
    static let DATABASE_C1 = "UserTakenImage2"
    /** Firebase_Database_key */
    static let TIME = "time"
    static let YEAR = "year"
    static let MONTH = "month"
    static let DAY = "day"
    static let HOUR = "hour"
    static let MINUTE = "minute"
    static let SECOND = "second"
    
    static let ADDRESS = "address"
    static let LAT = "lat"
    static let LOT = "lot"
    
    static let PAPER = "paper"
    static let CATEGORY = "category"
    
    /** Firebase_Storage */
    static let STORAGE_C1 = "UserTakenInfo2"
    static let REF_1_IMAGE_NAME = "ref1.jpg"
    static let REF_2_IMAGE_NAME = "ref2.jpg"
    static let TARGET_IMAGE_NAME = "target.jpg"
    
    
    
}
