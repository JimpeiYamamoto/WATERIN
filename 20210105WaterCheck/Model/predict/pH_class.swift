//
//  pH.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/09/27.
//

import Foundation
import UIKit

class pH_class
{
    /** Paper0_true_RGB */
    let PAPER0_R_Y_LST =
    [
        148.520324, 150.0019944, 152.1737909, 166.5521017,
        188.903548, 221.3796511, 221.6032345, 220.1731617,
        220.126356999999, 220.6013412, 220.7632151, 220.7632151,
        219.727043099999, 220.956717, 220.728374, 221.1777564
    ]
    let PAPER0_G_Y_LST =
    [
        14.8871763, 15.54943091, 19.95157155, 36.32358337,
        70.77118707, 142.7919436, 143.3271893, 144.4331979,
        141.1331933, 139.9217516, 140.3864801, 140.3864801,
        140.0814176, 140.1893437, 141.5335559, 140.3581179
    ]
    let PAPER0_B_Y_LST =
    [
        63.6777491, 59.79958832, 43.69940316, 35.11082459,
        27.43141191, 11.93315965, 17.04302141, 20.59144503,
        16.50439187, 13.34545357,12.19042133, 12.19042133,
        10.43812335, 11.282293, 7.287414502, 8.94861133299999
    ]
    /** Paper1_true_RGB */
    let PAPER1_R_Y_LST =
    [
        212.496893599999, 212.4575198, 211.8433792, 211.9885541,
        212.2978059, 190.443192099999, 141.660273, 111.444333199999,
        88.28276195, 75.28203561, 73.17397365, 73.17397365,
        73.12179428, 72.56678616, 68.800247, 72.68736263
    ]
    let PAPER1_G_Y_LST =
    [
        142.4350398, 142.4459503, 141.3983825, 141.6503349,
        141.9612086, 135.6122949, 126.111518099999, 118.750290299999,
        106.377317999999, 98.35284013, 96.40146026, 96.40146026,
        96.43159408, 72.56678616, 94.64598114, 96.81130848
    ]
    let PAPER1_B_Y_LST =
    [
        58.76096536, 59.21061895, 57.75151898, 57.32702388,
        58.2007876, 52.39496578, 70.67123769, 94.5583808,
        95.91273709, 113.574554, 111.0528855, 111.0528855,
        110.9148122, 110.9030152, 109.191787999999, 111.0907792
    ]
    /** Paper2_true_RGB */
    let PAPER2_R_Y_LST =
    [
        219.9107024, 219.2091393, 218.1223294, 218.7711082,
        218.732633199999, 219.6254549, 220.8986739, 219.660064399999,
        216.1618359, 199.0828293, 166.762231599999, 166.762231599999,
        135.3226451, 125.015526499999, 124.448255599999, 126.499826
    ]
    let PAPER2_G_Y_LST =
    [
        142.9759089, 142.8711642, 142.5990146, 144.9433857,
        147.1062479, 143.2237408, 142.6106995, 141.7562179,
        134.6949251, 106.801337, 70.36976574, 70.36976574,
        41.46644082, 34.8865939, 33.63856277, 36.26317491
    ]
    let PAPER2_B_Y_LST =
    [
        11.79416557, 13.56283082, 14.95873628, 19.02069146,
        26.4660722, 13.49964413, 8.63374627, 8.555714808,
        24.19213618, 21.19327917, 43.38717295, 43.38717295,
        53.00861249,69.52408651, 69.67184453, 71.10375936
    ]
    
    func target_rgb_get(image : UIImage, full_v_width:Double, full_v_height:Double) -> [[Double]]
    {
        let resize_image = image.resize(width_size: full_v_width, height_size: full_v_height)
        let s_w = Double(full_v_width * 0.08985782)
        let s_h = s_w * 0.902912621
        let x = s_w * 4.621359223
        let y1 = s_w * 4.504854369
        let y2 = s_w * 5.854368932
        let y3 = s_w * 7.242718447
        
        var target_rgb = [[Double]](repeating: [Double](repeating: 0, count: 4), count:4)
        let rgb = RGB()
        target_rgb[0] = rgb.RGB_lst(image: resize_image!, x: x, y: y1, width: s_w, height: s_h)
        target_rgb[1] = rgb.RGB_lst(image: resize_image!, x: x, y: y2, width: s_w, height: s_h)
        target_rgb[2] = rgb.RGB_lst(image: resize_image!, x: x, y: y3, width: s_w, height: s_h)
        return (target_rgb)
    }
    
