//
//  RGB.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/06.
//


import Foundation
import UIKit
import CoreML

class RGB{
    
    func RGB_lst(image:UIImage, x: Double, y:Double, width: Double, height:Double) -> [Double]
    {
        let cgImage = image.cgImage!
        let data: UnsafePointer = CFDataGetBytePtr(cgImage.dataProvider!.data)
        let bytesPerPixel = (cgImage.bitsPerPixel) / 8
        let bytesPerRow = (cgImage.bytesPerRow)
        var cnt = 0
        var r_total = 0.0
        var g_total = 0.0
        var b_total = 0.0
        var i = x
        while (i < width + x)
        {
            var j = y
            while (j < height + y)
            {
                let tapPoint = CGPoint(x: i, y: j)
                let pixelAd: Int = Int(tapPoint.y) * bytesPerRow + Int(tapPoint.x) * bytesPerPixel
                r_total += Double(CGFloat(data[pixelAd + 2]))
                g_total += Double(CGFloat(data[pixelAd + 1]))
                b_total += Double(CGFloat(data[pixelAd + 0]))
                cnt += 1
                j += 1
            }
            i += 1
        }
        var rgb_lst = [Double]()
        rgb_lst.append(r_total / Double(cnt))
        rgb_lst.append(g_total / Double(cnt))
        rgb_lst.append(b_total / Double(cnt))
        return (rgb_lst)
    }
}
