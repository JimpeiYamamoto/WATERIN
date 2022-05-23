//
//  Cl_class.swift
//  20210105WaterCheck
//
//  Created by Takaaki Ishii on 2021/10/19.
//

import Foundation
import UIKit


class Cl_class
{
    func judge_mode(paper_after_rgb:[Double]) -> Int
    {
        let r_g = paper_after_rgb[0] - paper_after_rgb[1]
        let g_b = paper_after_rgb[1] - paper_after_rgb[2]
        let r_b = paper_after_rgb[0] - paper_after_rgb[2]
        if (r_g > -20 && r_b < 50 && g_b < 50)
        {
            return (1)
        }
        else
        {
            return (4)
        }
    }
    
    func calculate_Cl_by_mode(paper_after_rgb:[Double]) -> Double
    {
        let mode = judge_mode(paper_after_rgb: paper_after_rgb)
        let r_g = paper_after_rgb[0] - paper_after_rgb[1]
        let r_b = paper_after_rgb[0] - paper_after_rgb[2]
        switch mode {
        case 1:
            let Cl_r_g = 0.0013 * pow(r_g, 2) + 0.0051 * r_g + 0.3713
            let Cl_r_b = 0.004 * pow(r_b, 2) - 0.1438 * r_b + 1.4519
            let Cl_g_b = 0.0009 * pow(r_b, 2) - 0.0137 * r_b + 0.4227
            return ((Cl_r_g + Cl_r_b + Cl_g_b) / 3)
        default:
            let Cl_r_g = 0.0013 * pow(r_g, 2) + 0.0051 * r_g + 0.3713
            let Cl_r_b = 0.004 * pow(r_b, 2) - 0.1438 * r_b + 1.4519
            let Cl_g_b = 0.0009 * pow(r_b, 2) - 0.0137 * r_b + 0.4227
            return ((Cl_r_g + Cl_r_b + Cl_g_b) / 3)
        }
    }
    
    func adjust_rgb(ref_rgb:[[Double]], target_rgb:[[Double]]) -> [[Double]]
    {
        let reg = Regression()
        var adjust_rgb = [[Double]](repeating: [Double](repeating: 0, count : 3), count : 1)
        
        let r_y_lst = [212.68, 161.78, 142.79, 122.44, 96.66, 67.56]
        let g_y_lst = [213.03, 125.47, 84.72, 61.48, 31.12, 11.33]
        let b_y_lst = [204.93, 151.57, 137.34, 128.24, 108.12, 77.02]
        
        let r_x_lst = [ref_rgb[0][v.R], ref_rgb[1][v.R], ref_rgb[2][v.R], ref_rgb[3][v.R], ref_rgb[4][v.R]]
        let g_x_lst = [ref_rgb[0][v.G], ref_rgb[1][v.G], ref_rgb[2][v.G], ref_rgb[3][v.G], ref_rgb[4][v.G]]
        let b_x_lst = [ref_rgb[0][v.B], ref_rgb[1][v.B], ref_rgb[2][v.B], ref_rgb[3][v.B], ref_rgb[4][v.B]]
        
        adjust_rgb[0][v.R] = reg.get_ans(x_lst: r_x_lst, y_lst: r_y_lst, value: target_rgb[0][v.R])
        adjust_rgb[0][v.G] = reg.get_ans(x_lst: g_x_lst, y_lst: g_y_lst, value: target_rgb[0][v.G])
        adjust_rgb[0][v.B] = reg.get_ans(x_lst: b_x_lst, y_lst: b_y_lst, value: target_rgb[0][v.B])
        return (adjust_rgb)
    }
    
    func target_rgb_get(image:UIImage, ful_vw:Double, ful_vh:Double) ->[[Double]]
    {
        let rgb = RGB()
        
        let x_ = ful_vw * 0.05308057
        let y_ = x_ * 8.82142857
        let width_ = x_ * 1
        let height_ = x_ * 1
        let resize_image = image.resize(width_size: ful_vw, height_size: ful_vh)
        var ref_rgb = [[Double]](repeating: [Double](repeating: 0, count : 3), count : 1)
        ref_rgb[0] = rgb.RGB_lst(image: resize_image!, x: x_, y: y_, width: width_, height: height_)
        return (ref_rgb)
    }
    
    func ref_rgb_get(image:UIImage, ful_vw:Double, ful_vh:Double) -> [[[Double]]]
    {
        let rgb = RGB()
        let resize_image = image.resize(width_size: ful_vw, height_size: ful_vh)
        let x_ = ful_vw * 0.39339623
        let vx = x_ * 1.15587529
        let vl_w = x_ * 0.21582734
        let vl_h = x_ * 0.20863309
        let y_0 = x_ * 3.10551559
        let y_1 = x_ * 2.8177458
        let y_2 = x_ * 2.52757794
        let y_3 = x_ * 2.23741007
        let y_4 = x_ * 1.96402878
        let y_5 = x_ * 1.70983213
        var ref_rgb = [[[Double]]](repeating : [[Double]](
                        repeating: [Double](repeating: 0, count : 3), count : 6), count : 1)
        ref_rgb[0][5] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_5, width: vl_w, height: vl_h)
        ref_rgb[0][4] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_4, width: vl_w, height: vl_h)
        ref_rgb[0][3] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_3, width: vl_w, height: vl_h)
        ref_rgb[0][2] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_2, width: vl_w, height: vl_h)
        ref_rgb[0][1] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_1, width: vl_w, height: vl_h)
        ref_rgb[0][0] = rgb.RGB_lst(image: resize_image!, x: vx, y: y_0, width: vl_w, height: vl_h)
        return (ref_rgb)
    }
}
