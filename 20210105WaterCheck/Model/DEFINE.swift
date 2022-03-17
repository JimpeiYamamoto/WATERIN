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
    static let UD_YEAR = "_year"
    static let UD_MONTH = "_month"
    static let UD_DAY = "_day"
    static let UD_HOUR = "_hour"
    static let UD_MINUTE = "_minute"
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
    
    /** Paper0_true_RGB */
    static let PAPER0_R_Y_LST =
    [
        148.520324, 150.0019944, 152.1737909, 166.5521017,
        188.903548, 221.3796511, 221.6032345, 220.1731617,
        220.126356999999, 220.6013412, 220.7632151, 220.7632151,
        219.727043099999, 220.956717, 220.728374, 221.1777564
    ]
    static let PAPER0_G_Y_LST =
    [
        14.8871763, 15.54943091, 19.95157155, 36.32358337,
        70.77118707, 142.7919436, 143.3271893, 144.4331979,
        141.1331933, 139.9217516, 140.3864801, 140.3864801,
        140.0814176, 140.1893437, 141.5335559, 140.3581179
    ]
    static let PAPER0_B_Y_LST =
    [
        63.6777491, 59.79958832, 43.69940316, 35.11082459,
        27.43141191, 11.93315965, 17.04302141, 20.59144503,
        16.50439187, 13.34545357,12.19042133, 12.19042133,
        10.43812335, 11.282293, 7.287414502, 8.94861133299999
    ]
    /** Paper1_true_RGB */
    static let PAPER1_R_Y_LST =
    [
        212.496893599999, 212.4575198, 211.8433792, 211.9885541,
        212.2978059, 190.443192099999, 141.660273, 111.444333199999,
        88.28276195, 75.28203561, 73.17397365, 73.17397365,
        73.12179428, 72.56678616, 68.800247, 72.68736263
    ]
    static let PAPER1_G_Y_LST =
    [
        142.4350398, 142.4459503, 141.3983825, 141.6503349,
        141.9612086, 135.6122949, 126.111518099999, 118.750290299999,
        106.377317999999, 98.35284013, 96.40146026, 96.40146026,
        96.43159408, 72.56678616, 94.64598114, 96.81130848
    ]
    static let PAPER1_B_Y_LST =
    [
        58.76096536, 59.21061895, 57.75151898, 57.32702388,
        58.2007876, 52.39496578, 70.67123769, 94.5583808,
        95.91273709, 113.574554, 111.0528855, 111.0528855,
        110.9148122, 110.9030152, 109.191787999999, 111.0907792
    ]
    /** Paper2_true_RGB */
    static let PAPER2_R_Y_LST =
    [
        219.9107024, 219.2091393, 218.1223294, 218.7711082,
        218.732633199999, 219.6254549, 220.8986739, 219.660064399999,
        216.1618359, 199.0828293, 166.762231599999, 166.762231599999,
        135.3226451, 125.015526499999, 124.448255599999, 126.499826
    ]
    static let PAPER2_G_Y_LST =
    [
        142.9759089, 142.8711642, 142.5990146, 144.9433857,
        147.1062479, 143.2237408, 142.6106995, 141.7562179,
        134.6949251, 106.801337, 70.36976574, 70.36976574,
        41.46644082, 34.8865939, 33.63856277, 36.26317491
    ]
    static let PAPER2_B_Y_LST =
    [
        11.79416557, 13.56283082, 14.95873628, 19.02069146,
        26.4660722, 13.49964413, 8.63374627, 8.555714808,
        24.19213618, 21.19327917, 43.38717295, 43.38717295,
        53.00861249,69.52408651, 69.67184453, 71.10375936
    ]
    
    /** Firebase_Database */
    static let DATABASE_C1 = "UserTakenImage"
    /** Firebase_Database_key */
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
    static let STORAGE_C1 = "UserTakenInfo"
    static let REF_1_IMAGE_NAME = "ref1.jpg"
    static let REF_2_IMAGE_NAME = "ref2.jpg"
    static let TARGET_IMAGE_NAME = "target.jpg"
    
    
    
}
