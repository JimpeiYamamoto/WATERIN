//
//  take_info.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//


import Foundation
import UIKit

class take_info
{
    var subject:String?
    var paper:String?
    var paper_pack_image_path:String?
    var category:String?
    
    var outcome:Double?
    var calc_mode:Int?
    
    var target_rgb:[[Double]]?
    var addjust_target_rgb:[[Double]]?
    var target_image:UIImage?
    
    var ref1_image:UIImage?
    var ref1_rgb : [[[Double]]]?
    var ref2_image:UIImage?
    var ref2_rgb : [[[Double]]]?
}
