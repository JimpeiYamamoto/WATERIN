//
//  V_pH_CheckPicViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/02.
//


import Foundation
import UIKit

extension CheckPicViewController
{
    
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.08985782
        paper_v.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.165048544, width: x_ * 1, height: x_ * 9.223300971)
        ta_1.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.504854369, width: x_ * 1, height: x_ * 0.902912621)
        ta_2.frame = CGRect(x: x_ * 4.621359223, y: x_ * 5.854368932, width: x_ * 1, height: x_ * 0.902912621)
        ta_3.frame = CGRect(x: x_ * 4.621359223, y: x_ * 7.242718447, width: x_ * 1, height: x_ * 0.902912621)
        ta_4.frame = CGRect(x: x_ * 4.621359223, y: x_ * 8.563106796, width: x_ * 1, height: x_ * 0.902912621)
        paper_v.layer.borderColor = UIColor.black.cgColor
        paper_v.backgroundColor = .clear
        paper_v.layer.borderWidth = 2
        ta_1.layer.borderColor = UIColor.black.cgColor
        ta_1.backgroundColor = .clear
        ta_1.layer.borderWidth = 2
        ta_2.layer.borderColor = UIColor.black.cgColor
        ta_2.backgroundColor = .clear
        ta_2.layer.borderWidth = 2
        ta_3.layer.borderColor = UIColor.black.cgColor
        ta_3.backgroundColor = .clear
        ta_3.layer.borderWidth = 2
        ta_4.layer.borderColor = UIColor.black.cgColor
        ta_4.backgroundColor = .clear
        ta_4.layer.borderWidth = 2
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        ok_button.frame = CGRect(x: v_w * 35, y: v_h * 75, width: v_w * 30, height: v_h * 20)
        ok_button.imageView?.contentMode = .scaleAspectFit
        ok_button.contentHorizontalAlignment = .fill
        ok_button.contentVerticalAlignment = .fill
    }
}
