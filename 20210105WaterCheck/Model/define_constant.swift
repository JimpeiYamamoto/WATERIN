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
    static let UD_DOUBLE_LST = [UD_OUTCOME]
    //int
    static let UD_YEAR = "_year"
    static let UD_MONTH = "_month"
    static let UD_DAY = "_day"
    static let UD_HOUR = "_hour"
    static let UD_MINUTE = "_minute"
    static let UD_INT_LST = [UD_YEAR, UD_MONTH, UD_DAY, UD_HOUR, UD_MINUTE]
    //string
    static let UD_ADDRESS = "_add"
    static let UD_LAT = "_lat"
    static let UD_LOT = "_lot"
    static let UD_CATEGORY = "_cate"
    static let UD_PAPER = "_sike"
    static let UD_STRING_LST = [UD_ADDRESS, UD_LAT, UD_LOT, UD_CATEGORY, UD_PAPER, UD_PAPER]
}