    func ref_rgb_get(image : UIImage, full_v_width:Double, full_v_height:Double) -> [[[Double]]]
    {
        let resize_image = image.resize(width_size: full_v_width,
                                        height_size: full_v_height)
        let s_w = Double(full_v_width * 0.072985782)
        let s_h = Double(s_w * 1.194805195)
        
        let x_0 = s_w * 4.155844156
        let x_1 = s_w * 5.649350649
        let x_2 = s_w * 7.142857143
        
        let y_7 = s_w * 5.454545455
        let y_6 = s_w * 7.038961039
        let y_5 = s_w * 8.61038961
        let y_4 = s_w * 10.1688311
        let y_3 = s_w * 11.71428571
        let y_2 = s_w * 13.27272727
        let y_1 = s_w * 14.81818182
        let y_0 = s_w * 16.36363636
        
        var ref_rgb = [[[Double]]](repeating : [[Double]](repeating: [Double](repeating: 0, count : 3), count : 8), count : 4)
        let rgb = RGB()
        ref_rgb[0][7] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_7, width: s_w, height: s_h)
        ref_rgb[0][6] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_6, width: s_w, height: s_h)
        ref_rgb[0][5] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_5, width: s_w, height: s_h)
        ref_rgb[0][4] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_4, width: s_w, height: s_h)
        ref_rgb[0][3] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_3, width: s_w, height: s_h)
        ref_rgb[0][2] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_2, width: s_w, height: s_h)
        ref_rgb[0][1] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_1, width: s_w, height: s_h)
        ref_rgb[0][0] = rgb.RGB_lst(image: resize_image!, x: x_0, y: y_0, width: s_w, height: s_h)
        
        ref_rgb[1][7] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_7, width: s_w, height: s_h)
        ref_rgb[1][6] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_6, width: s_w, height: s_h)
        ref_rgb[1][5] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_5, width: s_w, height: s_h)
        ref_rgb[1][4] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_4, width: s_w, height: s_h)
        ref_rgb[1][3] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_3, width: s_w, height: s_h)
        ref_rgb[1][2] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_2, width: s_w, height: s_h)
        ref_rgb[1][1] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_1, width: s_w, height: s_h)
        ref_rgb[1][0] = rgb.RGB_lst(image: resize_image!, x: x_1, y: y_0, width: s_w, height: s_h)
        
        ref_rgb[2][7] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_7, width: s_w, height: s_h)
        ref_rgb[2][6] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_6, width: s_w, height: s_h)
        ref_rgb[2][5] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_5, width: s_w, height: s_h)
        ref_rgb[2][4] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_4, width: s_w, height: s_h)
        ref_rgb[2][3] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_3, width: s_w, height: s_h)
        ref_rgb[2][2] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_2, width: s_w, height: s_h)
        ref_rgb[2][1] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_1, width: s_w, height: s_h)
        ref_rgb[2][0] = rgb.RGB_lst(image: resize_image!, x: x_2, y: y_0, width: s_w, height: s_h)
        return (ref_rgb)
    }
    
    func paper_adjust_rgb(ref_rgb_1:[[[Double]]], ref_rgb_2:[[[Double]]],
                          target_rgb:[[Double]], paper_num : Int) -> [Double]
    {
        let p_n = paper_num
        let r_x_lst =
        [
            ref_rgb_1[p_n][0][v.R], ref_rgb_1[p_n][1][v.R], ref_rgb_1[p_n][2][v.R], ref_rgb_1[p_n][3][v.R],
            ref_rgb_1[p_n][4][v.R], ref_rgb_1[p_n][5][v.R], ref_rgb_1[p_n][6][v.R], ref_rgb_1[p_n][7][v.R],
            ref_rgb_2[p_n][0][v.R], ref_rgb_2[p_n][1][v.R], ref_rgb_2[p_n][2][v.R], ref_rgb_2[p_n][3][v.R],
            ref_rgb_2[p_n][4][v.R], ref_rgb_2[p_n][5][v.R], ref_rgb_2[p_n][6][v.R], ref_rgb_2[p_n][7][v.R],
        ]
        let g_x_lst =
        [
            ref_rgb_1[p_n][0][v.G], ref_rgb_1[p_n][1][v.G], ref_rgb_1[p_n][2][v.G], ref_rgb_1[p_n][3][v.G],
            ref_rgb_1[p_n][4][v.G], ref_rgb_1[p_n][5][v.G], ref_rgb_1[p_n][6][v.G], ref_rgb_1[p_n][7][v.G],
            ref_rgb_2[p_n][0][v.G], ref_rgb_2[p_n][1][v.G], ref_rgb_2[p_n][2][v.G], ref_rgb_2[p_n][3][v.G],
            ref_rgb_2[p_n][4][v.G], ref_rgb_2[p_n][5][v.G], ref_rgb_2[p_n][6][v.G], ref_rgb_2[p_n][7][v.G],
        ]
        let b_x_lst =
        [
            ref_rgb_1[p_n][0][v.B], ref_rgb_1[p_n][1][v.B], ref_rgb_1[p_n][2][v.B], ref_rgb_1[p_n][3][v.B],
            ref_rgb_1[p_n][4][v.B], ref_rgb_1[p_n][5][v.B], ref_rgb_1[p_n][6][v.B], ref_rgb_1[p_n][7][v.B],
            ref_rgb_2[p_n][0][v.B], ref_rgb_2[p_n][1][v.B], ref_rgb_2[p_n][2][v.B], ref_rgb_2[p_n][3][v.B],
            ref_rgb_2[p_n][4][v.B], ref_rgb_2[p_n][5][v.B], ref_rgb_2[p_n][6][v.B], ref_rgb_2[p_n][7][v.B],
        ]
        var true_r_lst = [Double]()
        var true_g_lst = [Double]()
        var true_b_lst = [Double]()
        if (paper_num == 0)
        {
            true_r_lst = PAPER0_R_Y_LST
            true_g_lst = PAPER0_G_Y_LST
            true_b_lst = PAPER0_B_Y_LST
        }
        else if (paper_num == 1)
        {
            true_r_lst = PAPER1_R_Y_LST
            true_g_lst = PAPER1_G_Y_LST
            true_b_lst = PAPER1_B_Y_LST
        }
        else
        {
            //paper_num == 2
            true_r_lst = PAPER2_R_Y_LST
            true_g_lst = PAPER2_G_Y_LST
            true_b_lst = PAPER2_B_Y_LST
        }
        let reg = Regression()
        let r_after = reg.get_ans(x_lst: r_x_lst, y_lst: true_r_lst, value: target_rgb[p_n][v.R])
        let g_after = reg.get_ans(x_lst: g_x_lst, y_lst: true_g_lst, value: target_rgb[p_n][v.G])
        let b_after = reg.get_ans(x_lst: b_x_lst, y_lst: true_b_lst, value: target_rgb[p_n][v.B])
        return ([r_after, g_after, b_after])
    }
    
    func judge_mode(paper0_after_rgb:[Double], paper1_after_rgb:[Double], paper2_after_rgb:[Double]) -> Int
    {
        let r_g_0 = paper0_after_rgb[v.R] - paper0_after_rgb[v.G]
        let g_b_0 = paper0_after_rgb[v.G] - paper0_after_rgb[v.B]
        let r_b_0 = paper0_after_rgb[v.R] - paper0_after_rgb[v.B]
        let r_g_2 = paper2_after_rgb[v.R] - paper2_after_rgb[v.G]
        let r_b_2 = paper2_after_rgb[v.R] - paper2_after_rgb[v.B]
        let g_b_2 = paper2_after_rgb[v.G] - paper2_after_rgb[v.B]
        if (r_g_0 > 80 && r_b_0 > 87.45 && g_b_0 < 141.49 && g_b_0 > -46.65)
        {
            return (1)
        }
        else if (r_g_0 > 130 && r_b_0 < 140 && g_b_0 < -20)
        {
           return (2)
        }
        else if (r_g_2 > 100 && r_b_2 < 160 && g_b_2 < 70)
        {
            return (3)
        }
        else
        {
            return (4)
        }
    }
    
    func calculate_pH_by_mode(p0_after_rgb:[Double], p1_after_rgb:[Double],
                              p2_after_rgb:[Double], mode:Int) -> Double
    {
        switch mode {
        case 1:
            let pH_r_b = cal_pH_p0_R_B(p0_after_rgb: p0_after_rgb)
            let pH_g_b = cal_pH_p0_G_B(p0_after_rgb: p0_after_rgb)
            return ((pH_r_b + pH_g_b) / 2)
        case 2:
            let pH_r_g = cal_pH_p0_R_G(p0_after_rgb: p0_after_rgb)
            let pH_r_b = cal_pH_p0_R_B(p0_after_rgb: p0_after_rgb)
            let pH_g_b = cal_pH_p0_G_B(p0_after_rgb: p0_after_rgb)
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        case 3:
            let pH_r_g = cal_pH_p2_R_G(p2_after_rgb: p2_after_rgb)
            let pH_r_b = cal_pH_p2_R_B(p2_after_rgb: p2_after_rgb)
            let pH_g_b = cal_pH_p2_G_B(p2_after_rgb: p2_after_rgb)
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        case 4:
            let pH_r_g = cal_pH_p1_R_G(p1_after_rgb: p1_after_rgb)
            let pH_r_b = cal_pH_p1_R_B(p1_after_rgb: p1_after_rgb)
            let pH_g_b = cal_pH_p1_G_B(p1_after_rgb: p1_after_rgb)
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        default:
            print("mode_error")
            return (0.0)
        }
    }
    
    func pH_to_RGB_lst(pH:Double) -> [Double]
    {
        let pow_2 = pow(pH, 2)
        let pow_3 = pow_2 * pH
        let pow_4 = pow_3 * pH
        var rgb_lst = [Double]()
        var r = 0.384 * pow_4 - 10.405 * pow_3 + 94.606 * pow_2 - 345.79 * pH + 591.15
        r = min(max(r, 1), 254)
        var g = 0.2544 * pow_4 - 7.505 * pow_3 + 75.852 * pow_2 - 304.58 * pH + 481.23
        g = min(max(g, 1), 254)
        var b = -0.0819 * pow_4 + 2.2833 * pow_3 - 21.677 * pow_2 + 82.922 * pH - 98.95
        b = min(max(b, 1), 254)
        rgb_lst.append(r/255.0)
        rgb_lst.append(g/255.0)
        rgb_lst.append(b/255.0)
        return (rgb_lst)
    }
    
    func cal_pH_p0_R_B(p0_after_rgb:[Double]) -> Double
    {
        let r_b = p0_after_rgb[v.R] - p0_after_rgb[v.B]
        
        let x4 = 5.906979 * 0.00000001 * pow(r_b, 4)
        let x3 = -3.687084 * 0.00001 * pow(r_b, 3)
        let x2 = 0.008306749 * pow(r_b, 2)
        let x1 = -0.7737231 * r_b
        let x0 = 26.81055
        return (x4 + x3 + x2 + x1 + x0)
    }
    
    func cal_pH_p0_G_B(p0_after_rgb:[Double]) -> Double
    {
        let g_b = p0_after_rgb[v.B] - p0_after_rgb[v.G]

        let x3 = 0.000002 * pow(g_b, 3)
        let x2 = -0.000280 * pow(g_b, 2)
        let x1 = 0.022289 * g_b
        let x0 = 3.121426
        return (x3 + x2 + x1 + x0)
    }
    
    func cal_pH_p0_R_G(p0_after_rgb:[Double]) -> Double
    {
        let r_g = p0_after_rgb[v.R] - p0_after_rgb[v.G]

        let x4 = -4 * 0.0000001 * pow(r_g, 4)
        let x3 = 0.0002 * pow(r_g, 3)
        let x2 = -0.0347 * pow(r_g, 2)
        let x1 = 2.5171 * r_g
        let x0 = -60.471
        return (x4 + x3 + x2 + x1 + x0)
    }

    func cal_pH_p2_R_G(p2_after_rgb:[Double]) -> Double
    {
        let r_g = p2_after_rgb[v.R] - p2_after_rgb[v.G]
        return (0.087267 * r_g + 2.452448)
    }
    
    func cal_pH_p2_R_B(p2_after_rgb:[Double]) -> Double
    {
        let r_g = p2_after_rgb[v.R] - p2_after_rgb[v.B]
        return (-0.018725 * r_g + 12.833116)
    }
    
    func cal_pH_p2_G_B(p2_after_rgb:[Double]) -> Double
    {
        let g_b = p2_after_rgb[v.G] - p2_after_rgb[v.B]
        return (-0.015696 * g_b + 11.013066)
    }
    
    func cal_pH_p1_R_G(p1_after_rgb:[Double]) -> Double
    {
        let r_g = p1_after_rgb[v.R] - p1_after_rgb[v.G]

        let x3 = -0.000011 * pow(r_g, 3)
        let x2 = 0.000561 * pow(r_g, 2)
        let x1 = 0.032106 * r_g
        let x0 = 6.466415
        return (x3 + x2 + x1 + x0)
    }
    
    func cal_pH_p1_R_B(p1_after_rgb:[Double]) -> Double
    {
        let r_b = p1_after_rgb[v.R] - p1_after_rgb[v.B]

        let x3 = -7.023018 * 0.0000001 * pow(r_b, 3)
        let x2 = 0.0002278498 * pow(r_b, 2)
        let x1 = -0.04024807 * r_b
        let x0 = 8.451023
        return (x3 + x2 + x1 + x0)
    }
    
    func cal_pH_p1_G_B(p1_after_rgb:[Double]) -> Double
    {
        let g_b = p1_after_rgb[v.G] - p1_after_rgb[v.B]
        return (-0.04862 * g_b + 9.972723)
    }
    
    func evaluate_pH(outcome : Double) -> String
    {
        if (outcome < 5.8)
        {
            return ("強酸")
        }
        if (outcome > 8.6)
        {
            return ("強アルカリ")
        }
        if (outcome < 6.8)
        {
            return ("弱酸")
        }
        if (outcome > 7.2)
        {
            return ("弱アルカリ")
        }
        return ("中性")
    }
}
