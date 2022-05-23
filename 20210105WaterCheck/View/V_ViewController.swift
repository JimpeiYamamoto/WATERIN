//
//  V_ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/02/28.
//

import Foundation
import UIKit

extension ViewController
{
    func load_set_view()
    {
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func init_view()
    {
        sample_image.image = UIImage(named: v.MARCHERY_PACK_IMG_PATH)
        paper_tf.adjustsFontSizeToFitWidth = true
        paper_label.adjustsFontSizeToFitWidth = true
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        pH_startButton.frame = CGRect(x: v_w * 37, y: v_h * 73, width: v_w * 26, height: v_h * 20)
        pH_startButton.imageView?.contentMode = .scaleAspectFit
        pH_startButton.contentHorizontalAlignment = .fill
        pH_startButton.contentVerticalAlignment = .fill
        sub_back_button.imageView?.contentMode = .scaleAspectFit
        sub_back_button.contentHorizontalAlignment = .fill
        sub_back_button.contentVerticalAlignment = .fill
        sub_ahead_button.imageView?.contentMode = .scaleAspectFit
        sub_ahead_button.contentHorizontalAlignment = .fill
        sub_ahead_button.contentVerticalAlignment = .fill
        paper_back_button.imageView?.contentMode = .scaleAspectFit
        paper_back_button.contentHorizontalAlignment = .fill
        paper_back_button.contentVerticalAlignment = .fill
        paper_ahead_button.imageView?.contentMode = .scaleAspectFit
        paper_ahead_button.contentHorizontalAlignment = .fill
        paper_ahead_button.contentVerticalAlignment = .fill
        setting_view.frame = CGRect(x: v_w * 5, y: v_h * 48, width: v_w * 90, height: v_h * 27)
        let s_w = setting_view.frame.size.width / 100
        let s_h = setting_view.frame.size.height / 100
        sub_label.frame = CGRect(x: s_w * 4, y: s_h * 4, width: s_w * 20, height: s_h * 10)
        sub_tf.frame = CGRect(x: s_w * 20, y: s_h * 19, width: s_w * 60, height: s_h * 20)
        sub_tf.layer.borderColor = UIColor.black.cgColor
        sub_tf.layer.borderWidth = 1.0
        sub_back_button.frame = CGRect(x: s_w * 4, y: s_h * 19, width: s_w * 14, height: s_h * 20)
        sub_ahead_button.frame = CGRect(x: s_w * 82, y: s_h * 19, width: s_w * 14, height: s_h * 20)
        paper_label.frame = CGRect(x: s_w * 4, y: s_h * 48, width: s_w * 19, height: s_h * 10)
        paper_tf.frame = CGRect(x: s_w * 20, y: s_h * 67, width: s_w * 60, height: s_h * 20)
        paper_tf.layer.borderColor = UIColor.black.cgColor
        paper_tf.layer.borderWidth = 1.0
        paper_back_button.frame = CGRect(x: s_w * 4, y: s_h * 67, width: s_w * 14, height: s_h * 20)
        paper_ahead_button.frame = CGRect(x: s_w * 82, y: s_h * 67, width: s_w * 14, height: s_h * 20)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        top_v.frame = CGRect(x: v_w * 4, y: v_h * 12, width: v_w * 44, height: v_h * 34)
        let t_w = top_v.frame.size.width / 100
        let t_h = top_v.frame.size.height / 100
        top_sub_label.frame = CGRect(x: t_w * 3, y: t_h * 3, width: t_w * 40, height: t_h * 15)
        latest_outcome_label.frame = CGRect(x: t_w * 3, y: t_w * 25, width: t_w * 94, height: t_h * 50)
        date_label.frame = CGRect(x: t_w * 3, y: t_h * 75, width: t_w * 94, height: t_h * 10)
        latest_paper_label.frame = CGRect(x: t_w * 3, y: t_h * 87, width: t_w * 94, height: t_h * 10)
        right_v.frame = CGRect(x: v_w * 50, y: v_h * 12, width: v_w * 46, height: v_h * 34)
        let r_w = right_v.frame.size.width / 100
        let r_h = right_v.frame.size.height / 100
        top_paper_label.frame = CGRect(x: r_w * 2, y: r_h * 3, width: r_w * 96, height: r_h * 15)
        sample_image.frame = CGRect(x: r_w * 3, y: r_h * 24, width: r_w * 94, height: r_h * 71)
        self.tabBarController?.tabBar.barTintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        pH_startButton.layer.cornerRadius = 20.0
        setting_view.layer.borderWidth = 1.0
        setting_view.layer.borderColor = UIColor.black.cgColor
        top_v.layer.borderWidth = 1.0
        top_v.layer.borderColor = UIColor.black.cgColor
        right_v.layer.borderWidth = 1.0
        right_v.layer.borderColor = UIColor.black.cgColor
    }
}
