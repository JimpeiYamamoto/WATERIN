//
//  pH.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/09/27.
//

import Foundation

class pH_class
{
    var reg = Regression()
    var t_info = take_info()
    
    func judge_mode(paper1_after_rgb:[Double], paper2_after_rgb:[Double], paper3_after_rgb:[Double]) -> Int
    {
        let r_g_1 = paper1_after_rgb[0] - paper1_after_rgb[1]
        let g_b_1 = paper1_after_rgb[1] - paper1_after_rgb[2]
        let r_b_1 = paper1_after_rgb[0] - paper1_after_rgb[2]
        let r_g_3 = paper3_after_rgb[0] - paper3_after_rgb[1]
        let r_b_3 = paper3_after_rgb[0] - paper3_after_rgb[2]
        let g_b_3 = paper3_after_rgb[1] - paper3_after_rgb[2]
        if (r_g_1 > 80 && r_b_1 > 87.45 && g_b_1 < 141.49 && g_b_1 > -46.65)
        {
            return (1)
        }
        else if (r_g_1 > 130 && r_b_1 < 140 && g_b_1 < -20)
        {
           return (2)
        }
        else if (r_g_3 > 100 && r_b_3 < 160 && g_b_3 < 70)
        {
            return (3)
        }
        else
        {
            return (4)
        }
    }
    
    func calculate_pH_by_mode(paper1_after_rgb:[Double], paper2_after_rgb:[Double], paper3_after_rgb:[Double]) -> Double
    {
        let mode = judge_mode(paper1_after_rgb: paper1_after_rgb, paper2_after_rgb: paper2_after_rgb, paper3_after_rgb: paper3_after_rgb)
        print("mode=", mode)
        let r_g_1 = paper1_after_rgb[0] - paper1_after_rgb[1]
        let g_b_1 = paper1_after_rgb[1] - paper1_after_rgb[2]
        let r_b_1 = paper1_after_rgb[0] - paper1_after_rgb[2]
        let r_g_3 = paper3_after_rgb[0] - paper3_after_rgb[1]
        let r_b_3 = paper3_after_rgb[0] - paper3_after_rgb[2]
        let g_b_3 = paper3_after_rgb[1] - paper3_after_rgb[2]
        let r_g_2 = paper2_after_rgb[0] - paper2_after_rgb[1]
        let r_b_2 = paper2_after_rgb[0] - paper2_after_rgb[2]
        let g_b_2 = paper2_after_rgb[1] - paper2_after_rgb[2]
        switch mode {
        case 1:
            
            let pH_r_b = 5.906979 * 0.00000001 * pow(r_b_1, 4) - 3.687084 * 0.00001 * pow(r_b_1, 3) + 0.008306749 * pow(r_b_1, 2) - 0.7737231 * r_b_1 + 26.81055
            let pH_g_b = 0.000002 * pow(g_b_1, 3) - 0.000280 * pow(g_b_1, 2) + 0.022289 * g_b_1 + 3.121426
            return ((pH_r_b + pH_g_b) / 2)
        case 2:
            let pH_r_g = -4 * 0.0000001 * pow(r_g_1, 4) + 0.0002 * pow(r_g_1, 3) - 0.0347 * pow(r_g_1, 2) + 2.5171 * r_g_1 - 60.471
            let pH_r_b = 5.906979 * 0.00000001 * pow(r_b_1, 4) - 3.687084 * 0.00001 * pow(r_b_1, 3) + 0.008306749 * pow(r_b_1, 2) - 0.7737231 * r_b_1 + 26.81055
            let pH_g_b = 0.000002 * pow(g_b_1, 3) - 0.000280 * pow(g_b_1, 2) + 0.022289 * g_b_1 + 3.121426
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        case 3:
            let pH_r_g = 0.087267 * r_g_3 + 2.452448
            let pH_r_b = -0.018725 * r_b_3 + 12.833116
            let pH_g_b = -0.015696 * g_b_3 + 11.013066
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        default:
            let pH_r_g = -0.000011 * pow(r_g_2, 3) + 0.000561 * pow(r_g_2, 2) - 0.032106 * r_g_2 + 6.466415
            let pH_r_b = -7.023018 * 0.0000001 * pow(r_b_2, 3) + 0.0002278498 * pow(r_b_2, 2) - 0.04024807 * r_b_2 + 8.451023
            let pH_g_b = -0.04862 * g_b_2 + 9.972723
            return ((pH_r_g + pH_r_b + pH_g_b) / 3)
        }
    }
    
