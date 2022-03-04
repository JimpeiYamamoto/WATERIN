//
//  V_pH_Cal2ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/02.
//

import Foundation
import UIKit

extension pH_Cal2ViewController
{
    func set_view()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes =
        [.foregroundColor: UIColor.black]
        let viewWidth = view.frame.size.width / 100
        let viewHeight = view.frame.size.height / 100
        take_button.frame = CGRect(x: viewWidth * 35, y: viewHeight * 75,
                                   width: viewWidth * 30, height: viewHeight * 20)
        take_button.imageView?.contentMode = .scaleAspectFit
        take_button.contentHorizontalAlignment = .fill
        take_button.contentVerticalAlignment = .fill
    }
    
    func ref_set_v()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: full_v.frame.size.width, height: full_v.frame.size.height)
        let s_w = Double(full_v.frame.size.width * 0.072985782)
        let s_h = Double(s_w * 1.194805195)
        
        let x_0 = s_w * 4.155844156
        let x_1 = s_w * 5.649350649
        let x_2 = s_w * 7.142857143
        let x_3 = s_w * 8.61038961
        
        let y_7 = s_w * 5.454545455
        let y_6 = s_w * 7.038961039
        let y_5 = s_w * 8.61038961
        let y_4 = s_w * 10.1688311
        let y_3 = s_w * 11.71428571
        let y_2 = s_w * 13.27272727
        let y_1 = s_w * 14.81818182
        let y_0 = s_w * 16.36363636
        
        let w_00 = s_w * 6.376623377
        let x_00 = s_w * 3.649350649
        let lx = s_w * 2.5
        
        v_0_0.frame = CGRect(x: x_00, y: y_7, width: w_00, height: s_h)
        v_0_1.frame = CGRect(x: x_0, y: y_7, width: s_w, height: s_h)
        v_0_2.frame = CGRect(x: x_1, y: y_7, width: s_w, height: s_h)
        v_0_3.frame = CGRect(x: x_2, y: y_7, width: s_w, height: s_h)
        v_0_4.frame = CGRect(x: x_3, y: y_7, width: s_w, height: s_h)
        l_7.frame = CGRect(x: lx, y: y_7, width: s_w, height: s_h)
        
        v_1_0.frame = CGRect(x: x_00, y: y_6, width: w_00, height: s_h)
        v_1_1.frame = CGRect(x: x_0, y: y_6, width: s_w, height: s_h)
        v_1_2.frame = CGRect(x: x_1, y: y_6, width: s_w, height: s_h)
        v_1_3.frame = CGRect(x: x_2, y: y_6, width: s_w, height: s_h)
        v_1_4.frame = CGRect(x: x_3, y: y_6, width: s_w, height: s_h)
        l_6.frame = CGRect(x: lx, y: y_6, width: s_w, height: s_h)
        
        v_2_0.frame = CGRect(x: x_00, y: y_5, width: w_00, height: s_h)
        v_2_1.frame = CGRect(x: x_0, y: y_5, width: s_w, height: s_h)
        v_2_2.frame = CGRect(x: x_1, y: y_5, width: s_w, height: s_h)
        v_2_3.frame = CGRect(x: x_2, y: y_5, width: s_w, height: s_h)
        v_2_4.frame = CGRect(x: x_3, y: y_5, width: s_w, height: s_h)
        l_5.frame = CGRect(x: lx, y: y_5, width: s_w, height: s_h)
        
        v_3_0.frame = CGRect(x: x_00, y: y_4, width: w_00, height: s_h)
        v_3_1.frame = CGRect(x: x_0, y: y_4, width: s_w, height: s_h)
        v_3_2.frame = CGRect(x: x_1, y: y_4, width: s_w, height: s_h)
        v_3_3.frame = CGRect(x: x_2, y: y_4, width: s_w, height: s_h)
        v_3_4.frame = CGRect(x: x_3, y: y_4, width: s_w, height: s_h)
        l_4.frame = CGRect(x: lx, y: y_4, width: s_w, height: s_h)
        
        v_4_0.frame = CGRect(x: x_00, y: y_3, width: w_00, height: s_h)
        v_4_1.frame = CGRect(x: x_0, y: y_3, width: s_w, height: s_h)
        v_4_2.frame = CGRect(x: x_1, y: y_3, width: s_w, height: s_h)
        v_4_3.frame = CGRect(x: x_2, y: y_3, width: s_w, height: s_h)
        v_4_4.frame = CGRect(x: x_3, y: y_3, width: s_w, height: s_h)
        l_3.frame = CGRect(x: lx, y: y_3, width: s_w, height: s_h)
        
        v_5_0.frame = CGRect(x: x_00, y: y_2, width: w_00, height: s_h)
        v_5_1.frame = CGRect(x: x_0, y: y_2, width: s_w, height: s_h)
        v_5_2.frame = CGRect(x: x_1, y: y_2, width: s_w, height: s_h)
        v_5_3.frame = CGRect(x: x_2, y: y_2, width: s_w, height: s_h)
        v_5_4.frame = CGRect(x: x_3, y: y_2, width: s_w, height: s_h)
        l_2.frame = CGRect(x: lx, y: y_2, width: s_w, height: s_h)
        
        v_6_0.frame = CGRect(x: x_00, y: y_1, width: w_00, height: s_h)
        v_6_1.frame = CGRect(x: x_0, y: y_1, width: s_w, height: s_h)
        v_6_2.frame = CGRect(x: x_1, y: y_1, width: s_w, height: s_h)
        v_6_3.frame = CGRect(x: x_2, y: y_1, width: s_w, height: s_h)
        v_6_4.frame = CGRect(x: x_3, y: y_1, width: s_w, height: s_h)
        l_1.frame = CGRect(x: lx, y: y_1, width: s_w, height: s_h)
        
        v_7_0.frame = CGRect(x: x_00, y: y_0, width: w_00, height: s_h)
        v_7_1.frame = CGRect(x: x_0, y: y_0, width: s_w, height: s_h)
        v_7_2.frame = CGRect(x: x_1, y: y_0, width: s_w, height: s_h)
        v_7_3.frame = CGRect(x: x_2, y: y_0, width: s_w, height: s_h)
        v_7_4.frame = CGRect(x: x_3, y: y_0, width: s_w, height: s_h)
        l_0.frame = CGRect(x: lx, y: y_0, width: s_w, height: s_h)
    }
