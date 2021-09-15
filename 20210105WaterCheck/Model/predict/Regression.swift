//
//  Regression.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/07/10.
//

import Foundation

class Regression
{
    func get_average(num_lst:[Double]) -> Double
    {
        var sum = 0.0
        
        for num in num_lst
        {
            sum += num
        }
        return (sum / Double(num_lst.count))
    }
    
    func get_covariance(x_lst:[Double], y_lst:[Double]) -> Double
    {
        var squa_sum = 0.0
        let x_ave = get_average(num_lst: x_lst)
        let y_ave = get_average(num_lst: y_lst)
        var index = 0
        
        for x in x_lst
        {
            squa_sum += (x_ave - x) * (y_ave - y_lst[index])
            index += 1
        }
        return (squa_sum / Double(x_lst.count))
    }
    
    func get_variance(x_lst:[Double]) -> Double
    {
        var squa_sum = 0.0
        let x_ave = get_average(num_lst: x_lst)
        
        for x in x_lst
        {
            squa_sum += (x_ave - x) * (x_ave - x)
        }
        return (squa_sum / Double(x_lst.count))
    }
    
    func get_gradient(x_lst:[Double], y_lst:[Double]) -> Double
    {
        return (get_covariance(x_lst: x_lst, y_lst: y_lst) / get_variance(x_lst: x_lst))
    }
    
    func get_intercept(x_lst:[Double], y_lst:[Double]) -> Double
    {
        return (get_average(num_lst: y_lst) - (get_gradient(x_lst: x_lst, y_lst: y_lst) * get_average(num_lst: x_lst)))
    }
    
    func get_ans(x_lst:[Double], y_lst:[Double], value:Double) -> Double
    {
        
        let a = get_gradient(x_lst: x_lst, y_lst: y_lst)
        let b = get_intercept(x_lst: x_lst, y_lst: y_lst)
        if (b >= 0)
        {
            print("y=\(a)x+\(b)")
        }
        else
        {
            print("y=\(a)x\(b)")
        }
        return (a * value + b)
    }
}
