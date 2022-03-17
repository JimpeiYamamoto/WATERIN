//
//  V_OutcomeViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/03/03.
//

import Foundation
import UIKit

extension OutcomeViewController
{
    func set_view()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        date_label.frame = CGRect(x: v_w * 5, y: v_h * 7, width: v_w * 94, height: v_h * 6)
        top_view.frame = CGRect(x: v_w * 3, y: v_h * 15, width: v_w * 94, height: v_h * 22)
        let t_w = top_view.frame.size.width / 100
        let t_h = top_view.frame.size.height / 100
        sub_label.frame = CGRect(x: t_w * 5, y: t_h * 3, width: t_w * 30, height: t_h * 15)
        outcome_label.frame = CGRect(x: t_w * 20, y: t_h * 15, width: t_w * 60, height: t_h * 82)
        second_v.frame = CGRect(x: v_w * 3, y: v_h * 39, width: v_w * 94, height: v_h * 10)
        let s_w = second_v.frame.size.width / 100
        let s_h = second_v.frame.size.height / 100
        paper_label.frame = CGRect(x: s_w * 5, y: s_h * 3, width: s_w * 30, height: s_h * 30)
        selected_paper_label.frame = CGRect(x: s_w * 10, y: s_h * 33, width: s_w * 80, height: s_h * 67)
        buttom_v.frame = CGRect(x: v_w * 3, y: v_h * 52, width: v_w * 94, height: v_h * 17)
        let b_w = buttom_v.frame.size.width / 100
        let b_h = buttom_v.frame.size.height / 100
        water_label.frame = CGRect(x: b_w * 5, y: b_h * 3, width: b_w * 30, height: b_h * 17)
        evaluate_label.frame = CGRect(x: b_w * 10, y:b_h * 20, width: b_w * 80, height: b_h * 20)
        cate_label.frame = CGRect(x: b_w * 5, y: b_h * 43, width: b_w * 30, height: b_h * 17)
        cate_tf.frame = CGRect(x: b_w * 20, y: b_h * 63, width: b_w * 60, height: b_h * 30)
        change_cate_button.frame = CGRect(x: b_w * 82, y: b_h * 63, width: b_w * 16, height: b_h * 30)
        back_button.frame = CGRect(x: v_w * 30, y: v_h * 86, width: v_w * 40, height: v_h * 13)
        cate_tf.layer.borderWidth = 1.0
        cate_tf.layer.borderColor = UIColor.black.cgColor
        back_button.imageView?.contentMode = .scaleAspectFit
        back_button.contentHorizontalAlignment = .fill
        back_button.contentVerticalAlignment = .fill
        change_cate_button.imageView?.contentMode = .scaleAspectFit
        change_cate_button.contentHorizontalAlignment = .fill
        change_cate_button.contentVerticalAlignment = .fill
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        top_view.layer.borderColor = UIColor.black.cgColor
        top_view.layer.borderWidth = 1.0
    }
}