//
//
//    func ref_set_v()
//    {
//        let v_w = view.frame.size.width / 100
//        let v_h = view.frame.size.height / 100
//        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
//        imageView.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
//        let x_ = full_v.frame.size.width * 0.072985782
//        v_0_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 5.454545455, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_0_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
//        v_0_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
//        v_0_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
//        v_0_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
//        l_7.frame = CGRect(x: x_ * 2.5, y: x_ * 5.454545455, width: x_, height: x_ * 1.194805195)
//
//        v_1_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 7.038961039, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_1_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
//        v_1_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
//        v_1_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
//        v_1_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
//        l_6.frame = CGRect(x: x_ * 2.5, y: x_ * 7.038961039, width: x_, height: x_ * 1.194805195)
//
//        v_2_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 8.61038961, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_2_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
//        v_2_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
//        v_2_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
//        v_2_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
//        l_5.frame = CGRect(x: x_ * 2.5, y: x_ * 8.61038961, width: x_, height: x_ * 1.194805195)
//
//        v_3_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 10.16883117, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_3_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
//        v_3_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
//        v_3_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
//        v_3_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
//        l_4.frame = CGRect(x: x_ * 2.5, y: x_ * 10.16883117, width: x_, height: x_ * 1.194805195)
//
//        v_4_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 11.71428571, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_4_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
//        v_4_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
//        v_4_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
//        v_4_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
//        l_3.frame = CGRect(x: x_ * 2.5, y:x_ * 11.71428571, width: x_, height: x_ * 1.194805195)
//
//        v_5_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 13.27272727, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_5_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
//        v_5_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
//        v_5_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
//        v_5_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
//        l_2.frame = CGRect(x: x_ * 2.5, y: x_ * 13.27272727, width: x_, height: x_ * 1.194805195)
//
//        v_6_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 14.81818182, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_6_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
//        v_6_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
//        v_6_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
//        v_6_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
//        l_1.frame = CGRect(x: x_ * 2.5, y: x_ * 14.81818182, width: x_, height: x_ * 1.194805195)
//
//        v_7_0.frame = CGRect(x: x_ * 3.649350649, y: x_ * 16.36363636, width: x_ * 6.376623377, height: x_ * 1.194805195)
//        v_7_1.frame = CGRect(x: x_ * 4.155844156, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
//        v_7_2.frame = CGRect(x: x_ * 5.649350649, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
//        v_7_3.frame = CGRect(x: x_ * 7.142857143, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
//        v_7_4.frame = CGRect(x: x_ * 8.61038961, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
//        l_0.frame = CGRect(x: x_ * 2.5, y: x_ * 16.36363636, width: x_, height: x_ * 1.194805195)
//    }
//
    func ref_color_set()
    {
        v_0_0.layer.borderColor = UIColor.black.cgColor
        v_0_0.backgroundColor = .clear
        v_0_0.layer.borderWidth = 2
        v_0_1.layer.borderColor = UIColor.black.cgColor
        v_0_1.backgroundColor = .clear
        v_0_1.layer.borderWidth = 2
        v_0_2.layer.borderColor = UIColor.black.cgColor
        v_0_2.backgroundColor = .clear
        v_0_2.layer.borderWidth = 2
        v_0_3.layer.borderColor = UIColor.black.cgColor
        v_0_3.backgroundColor = .clear
        v_0_3.layer.borderWidth = 2
        v_0_4.layer.borderColor = UIColor.black.cgColor
        v_0_4.backgroundColor = .clear
        v_0_4.layer.borderWidth = 2
        
        v_1_0.layer.borderColor = UIColor.black.cgColor
        v_1_0.backgroundColor = .clear
        v_1_0.layer.borderWidth = 2
        v_1_1.layer.borderColor = UIColor.black.cgColor
        v_1_1.backgroundColor = .clear
        v_1_1.layer.borderWidth = 2
        v_1_2.layer.borderColor = UIColor.black.cgColor
        v_1_2.backgroundColor = .clear
        v_1_2.layer.borderWidth = 2
        v_1_3.layer.borderColor = UIColor.black.cgColor
        v_1_3.backgroundColor = .clear
        v_1_3.layer.borderWidth = 2
        v_1_4.layer.borderColor = UIColor.black.cgColor
        v_1_4.backgroundColor = .clear
        v_1_4.layer.borderWidth = 2
        
        v_2_0.layer.borderColor = UIColor.black.cgColor
        v_2_0.backgroundColor = .clear
        v_2_0.layer.borderWidth = 2
        v_2_1.layer.borderColor = UIColor.black.cgColor
        v_2_1.backgroundColor = .clear
        v_2_1.layer.borderWidth = 2
        v_2_2.layer.borderColor = UIColor.black.cgColor
        v_2_2.backgroundColor = .clear
        v_2_2.layer.borderWidth = 2
        v_2_3.layer.borderColor = UIColor.black.cgColor
        v_2_3.backgroundColor = .clear
        v_2_3.layer.borderWidth = 2
        v_2_4.layer.borderColor = UIColor.black.cgColor
        v_2_4.backgroundColor = .clear
        v_2_4.layer.borderWidth = 2
        
        v_3_0.layer.borderColor = UIColor.black.cgColor
        v_3_0.backgroundColor = .clear
        v_3_0.layer.borderWidth = 2
        v_3_1.layer.borderColor = UIColor.black.cgColor
        v_3_1.backgroundColor = .clear
        v_3_1.layer.borderWidth = 2
        v_3_2.layer.borderColor = UIColor.black.cgColor
        v_3_2.backgroundColor = .clear
        v_3_2.layer.borderWidth = 2
        v_3_3.layer.borderColor = UIColor.black.cgColor
        v_3_3.backgroundColor = .clear
        v_3_3.layer.borderWidth = 2
        v_3_4.layer.borderColor = UIColor.black.cgColor
        v_3_4.backgroundColor = .clear
        v_3_4.layer.borderWidth = 2
        
        v_4_0.layer.borderColor = UIColor.black.cgColor
        v_4_0.backgroundColor = .clear
        v_4_0.layer.borderWidth = 2
        v_4_1.layer.borderColor = UIColor.black.cgColor
        v_4_1.backgroundColor = .clear
        v_4_1.layer.borderWidth = 2
        v_4_2.layer.borderColor = UIColor.black.cgColor
        v_4_2.backgroundColor = .clear
        v_4_2.layer.borderWidth = 2
        v_4_3.layer.borderColor = UIColor.black.cgColor
        v_4_3.backgroundColor = .clear
        v_4_3.layer.borderWidth = 2
        v_4_4.layer.borderColor = UIColor.black.cgColor
        v_4_4.backgroundColor = .clear
        v_4_4.layer.borderWidth = 2
        
        v_5_0.layer.borderColor = UIColor.black.cgColor
        v_5_0.backgroundColor = .clear
        v_5_0.layer.borderWidth = 2
        v_5_1.layer.borderColor = UIColor.black.cgColor
        v_5_1.backgroundColor = .clear
        v_5_1.layer.borderWidth = 2
        v_5_2.layer.borderColor = UIColor.black.cgColor
        v_5_2.backgroundColor = .clear
        v_5_2.layer.borderWidth = 2
        v_5_3.layer.borderColor = UIColor.black.cgColor
        v_5_3.backgroundColor = .clear
        v_5_3.layer.borderWidth = 2
        v_5_4.layer.borderColor = UIColor.black.cgColor
        v_5_4.backgroundColor = .clear
        v_5_4.layer.borderWidth = 2
        
        v_6_0.layer.borderColor = UIColor.black.cgColor
        v_6_0.backgroundColor = .clear
        v_6_0.layer.borderWidth = 2
        v_6_1.layer.borderColor = UIColor.black.cgColor
        v_6_1.backgroundColor = .clear
        v_6_1.layer.borderWidth = 2
        v_6_2.layer.borderColor = UIColor.black.cgColor
        v_6_2.backgroundColor = .clear
        v_6_2.layer.borderWidth = 2
        v_6_3.layer.borderColor = UIColor.black.cgColor
        v_6_3.backgroundColor = .clear
        v_6_3.layer.borderWidth = 2
        v_6_4.layer.borderColor = UIColor.black.cgColor
        v_6_4.backgroundColor = .clear
        v_6_4.layer.borderWidth = 2
        
        v_7_0.layer.borderColor = UIColor.black.cgColor
        v_7_0.backgroundColor = .clear
        v_7_0.layer.borderWidth = 2
        v_7_1.layer.borderColor = UIColor.black.cgColor
        v_7_1.backgroundColor = .clear
        v_7_1.layer.borderWidth = 2
        v_7_2.layer.borderColor = UIColor.black.cgColor
        v_7_2.backgroundColor = .clear
        v_7_2.layer.borderWidth = 2
        v_7_3.layer.borderColor = UIColor.black.cgColor
        v_7_3.backgroundColor = .clear
        v_7_3.layer.borderWidth = 2
        v_7_4.layer.borderColor = UIColor.black.cgColor
        v_7_4.backgroundColor = .clear
        v_7_4.layer.borderWidth = 2
    }
}
