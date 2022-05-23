//
//  V_Cl_Cal1ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/22.
//

import Foundation
import UIKit

extension Cl_Cal1ViewController
{
    func ref_set_v()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11,
                              width: v_w * 86.4, height: v_w * 153.6)
        imageView.frame = CGRect(x: 0, y: 0,
                                 width: full_v.frame.size.width, height: full_v.frame.size.height)
        
        let x_ = full_v.frame.size.width * 0.39339623
        let vx = x_ * 1.15587529
        let lx = x_ * 0.9
        let vl_w = x_ * 0.21582734
        let vl_h = x_ * 0.20863309
        let y_0 = x_ * 3.10551559
        let y_1 = x_ * 2.8177458
        let y_2 = x_ * 2.52757794
        let y_3 = x_ * 2.23741007
        let y_4 = x_ * 1.96402878
        let y_5 = x_ * 1.70983213
        v_0.frame = CGRect(x: vx, y: y_0, width: vl_w, height: vl_h)
        l_0.frame = CGRect(x: lx, y: y_0, width: vl_w, height: vl_h)
        v_1.frame = CGRect(x: vx, y: y_1, width: vl_w, height: vl_h)
        l_1.frame = CGRect(x: lx, y: y_1, width: vl_w, height: vl_h)
        v_2.frame = CGRect(x: vx, y: y_2, width: vl_w, height: vl_h)
        l_2.frame = CGRect(x: lx, y: y_2, width: vl_w, height: vl_h)
        v_3.frame = CGRect(x: vx, y: y_3, width: vl_w, height: vl_h)
        l_3.frame = CGRect(x: lx, y: y_3, width: vl_w, height: vl_h)
        v_4.frame = CGRect(x: vx, y: y_4, width: vl_w, height: vl_h)
        l_4.frame = CGRect(x: lx, y: y_4, width: vl_w, height: vl_h)
        v_5.frame = CGRect(x: vx, y: y_5, width: vl_w, height: vl_h)
        l_5.frame = CGRect(x: lx, y: y_5, width: vl_w, height: vl_h)
    }
    
    func viewSetting()
    {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.tabBarController?.tabBar.isHidden = true
        let viewWidth = view.frame.size.width / 100
        let viewHeight = view.frame.size.height / 100
        takeButton.frame = CGRect(x: viewWidth * 35, y: viewHeight * 75, width: viewWidth * 30, height: viewHeight * 20)
        takeButton.layer.cornerRadius = 20.0
        takeButton.imageView?.contentMode = .scaleAspectFit
        takeButton.contentHorizontalAlignment = .fill
        takeButton.contentVerticalAlignment = .fill
        takeButton.backgroundColor = .clear
        takeButton.titleLabel?.text = ""
    }
    
    func ref_color_set()
    {
        v_0.layer.borderColor = UIColor.black.cgColor
        v_0.backgroundColor = .clear
        v_0.layer.borderWidth = 2
        v_1.layer.borderColor = UIColor.black.cgColor
        v_1.backgroundColor = .clear
        v_1.layer.borderWidth = 2
        v_2.layer.borderColor = UIColor.black.cgColor
        v_2.backgroundColor = .clear
        v_2.layer.borderWidth = 2
        v_3.layer.borderColor = UIColor.black.cgColor
        v_3.backgroundColor = .clear
        v_3.layer.borderWidth = 2
        v_4.layer.borderColor = UIColor.black.cgColor
        v_4.backgroundColor = .clear
        v_4.layer.borderWidth = 2
        v_5.layer.borderColor = UIColor.black.cgColor
        v_5.backgroundColor = .clear
        v_5.layer.borderWidth = 2
    }
}