    func paper1_adjust_rgb(ref_rgb_1:[String:[Double]], ref_rgb_2:[String:[Double]]) -> [Double]
    {
        let r_y1_lst = [148.520324, 150.0019944, 152.1737909, 166.5521017, 188.903548, 221.3796511, 221.6032345, 220.1731617, 220.126356999999, 220.6013412, 220.7632151, 220.7632151, 219.727043099999, 220.956717, 220.728374, 221.1777564]
        let g_y1_lst = [14.8871763, 15.54943091, 19.95157155, 36.32358337, 70.77118707, 142.7919436, 143.3271893, 144.4331979, 141.1331933, 139.9217516, 140.3864801, 140.3864801, 140.0814176, 140.1893437, 141.5335559, 140.3581179]
        let b_y1_lst = [63.6777491, 59.79958832, 43.69940316, 35.11082459, 27.43141191, 11.93315965, 17.04302141, 20.59144503, 16.50439187, 13.34545357, 12.19042133, 12.19042133, 10.43812335, 11.282293, 7.287414502, 8.94861133299999]
        let r_x1_lst = [ref_rgb_1["y1_0"]![0], ref_rgb_1["y1_1"]![0], ref_rgb_1["y1_2"]![0], ref_rgb_1["y1_3"]![0], ref_rgb_1["y1_4"]![0],
                       ref_rgb_1["y1_5"]![0], ref_rgb_1["y1_6"]![0], ref_rgb_1["y1_7"]![0], ref_rgb_2["y1_8"]![0], ref_rgb_2["y1_9"]![0], ref_rgb_2["y1_10"]![0],
                       ref_rgb_2["y1_11"]![0], ref_rgb_2["y1_12"]![0], ref_rgb_2["y1_13"]![0], ref_rgb_2["y1_14"]![0]]
        let g_x1_lst = [ref_rgb_1["y1_0"]![1], ref_rgb_1["y1_1"]![1], ref_rgb_1["y1_2"]![1], ref_rgb_1["y1_3"]![1], ref_rgb_1["y1_4"]![1],
                       ref_rgb_1["y1_5"]![1], ref_rgb_1["y1_6"]![1], ref_rgb_1["y1_7"]![1], ref_rgb_2["y1_8"]![1], ref_rgb_2["y1_9"]![1], ref_rgb_2["y1_10"]![1],
                       ref_rgb_2["y1_11"]![1], ref_rgb_2["y1_12"]![1], ref_rgb_2["y1_13"]![1], ref_rgb_2["y1_14"]![1]]
        let b_x1_lst = [ref_rgb_1["y1_0"]![2], ref_rgb_1["y1_1"]![2], ref_rgb_1["y1_2"]![2], ref_rgb_1["y1_3"]![2], ref_rgb_1["y1_4"]![2],
                       ref_rgb_1["y1_5"]![2], ref_rgb_1["y1_6"]![2], ref_rgb_1["y1_7"]![2], ref_rgb_2["y1_8"]![2], ref_rgb_2["y1_9"]![2], ref_rgb_2["y1_10"]![2],
                       ref_rgb_2["y1_11"]![2], ref_rgb_2["y1_12"]![2], ref_rgb_2["y1_13"]![2], ref_rgb_2["y1_14"]![2]]
        let r_1_after = reg.get_ans(x_lst: r_x1_lst, y_lst: r_y1_lst, value: t_info.target!["paper1_rgb"]![0])
        let g_1_after = reg.get_ans(x_lst: g_x1_lst, y_lst: g_y1_lst, value: t_info.target!["paper1_rgb"]![1])
        let b_1_after = reg.get_ans(x_lst: b_x1_lst, y_lst: b_y1_lst, value: t_info.target!["paper1_rgb"]![2])
        return ([r_1_after, g_1_after, b_1_after])
    }
    
