//
//  V_MapViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/29.
//

import Foundation
import UIKit

extension MapViewController
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
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        segment_view.backgroundColor = .white
        segment_view.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        serch_tf.frame = CGRect(x: v_w * 10, y: v_h * 11, width: v_w * 80, height: v_h * 6)
        map_view.frame = CGRect(x: 0, y: v_h * 19, width: v_w * 100, height: v_h * 52)
        segment_view.frame = CGRect(x: v_w * 15, y: v_h * 74, width: v_w * 70, height: v_h * 5)
        date_tf.frame = CGRect(x: v_w * 23, y: v_h * 81, width: v_w * 54, height: v_h * 7)
        back_button.frame = CGRect(x: v_w * 2, y: v_h * 81, width: v_w * 19, height: v_h * 7)
        ahead_button.frame = CGRect(x: v_w * 79, y: v_h * 81, width: v_w * 19, height: v_h * 7)
        back_button.imageView?.contentMode = .scaleAspectFit
        back_button.contentHorizontalAlignment = .fill
        back_button.contentVerticalAlignment = .fill
        ahead_button.imageView?.contentMode = .scaleAspectFit
        ahead_button.contentHorizontalAlignment = .fill
        ahead_button.contentVerticalAlignment = .fill
        date_tf.layer.borderColor = UIColor.black.cgColor
        date_tf.layer.borderWidth = 1.0
        date_tf.adjustsFontSizeToFitWidth = true
        serch_tf.layer.borderColor = UIColor.black.cgColor
        serch_tf.layer.borderWidth = 1.0
        serch_tf.adjustsFontSizeToFitWidth = true
        serch_tf.attributedPlaceholder = NSAttributedString(string: "検索", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
    }
}
