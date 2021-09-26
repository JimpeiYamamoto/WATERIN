//
//  CheckPicViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit

class CheckPicViewController: UIViewController
{
    var takenImage = UIImage()
    var t_info = take_info()
    var ref_rgb_1 = [String:[Double]]()
    var ref_rgb_2 = [String:[Double]]()
    var target_rgb = [Double]()
    var reg = Regression()
    
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta_1: UIView!
    @IBOutlet weak var ta_2: UIView!
    @IBOutlet weak var ta_3: UIView!
    @IBOutlet weak var ta_4: UIView!
    @IBOutlet weak var ok_button: UIButton!
    @IBOutlet weak var full_v: UIView!
    
    func calc_pH() -> [String:Double]
    {
        let r_y1_lst = [219.506, 219.334, 218.504, 218.285, 217.739, 193.504, 140.789, 109.473, 89.962, 76.630, 74.576, 74.280, 72.481, 71.318, 73.786]
        let g_y1_lst = [144.230, 144.295, 143.407, 143.690, 143.346, 135.776, 122.675, 116.930, 107.813, 99.552, 97.638, 97.548, 97.108, 96.806, 97.666]
        let b_y1_lst = [57.392, 57.319, 56.426, 56.863, 56.864, 50.389, 64.663, 92.237, 97.220, 114.803, 112.310, 111.905, 111.326, 111.034, 111.936]
        let r_x1_lst = [ref_rgb_1["y1_0"]![0], ref_rgb_1["y1_1"]![0], ref_rgb_1["y1_2"]![0], ref_rgb_1["y1_3"]![0], ref_rgb_1["y1_4"]![0],
                       ref_rgb_1["y1_5"]![0], ref_rgb_1["y1_6"]![0], ref_rgb_1["y1_7"]![0], ref_rgb_2["y1_8"]![0], ref_rgb_2["y1_9"]![0], ref_rgb_2["y1_10"]![0],
                       ref_rgb_2["y1_11"]![0], ref_rgb_2["y1_12"]![0], ref_rgb_2["y1_13"]![0], ref_rgb_2["y1_14"]![0]]
        let g_x1_lst = [ref_rgb_1["y1_0"]![1], ref_rgb_1["y1_1"]![1], ref_rgb_1["y1_2"]![1], ref_rgb_1["y1_3"]![1], ref_rgb_1["y1_4"]![1],
                       ref_rgb_1["y1_5"]![1], ref_rgb_1["y1_6"]![1], ref_rgb_1["y1_7"]![1], ref_rgb_2["y1_8"]![1], ref_rgb_2["y1_9"]![1], ref_rgb_2["y1_10"]![1],
                       ref_rgb_2["y1_11"]![1], ref_rgb_2["y1_12"]![1], ref_rgb_2["y1_13"]![1], ref_rgb_2["y1_14"]![1]]
        let b_x1_lst = [ref_rgb_1["y1_0"]![2], ref_rgb_1["y1_1"]![2], ref_rgb_1["y1_2"]![2], ref_rgb_1["y1_3"]![2], ref_rgb_1["y1_4"]![2],
                       ref_rgb_1["y1_5"]![2], ref_rgb_1["y1_6"]![2], ref_rgb_1["y1_7"]![2], ref_rgb_2["y1_8"]![2], ref_rgb_2["y1_9"]![2], ref_rgb_2["y1_10"]![2],
                       ref_rgb_2["y1_11"]![2], ref_rgb_2["y1_12"]![2], ref_rgb_2["y1_13"]![2], ref_rgb_2["y1_14"]![2]]
        
        let r_y2_lst = [219.506, 219.334, 218.504, 218.285, 217.739, 193.504, 140.789, 109.473, 89.962, 76.630, 74.576, 74.280, 72.481, 71.318, 73.786]
        let g_y2_lst = [144.230, 144.295, 143.407, 143.690, 143.346, 135.776, 122.675, 116.930, 107.813, 99.552, 97.638, 97.548, 97.108, 96.806, 97.666]
        let b_y2_lst = [57.392, 57.319, 56.426, 56.863, 56.864, 50.389, 64.663, 92.237, 97.220, 114.803, 112.310, 111.905, 111.326, 111.034, 111.936]
        let r_x2_lst = [ref_rgb_1["y2_0"]![0], ref_rgb_1["y2_1"]![0], ref_rgb_1["y2_2"]![0], ref_rgb_1["y2_3"]![0], ref_rgb_1["y2_4"]![0],
                       ref_rgb_1["y2_5"]![0], ref_rgb_1["y2_6"]![0], ref_rgb_1["y2_7"]![0], ref_rgb_2["y2_8"]![0], ref_rgb_2["y2_9"]![0], ref_rgb_2["y2_10"]![0],
                       ref_rgb_2["y2_11"]![0], ref_rgb_2["y2_12"]![0], ref_rgb_2["y2_13"]![0], ref_rgb_2["y2_14"]![0]]
        let g_x2_lst = [ref_rgb_1["y2_0"]![1], ref_rgb_1["y2_1"]![1], ref_rgb_1["y2_2"]![1], ref_rgb_1["y2_3"]![1], ref_rgb_1["y2_4"]![1],
                       ref_rgb_1["y2_5"]![1], ref_rgb_1["y2_6"]![1], ref_rgb_1["y2_7"]![1], ref_rgb_2["y2_8"]![1], ref_rgb_2["y2_9"]![1], ref_rgb_2["y2_10"]![1],
                       ref_rgb_2["y2_11"]![1], ref_rgb_2["y2_12"]![1], ref_rgb_2["y2_13"]![1], ref_rgb_2["y2_14"]![1]]
        let b_x2_lst = [ref_rgb_1["y2_0"]![2], ref_rgb_1["y2_1"]![2], ref_rgb_1["y2_2"]![2], ref_rgb_1["y2_3"]![2], ref_rgb_1["y2_4"]![2],
                       ref_rgb_1["y2_5"]![2], ref_rgb_1["y2_6"]![2], ref_rgb_1["y2_7"]![2], ref_rgb_2["y2_8"]![2], ref_rgb_2["y2_9"]![2], ref_rgb_2["y2_10"]![2],
                       ref_rgb_2["y2_11"]![2], ref_rgb_2["y2_12"]![2], ref_rgb_2["y2_13"]![2], ref_rgb_2["y2_14"]![2]]
        
        let r_y3_lst = [219.506, 219.334, 218.504, 218.285, 217.739, 193.504, 140.789, 109.473, 89.962, 76.630, 74.576, 74.280, 72.481, 71.318, 73.786]
        let g_y3_lst = [144.230, 144.295, 143.407, 143.690, 143.346, 135.776, 122.675, 116.930, 107.813, 99.552, 97.638, 97.548, 97.108, 96.806, 97.666]
        let b_y3_lst = [57.392, 57.319, 56.426, 56.863, 56.864, 50.389, 64.663, 92.237, 97.220, 114.803, 112.310, 111.905, 111.326, 111.034, 111.936]
        let r_x3_lst = [ref_rgb_1["y3_0"]![0], ref_rgb_1["y3_1"]![0], ref_rgb_1["y3_2"]![0], ref_rgb_1["y3_3"]![0], ref_rgb_1["y3_4"]![0],
                       ref_rgb_1["y3_5"]![0], ref_rgb_1["y3_6"]![0], ref_rgb_1["y3_7"]![0], ref_rgb_2["y3_8"]![0], ref_rgb_2["y3_9"]![0], ref_rgb_2["y3_10"]![0],
                       ref_rgb_2["y3_11"]![0], ref_rgb_2["y3_12"]![0], ref_rgb_2["y3_13"]![0], ref_rgb_2["y3_14"]![0]]
        let g_x3_lst = [ref_rgb_1["y3_0"]![1], ref_rgb_1["y3_1"]![1], ref_rgb_1["y3_2"]![1], ref_rgb_1["y3_3"]![1], ref_rgb_1["y3_4"]![1],
                       ref_rgb_1["y3_5"]![1], ref_rgb_1["y3_6"]![1], ref_rgb_1["y3_7"]![1], ref_rgb_2["y3_8"]![1], ref_rgb_2["y3_9"]![1], ref_rgb_2["y3_10"]![1],
                       ref_rgb_2["y3_11"]![1], ref_rgb_2["y3_12"]![1], ref_rgb_2["y3_13"]![1], ref_rgb_2["y3_14"]![1]]
        let b_x3_lst = [ref_rgb_1["y3_0"]![2], ref_rgb_1["y3_1"]![2], ref_rgb_1["y3_2"]![2], ref_rgb_1["y3_3"]![2], ref_rgb_1["y3_4"]![2],
                       ref_rgb_1["y3_5"]![2], ref_rgb_1["y3_6"]![2], ref_rgb_1["y3_7"]![2], ref_rgb_2["y3_8"]![2], ref_rgb_2["y3_9"]![2], ref_rgb_2["y3_10"]![2],
                       ref_rgb_2["y3_11"]![2], ref_rgb_2["y3_12"]![2], ref_rgb_2["y3_13"]![2], ref_rgb_2["y3_14"]![2]]
//        print("---r_y_lst---")
//        print(r_y_lst)
//        print("---g_y_lst---")
//        print(g_y_lst)
//        print("---b_y_lst---")
//        print(b_y_lst)
//        print("---r_x_lst---")
//        print(r_x_lst)
//        print("---g_x_lst---")
//        print(g_x_lst)
//        print("---b_x_lst---")
//        print(b_x_lst)
//        let r_adjusted = reg.get_ans(x_lst: r_x1_lst, y_lst: r_y1_lst, value: target_rgb[0])
//        let g_adjusted = reg.get_ans(x_lst: g_x1_lst, y_lst: g_y1_lst, value: target_rgb[1])
//        let b_adjusted = reg.get_ans(x_lst: b_x1_lst, y_lst: b_y1_lst, value: target_rgb[2])
        var r_1_after = reg.get_ans(x_lst: r_x1_lst, y_lst: r_y1_lst, value: t_info.target!["paper1_rgb"]![0])
        var g_1_after = reg.get_ans(x_lst: g_x1_lst, y_lst: g_y1_lst, value: t_info.target!["paper1_rgb"]![1])
        var b_1_after = reg.get_ans(x_lst: b_x1_lst, y_lst: b_y1_lst, value: t_info.target!["paper1_rgb"]![2])
        var r_2_after = reg.get_ans(x_lst: r_x2_lst, y_lst: r_y2_lst, value: t_info.target!["paper2_rgb"]![0])
        var g_2_after = reg.get_ans(x_lst: g_x2_lst, y_lst: g_y2_lst, value: t_info.target!["paper2_rgb"]![1])
        var b_2_after = reg.get_ans(x_lst: b_x2_lst, y_lst: b_y2_lst, value: t_info.target!["paper2_rgb"]![2])
        var r_3_after = reg.get_ans(x_lst: r_x3_lst, y_lst: r_y3_lst, value: t_info.target!["paper3_rgb"]![0])
        var g_3_after = reg.get_ans(x_lst: g_x3_lst, y_lst: g_y3_lst, value: t_info.target!["paper3_rgb"]![1])
        var b_3_after = reg.get_ans(x_lst: b_x3_lst, y_lst: b_y3_lst, value: t_info.target!["paper3_rgb"]![2])
        print("---before_addjust---")
        let r_1_before = t_info.target!["paper1_rgb"]![0]
        let g_1_before = t_info.target!["paper1_rgb"]![1]
        let b_1_before = t_info.target!["paper1_rgb"]![2]
        let r_2_before = t_info.target!["paper2_rgb"]![0]
        let g_2_before = t_info.target!["paper2_rgb"]![1]
        let b_2_before = t_info.target!["paper2_rgb"]![2]
        let r_3_before = t_info.target!["paper3_rgb"]![0]
        let g_3_before = t_info.target!["paper3_rgb"]![1]
        let b_3_before = t_info.target!["paper3_rgb"]![2]
//        print("r:\(target_rgb[0])\ng:\(target_rgb[1])\nb:\(target_rgb[2])")
        print("---after_addjust---")
//        print("r:\(r_adjusted)\ng:\(g_adjusted)\nb:\(b_adjusted)")
//        let r_g = r_adjusted - g_adjusted
//        let r_b = r_adjusted - b_adjusted
//        let g_b = g_adjusted - b_adjusted
        let r_g_1 = r_1_after - g_1_after
        let r_b_1 = r_1_after - b_1_after
        let g_b_1 = g_1_after - b_1_after
        let r_g_2 = r_2_after - g_2_after
        let r_b_2 = r_2_after - b_2_after
        let g_b_2 = g_2_after - b_2_after
        let r_g_3 = r_3_after - g_3_after
        let r_b_3 = r_3_after - b_3_after
        let g_b_3 = g_3_after - b_3_after
        let pH_r_g_1 = 6 * 0.00000001 * pow(r_g_1, 4) - 4 * 0.00001 * pow(r_g_1, 3) - 0.0083 * pow(r_g_1, 2) + 0.7737 * r_g_1 + 26.811
        let pH_g_b_1 = 2 * 0.000001 * pow(g_b_1, 3) - 0.0003 * pow(g_b_1, 2) + 0.022 * g_b_1 + 3.1274
        let pH_result_1 = (pH_r_g_1 + pH_g_b_1) / 2
        let pH_r_g_2 = -0.00001 * pow(r_g_2, 3) + 0.0006 * pow(r_g_2, 2) - 0.0303 * r_g_2 + 6.4479
        let pH_r_b_2 = -0.0000006 * pow(r_b_2, 3) + 0.0002 * pow(r_b_2, 2) - 0.036 * r_b_2 + 8.2927
        let pH_g_b_2 = -0.0456 * g_b_2 + 9.7907
        let pH_result_2 = (pH_r_g_2 + pH_r_b_2 + pH_g_b_2) / 3
        let pH_r_g_3 = 0.0873 * r_g_3 + 2.4524
        let pH_r_b_3 = -0.0187 * r_b_3 + 12.833
        let pHg_b_3 = -0.0157 * g_b_3 + 11.013
        let pH_result_3 = (pH_r_g_3 + pH_r_b_3 + pHg_b_3) / 3
        return ["pH_result_1":pH_result_1, "pH_result_2":pH_result_2, "pH_result_3":pH_result_3, "r_1_after":r_1_after, "g_1_after":g_1_after, "b_1_after":b_1_after,
                "r_1_before":r_1_before, "g_1_before":g_1_before, "b_1_before":b_1_before, "r_2_after":r_2_after, "g_2_after":g_2_after, "b_2_after":b_2_after,
                "r_2_before":r_2_before, "g_2_before":g_2_before, "b_2_before":b_2_before, "r_3_after":r_3_after, "g_3_after":g_3_after, "b_3_after":b_3_after,
                "r_3_before":r_3_before, "g_3_before":g_3_before, "b_3_before":b_3_before]
    }

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        image_view.image = takenImage
        image_view.contentMode = .scaleToFill
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @IBAction func ok_action(_ sender: Any)
    {
        let outVC = (storyboard?.instantiateViewController(identifier: "outcome_"))! as OutcomeViewController
        outVC.t_info = self.t_info
        outVC.t_info.outcome_mulch = calc_pH()
        outVC.takenImage = image_view.image!
        outVC.ref_rgb_1 = self.ref_rgb_1
        outVC.ref_rgb_2 = self.ref_rgb_2
        self.navigationController?.pushViewController(outVC, animated: true)
    }
    
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
    
    func set_view_ori()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.072985782
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