    func paper2_adjust_rgb(ref_rgb_1:[String:[Double]], ref_rgb_2:[String:[Double]]) -> [Double]
    {
        let r_y2_lst = [212.496893599999, 212.4575198, 211.8433792, 211.9885541, 212.2978059, 190.443192099999, 141.660273, 111.444333199999, 88.28276195, 75.28203561, 73.17397365, 73.12179428, 72.56678616, 68.800247, 72.68736263]
        let g_y2_lst = [142.4350398, 142.4459503, 141.3983825, 141.6503349, 141.9612086, 135.6122949, 126.111518099999, 118.750290299999, 106.377317999999, 98.35284013, 96.40146026, 96.43159408, 72.56678616, 94.64598114, 96.81130848]
        let b_y2_lst = [58.76096536, 59.21061895, 57.75151898, 57.32702388, 58.2007876, 52.39496578, 70.67123769, 94.5583808, 95.91273709, 113.574554, 111.0528855, 110.9148122, 110.9030152, 109.191787999999, 111.0907792]
        let r_x2_lst = [ref_rgb_1["y2_0"]![0], ref_rgb_1["y2_1"]![0], ref_rgb_1["y2_2"]![0], ref_rgb_1["y2_3"]![0], ref_rgb_1["y2_4"]![0],
                       ref_rgb_1["y2_5"]![0], ref_rgb_1["y2_6"]![0], ref_rgb_1["y2_7"]![0], ref_rgb_2["y2_8"]![0], ref_rgb_2["y2_9"]![0], ref_rgb_2["y2_10"]![0],
                       ref_rgb_2["y2_11"]![0], ref_rgb_2["y2_12"]![0], ref_rgb_2["y2_13"]![0], ref_rgb_2["y2_14"]![0]]
        let g_x2_lst = [ref_rgb_1["y2_0"]![1], ref_rgb_1["y2_1"]![1], ref_rgb_1["y2_2"]![1], ref_rgb_1["y2_3"]![1], ref_rgb_1["y2_4"]![1],
                       ref_rgb_1["y2_5"]![1], ref_rgb_1["y2_6"]![1], ref_rgb_1["y2_7"]![1], ref_rgb_2["y2_8"]![1], ref_rgb_2["y2_9"]![1], ref_rgb_2["y2_10"]![1],
                       ref_rgb_2["y2_11"]![1], ref_rgb_2["y2_12"]![1], ref_rgb_2["y2_13"]![1], ref_rgb_2["y2_14"]![1]]
        let b_x2_lst = [ref_rgb_1["y2_0"]![2], ref_rgb_1["y2_1"]![2], ref_rgb_1["y2_2"]![2], ref_rgb_1["y2_3"]![2], ref_rgb_1["y2_4"]![2],
                       ref_rgb_1["y2_5"]![2], ref_rgb_1["y2_6"]![2], ref_rgb_1["y2_7"]![2], ref_rgb_2["y2_8"]![2], ref_rgb_2["y2_9"]![2], ref_rgb_2["y2_10"]![2],
                       ref_rgb_2["y2_11"]![2], ref_rgb_2["y2_12"]![2], ref_rgb_2["y2_13"]![2], ref_rgb_2["y2_14"]![2]]
        let r_2_after = reg.get_ans(x_lst: r_x2_lst, y_lst: r_y2_lst, value: t_info.target!["paper2_rgb"]![0])
        let g_2_after = reg.get_ans(x_lst: g_x2_lst, y_lst: g_y2_lst, value: t_info.target!["paper2_rgb"]![1])
        let b_2_after = reg.get_ans(x_lst: b_x2_lst, y_lst: b_y2_lst, value: t_info.target!["paper2_rgb"]![2])
        return ([r_2_after, g_2_after, b_2_after])
    }
    
