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
        let r_y_lst = [219.506, 219.334, 218.504, 218.285, 217.739, 193.504, 140.789, 109.473,
                       89.962, 76.630, 74.576, 74.280, 72.481, 71.318, 73.786]
        let g_y_lst = [144.230, 144.295, 143.407, 143.690, 143.346, 135.776, 122.675, 116.930,
                       107.813, 99.552, 97.638, 97.548, 97.108, 96.806, 97.666]
        let b_y_lst = [57.392, 57.319, 56.426, 56.863, 56.864, 50.389, 64.663, 92.237,
                       97.220, 114.803, 112.310, 111.905, 111.326, 111.034, 111.936]
        let r_x_lst = [ref_rgb_1["y_0"]![0], ref_rgb_1["y_1"]![0], ref_rgb_1["y_2"]![0], ref_rgb_1["y_3"]![0], ref_rgb_1["y_4"]![0],
                       ref_rgb_1["y_5"]![0], ref_rgb_1["y_6"]![0], ref_rgb_1["y_7"]![0], ref_rgb_2["y_8"]![0], ref_rgb_2["y_9"]![0], ref_rgb_2["y_10"]![0],
                       ref_rgb_2["y_11"]![0], ref_rgb_2["y_12"]![0], ref_rgb_2["y_13"]![0], ref_rgb_2["y_14"]![0]]
        let g_x_lst = [ref_rgb_1["y_0"]![1], ref_rgb_1["y_1"]![1], ref_rgb_1["y_2"]![1], ref_rgb_1["y_3"]![1], ref_rgb_1["y_4"]![1],
                       ref_rgb_1["y_5"]![1], ref_rgb_1["y_6"]![1], ref_rgb_1["y_7"]![1], ref_rgb_2["y_8"]![1], ref_rgb_2["y_9"]![1], ref_rgb_2["y_10"]![1],
                       ref_rgb_2["y_11"]![1], ref_rgb_2["y_12"]![1], ref_rgb_2["y_13"]![1], ref_rgb_2["y_14"]![1]]
        let b_x_lst = [ref_rgb_1["y_0"]![2], ref_rgb_1["y_1"]![2], ref_rgb_1["y_2"]![2], ref_rgb_1["y_3"]![2], ref_rgb_1["y_4"]![2],
                       ref_rgb_1["y_5"]![2], ref_rgb_1["y_6"]![2], ref_rgb_1["y_7"]![2], ref_rgb_2["y_8"]![2], ref_rgb_2["y_9"]![2], ref_rgb_2["y_10"]![2],
                       ref_rgb_2["y_11"]![2], ref_rgb_2["y_12"]![2], ref_rgb_2["y_13"]![2], ref_rgb_2["y_14"]![2]]
        print("---r_y_lst---")
        print(r_y_lst)
        print("---g_y_lst---")
        print(g_y_lst)
        print("---b_y_lst---")
        print(b_y_lst)
        print("---r_x_lst---")
        print(r_x_lst)
        print("---g_x_lst---")
        print(g_x_lst)
        print("---b_x_lst---")
        print(b_x_lst)
        var r_adjusted = reg.get_ans(x_lst: r_x_lst, y_lst: r_y_lst, value: target_rgb[0])
        var g_adjusted = reg.get_ans(x_lst: g_x_lst, y_lst: g_y_lst, value: target_rgb[1])
        var b_adjusted = reg.get_ans(x_lst: b_x_lst, y_lst: b_y_lst, value: target_rgb[2])
        print("---before_addjust---")
        
        let r_before = target_rgb[0]
        let g_before = target_rgb[1]
        let b_before = target_rgb[2]
        
        print("r:\(target_rgb[0])\ng:\(target_rgb[1])\nb:\(target_rgb[2])")
        print("---after_addjust---")
        print("r:\(r_adjusted)\ng:\(g_adjusted)\nb:\(b_adjusted)")
        let r_g = r_adjusted - g_adjusted
        let r_b = r_adjusted - b_adjusted
        let g_b = g_adjusted - b_adjusted
        let pH_r_g = -0.00001 * pow(r_g, 3) + 0.0006 * pow(r_g, 2) - 0.0303 * r_g + 6.4479
        let pH_r_b = -0.0000006 * pow(r_b, 3) + 0.0002 * pow(r_b, 2) - 0.036 * r_b + 8.2927
        let pH_g_b = -0.0456 * g_b + 9.7907
        print("pH_r_g=\(pH_r_g)\npH_r_b=\(pH_r_b)\npH_g_b=\(pH_g_b)")
        print("average_pH=\((pH_r_g + pH_r_b + pH_g_b)/3)")
        let pH_result = (pH_r_g + pH_r_b) / 2
        return ["pH_result":pH_result, "r_after":r_adjusted, "g_after":g_adjusted, "b_after":b_adjusted,
                "r_before":r_before, "g_before":g_before, "b_before":b_before]
    }
    
    func set_view()
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
        self.navigationController?.pushViewController(outVC, animated: true)
    }
}
