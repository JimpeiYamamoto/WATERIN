//
//  V_Cl_CheckViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/29.
//

import Foundation
import UIKit

extension Cl_CheckViewController
{
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.05308057
        paper_v.frame = CGRect(x: x_ * 8.82142857, y: x_ * 8.69642857, width: x_ * 1, height: x_ * 9.223300971)
        ta.frame = CGRect(x: x_ * 8.82142857, y: x_ * 8.69642857, width: x_ * 1, height: x_ * 1)
        paper_v.layer.borderColor = UIColor.black.cgColor
        paper_v.backgroundColor = .clear
        paper_v.layer.borderWidth = 2
        ta.layer.borderColor = UIColor.black.cgColor
        ta.backgroundColor = .clear
        ta.layer.borderWidth = 2
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