    func paper3_adjust_rgb(ref_rgb_1:[String:[Double]], ref_rgb_2:[String:[Double]]) -> [Double]
    {
        let r_y3_lst = [219.9107024, 219.2091393, 218.1223294, 218.7711082, 218.732633199999, 219.6254549, 220.8986739, 219.660064399999, 216.1618359, 199.0828293, 166.762231599999, 135.3226451, 125.015526499999, 124.448255599999, 126.499826]
        let g_y3_lst = [142.9759089, 142.8711642, 142.5990146, 144.9433857, 147.1062479, 143.2237408, 142.6106995, 141.7562179, 134.6949251, 106.801337, 70.36976574, 41.46644082, 34.8865939, 33.63856277, 36.26317491]
        let b_y3_lst = [11.79416557, 13.56283082, 14.95873628, 19.02069146, 26.4660722, 13.49964413, 8.63374627, 8.555714808, 24.19213618, 21.19327917, 43.38717295, 53.00861249, 69.52408651, 69.67184453, 71.10375936]
        let r_x3_lst = [ref_rgb_1["y3_0"]![0], ref_rgb_1["y3_1"]![0], ref_rgb_1["y3_2"]![0], ref_rgb_1["y3_3"]![0], ref_rgb_1["y3_4"]![0],
                       ref_rgb_1["y3_5"]![0], ref_rgb_1["y3_6"]![0], ref_rgb_1["y3_7"]![0], ref_rgb_2["y3_8"]![0], ref_rgb_2["y3_9"]![0], ref_rgb_2["y3_10"]![0],
                       ref_rgb_2["y3_11"]![0], ref_rgb_2["y3_12"]![0], ref_rgb_2["y3_13"]![0], ref_rgb_2["y3_14"]![0]]
        let g_x3_lst = [ref_rgb_1["y3_0"]![1], ref_rgb_1["y3_1"]![1], ref_rgb_1["y3_2"]![1], ref_rgb_1["y3_3"]![1], ref_rgb_1["y3_4"]![1],
                       ref_rgb_1["y3_5"]![1], ref_rgb_1["y3_6"]![1], ref_rgb_1["y3_7"]![1], ref_rgb_2["y3_8"]![1], ref_rgb_2["y3_9"]![1], ref_rgb_2["y3_10"]![1],
                       ref_rgb_2["y3_11"]![1], ref_rgb_2["y3_12"]![1], ref_rgb_2["y3_13"]![1], ref_rgb_2["y3_14"]![1]]
        let b_x3_lst = [ref_rgb_1["y3_0"]![2], ref_rgb_1["y3_1"]![2], ref_rgb_1["y3_2"]![2], ref_rgb_1["y3_3"]![2], ref_rgb_1["y3_4"]![2],
                       ref_rgb_1["y3_5"]![2], ref_rgb_1["y3_6"]![2], ref_rgb_1["y3_7"]![2], ref_rgb_2["y3_8"]![2], ref_rgb_2["y3_9"]![2], ref_rgb_2["y3_10"]![2],
                       ref_rgb_2["y3_11"]![2], ref_rgb_2["y3_12"]![2], ref_rgb_2["y3_13"]![2], ref_rgb_2["y3_14"]![2]]
        let r_3_after = reg.get_ans(x_lst: r_x3_lst, y_lst: r_y3_lst, value: t_info.target!["paper3_rgb"]![0])
        let g_3_after = reg.get_ans(x_lst: g_x3_lst, y_lst: g_y3_lst, value: t_info.target!["paper3_rgb"]![1])
        let b_3_after = reg.get_ans(x_lst: b_x3_lst, y_lst: b_y3_lst, value: t_info.target!["paper3_rgb"]![2])
        return ([r_3_after, g_3_after, b_3_after])
    }
}
