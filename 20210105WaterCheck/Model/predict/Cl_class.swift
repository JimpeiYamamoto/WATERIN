//
//  Cl_class.swift
//  20210105WaterCheck
//
//  Created by Takaaki Ishii on 2021/10/19.
//

import Foundation


class Cl_class
{
    var reg = Regression()
    var t_info = take_info()
    
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
        print("mode=", mode)
        let r_g = paper_after_rgb[0] - paper_after_rgb[1]
        let g_b = paper_after_rgb[1] - paper_after_rgb[2]
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
    
    func paper_adjust_rgb(ref_rgb_1:[String:[Double]]) -> [Double]
    {
        let r_y_lst = [212.68, 161.78, 142.79, 122.44, 96.66, 67.56]
        let g_y_lst = [213.03, 125.47, 84.72, 61.48, 31.12, 11.33]
        let b_y_lst = [204.93, 151.57, 137.34, 128.24, 108.12, 77.02]
        let r_x_lst = [ref_rgb_1["y0"]![0], ref_rgb_1["y1"]![0], ref_rgb_1["y2"]![0], ref_rgb_1["y3"]![0], ref_rgb_1["y4"]![0],
                       ref_rgb_1["y5"]![0]]
        let g_x_lst = [ref_rgb_1["y0"]![1], ref_rgb_1["y1"]![1], ref_rgb_1["y2"]![1], ref_rgb_1["y3"]![1], ref_rgb_1["y4"]![1],
                       ref_rgb_1["y5"]![1]]
        let b_x_lst = [ref_rgb_1["y0"]![2], ref_rgb_1["y1"]![2], ref_rgb_1["y2"]![2], ref_rgb_1["y3"]![2], ref_rgb_1["y4"]![2],
                       ref_rgb_1["y5"]![2]]
        let r_after = reg.get_ans(x_lst: r_x_lst, y_lst: r_y_lst, value: t_info.target_rgb![0][0])
        let g_after = reg.get_ans(x_lst: g_x_lst, y_lst: g_y_lst, value: t_info.target_rgb![1][0])
        let b_after = reg.get_ans(x_lst: b_x_lst, y_lst: b_y_lst, value: t_info.target_rgb![2][0])
        return ([r_after, g_after, b_after])
    }
}
