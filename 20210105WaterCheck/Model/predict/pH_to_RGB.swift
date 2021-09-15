//
//  pH_to_RGB.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/24.
//

import Foundation

class pH_to_RGB
{
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
}
