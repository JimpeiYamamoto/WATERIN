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
    //(x1, y1)~(x2, y2)の中のRGBそれぞれの平均を配列に入れて返す
    func getRGB(image:UIImage, y1:Int, y2:Int, x1:Int, x2:Int) -> [Double]
    {
        let cgImage = image.cgImage!
        let data: UnsafePointer = CFDataGetBytePtr(cgImage.dataProvider!.data)
        let bytesPerPixel = (cgImage.bitsPerPixel) / 8
        let bytesPerRow = (cgImage.bytesPerRow)
        var sum = 0.0
        var yfirst = y1
        var tortal_r = 0.0
        var tortal_g = 0.0
        var tortal_b = 0.0
        while (yfirst < y2)
        {
            var xfirst = x1
            while (xfirst < x2)
            {
                let tapPoint = CGPoint(x: xfirst, y: yfirst)
                let pixelAd: Int = Int(tapPoint.y) * bytesPerRow + Int(tapPoint.x) * bytesPerPixel
                tortal_r += Double(CGFloat(data[pixelAd+2]))
                tortal_g += Double(CGFloat(data[pixelAd+1]))
                tortal_b += Double(CGFloat(data[pixelAd]))
                xfirst += 1
                sum += 1
            }
            yfirst += 1
        }
        var rgbArray = [Double]()
        rgbArray.append(Double(tortal_r / sum))
        rgbArray.append(Double(tortal_g / sum))
        rgbArray.append(Double(tortal_b / sum))
        return (rgbArray)
    }
    //リサイズ前の画像を入れる
    func getpH(image:UIImage, y1:Int, y2:Int, x1:Int, x2:Int)->Double{
        let rgbArray = getRGB(image: image, y1: y1, y2: y2, x1: x1, x2: x2)
        let model = model_free()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        let small_r = rgbArray[0]/255.0
        let small_g = rgbArray[1]/255.0
        let small_b = rgbArray[2]/255.0
        multiArray[0] = NSNumber(value: small_r)
        multiArray[1] = NSNumber(value: small_g)
        multiArray[2] = NSNumber(value: small_b)
        print("代入したやつr:\(NSNumber(value: small_r))")
        let prediction = try! model.prediction(input1: multiArray)
        print(prediction.output1[0])
        let pH_pre = prediction.output1[0]
        return Double(truncating: pH_pre)
    }

    func getpH2(image:UIImage, y1:Int, y2:Int, x1:Int, x2:Int)->Double
    {
        let rgbArray = getRGB(image: image, y1: y1, y2: y2, x1: x1, x2: x2)
        let model = orange_blue_green()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        let small_r = rgbArray[0]/255.0
        let small_g = rgbArray[1]/255.0
        let small_b = rgbArray[2]/255.0

        multiArray[0] = NSNumber(value: small_r)
        multiArray[1] = NSNumber(value: small_g)
        multiArray[2] = NSNumber(value: small_b)
        print("代入したやつr:\(NSNumber(value: small_r))")
        let prediction = try! model.prediction(input1: multiArray)
        print(prediction.output1[0])
        let pH_pre = prediction.output1[0]
        return Double(truncating: pH_pre)
    }
    
    func getpH3(image:UIImage, y1:Int, y2:Int, x1:Int, x2:Int)->Double
    {
        let rgbArray = getRGB(image: image, y1: y1, y2: y2, x1: x1, x2: x2)
        let model = pink_blue_green()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        let small_r = rgbArray[0]/255.0
        let small_g = rgbArray[1]/255.0
        let small_b = rgbArray[2]/255.0

        multiArray[0] = NSNumber(value: small_r)
        multiArray[1] = NSNumber(value: small_g)
        multiArray[2] = NSNumber(value: small_b)
        print("代入したやつr:\(NSNumber(value: small_r))")
        let prediction = try! model.prediction(input1: multiArray)
        print(prediction.output1[0])
        let pH_pre = prediction.output1[0]
        return Double(truncating: pH_pre)
    }
    func calcu_pH_pink(rgb_array : [Double]) -> Double
    {
        let model = pink_blue_green()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        multiArray[0] = NSNumber(value: rgb_array[0])
        multiArray[1] = NSNumber(value: rgb_array[1])
        multiArray[2] = NSNumber(value: rgb_array[2])
        print("[0]=\(multiArray[0])")
        print("[1]=\(multiArray[1])")
        print("[2]=\(multiArray[2])")
        let prediction = try! model.prediction(input1: multiArray)
        return (Double(truncating: prediction.output1[0]))
    }
    
    func calcu_pH_orange(rgb_array : [Double]) -> Double
    {
        let model = orange_blue_green()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        multiArray[0] = NSNumber(value: rgb_array[0])
        multiArray[1] = NSNumber(value: rgb_array[1])
        multiArray[2] = NSNumber(value: rgb_array[2])
        print("[0]=\(multiArray[0])")
        print("[1]=\(multiArray[1])")
        print("[2]=\(multiArray[2])")
        let prediction = try! model.prediction(input1: multiArray)
        return Double((prediction.output1[0]))
    }
    
    func calcu_pH_normal(rgb_array : [Double]) -> Double
    {
        let model = model_free()
        let multiArray = try! MLMultiArray(shape: [3], dataType: .double)
        multiArray[0] = NSNumber(value: rgb_array[0])
        multiArray[1] = NSNumber(value: rgb_array[1])
        multiArray[2] = NSNumber(value: rgb_array[2])
        print("[0]=\(multiArray[0])")
        print("[1]=\(multiArray[1])")
        print("[2]=\(multiArray[2])")
        let prediction = try! model.prediction(input1: multiArray)
        return Double((prediction.output1[0]))
    }
    
    func adjust_rgb_pink(paper_rgb : [Double], green_rgb : [Double],blue_rgb : [Double], other_rgb : [Double]) -> [Double]
    {
        var adjudt_rgb_list = [Double]()
        let ave_r = ((225.580235 - other_rgb[0]) + (100.0468015 - blue_rgb[0]) + (163.4662815 - green_rgb[0]) / 3)
        let ave_g = ((117.353382 - other_rgb[1]) + (163.178715 - blue_rgb[1]) + (197.7156478 - green_rgb[1]) / 3)
        let ave_b = ((166.913904 - other_rgb[2]) + (167.1659716 - blue_rgb[2]) + (130.3609664 - green_rgb[2]) / 3)
        
        adjudt_rgb_list.append((paper_rgb[0] - ave_r)/255.0)
        adjudt_rgb_list.append((paper_rgb[1] - ave_g)/255.0)
        adjudt_rgb_list.append((paper_rgb[2] - ave_b)/255.0)
        return (adjudt_rgb_list)
    }
    
    func adjust_rgb_orange(paper_rgb : [Double], green_rgb : [Double],blue_rgb : [Double], other_rgb : [Double]) -> [Double]
    {
        var adjudt_rgb_list = [Double]()
        let ave_r = ((229.892073 - other_rgb[0]) + (100.0468015 - blue_rgb[0]) + (163.4662815 - green_rgb[0]) / 3)
        let ave_g = ((175.01066 - other_rgb[1]) + (163.178715 - blue_rgb[1]) + (197.7156478 - green_rgb[1]) / 3)
        let ave_b = ((123.36 - other_rgb[2]) + (167.1659716 - blue_rgb[2]) + (130.3609664 - green_rgb[2]) / 3)
        
        adjudt_rgb_list.append((paper_rgb[0] - ave_r)/255.0)
        adjudt_rgb_list.append((paper_rgb[1] - ave_g)/255.0)
        adjudt_rgb_list.append((paper_rgb[2] - ave_b)/255.0)
        return (adjudt_rgb_list)
    }

}
