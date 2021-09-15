//
//  Cl_Predict.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/07/10.
//

import Foundation

class Cl_Predict
{
    var regression = Regression()

    func adjust_rgb(rgb_0:[Double], rgb_0_5:[Double], rgb_1_0:[Double], rgb_2_0:[Double],
                    rgb_5_0:[Double], rgb_10_0:[Double], mesure_rgb:[Double]) -> [Double]
    {
        let real_r_lst = [212.68, 161.78, 142.79, 122.44, 96.66, 67.56]
        let real_g_lst = [213.03, 125.47, 84.72, 61.48, 31.12, 11.33]
        let real_b_lst = [204.93, 151.57, 137.34, 128.24, 108.12, 77.02]
        let mesure_r_lst = [rgb_0[0], rgb_0_5[0], rgb_1_0[0], rgb_2_0[0], rgb_5_0[0], rgb_10_0[0]]
        let mesure_g_lst = [rgb_0[1], rgb_0_5[1], rgb_1_0[1], rgb_2_0[1], rgb_5_0[1], rgb_10_0[1]]
        let mesure_b_lst = [rgb_0[2], rgb_0_5[2], rgb_1_0[2], rgb_2_0[2], rgb_5_0[2], rgb_10_0[2]]
    
        let adjusted_r = regression.get_ans(x_lst: mesure_r_lst, y_lst: real_r_lst, value: mesure_rgb[0])
        let adjusted_g = regression.get_ans(x_lst: mesure_g_lst, y_lst: real_g_lst, value: mesure_rgb[1])
        let adjusted_b = regression.get_ans(x_lst: mesure_b_lst, y_lst: real_b_lst, value: mesure_rgb[2])
        return ([adjusted_r, adjusted_g, adjusted_b])
    }
    
    func get_Cl(adjusted_rgb:[Double]) -> Double
    {
        let r_model = 1.0 * pow(10.0, -7.0) * pow(adjusted_rgb[0], 4.0) - 9.0 * pow(10.0, -5.0) * pow(adjusted_rgb[0], 3.0)
            + 0.0245 * pow(adjusted_rgb[0], 2.0) - 2.8686 * adjusted_rgb[0] + 127.01
        let g_model = 2.0 * pow(10.0, -8.0) * pow(adjusted_rgb[1], 4.0) + 1 * pow(10.0, -5.0) * pow(adjusted_rgb[1], 3.0)
            + 0.0032 * pow(adjusted_rgb[1], 2.0) - 0.3398 * adjusted_rgb[1] + 15.151
        let b_model = -2.0 * pow(10.0, -5.0) * pow(adjusted_rgb[2], 2.0) + 0.0121 * pow(adjusted_rgb[2], 2.0) - 2.0338 * adjusted_rgb[2]
            + 115.21
        return ((r_model + g_model + b_model) / 3)
    }
}
