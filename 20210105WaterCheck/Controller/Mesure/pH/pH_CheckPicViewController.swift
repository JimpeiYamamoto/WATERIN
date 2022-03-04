//
//  CheckPicViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit

class CheckPicViewController: UIViewController
{
    var t_info = take_info()
    var reg = Regression()
    var mode = Double()
    var pH_Class = pH_class()
    
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta_1: UIView!
    @IBOutlet weak var ta_2: UIView!
    @IBOutlet weak var ta_3: UIView!
    @IBOutlet weak var ta_4: UIView!
    @IBOutlet weak var ok_button: UIButton!
    @IBOutlet weak var full_v: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        image_view.image = t_info.target_image
        image_view.contentMode = .scaleToFill
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }


    @IBAction func ok_action(_ sender: Any)
    {
        t_info.addjust_target_rgb = [[Double]](repeating: [Double](repeating: 0, count: 4), count:4)
        t_info.addjust_target_rgb![0] = pH_Class.paper_adjust_rgb(ref_rgb_1: t_info.ref1_rgb!,
                                                           ref_rgb_2: t_info.ref2_rgb!,
                                                           target_rgb: t_info.target_rgb!,
                                                           paper_num: 0)
        t_info.addjust_target_rgb![1] = pH_Class.paper_adjust_rgb(ref_rgb_1: t_info.ref1_rgb!,
                                                           ref_rgb_2: t_info.ref2_rgb!,
                                                           target_rgb: t_info.target_rgb!,
                                                           paper_num: 1)
        t_info.addjust_target_rgb![2] = pH_Class.paper_adjust_rgb(ref_rgb_1: t_info.ref1_rgb!,
                                                           ref_rgb_2: t_info.ref2_rgb!,
                                                           target_rgb: t_info.target_rgb!,
                                                           paper_num: 2)
        t_info.calc_mode = pH_Class.judge_mode(paper0_after_rgb: t_info.addjust_target_rgb![0],
                                               paper1_after_rgb: t_info.addjust_target_rgb![1],
                                               paper2_after_rgb: t_info.addjust_target_rgb![2])
        t_info.outcome = pH_Class.calculate_pH_by_mode(p0_after_rgb: t_info.addjust_target_rgb![0],
                                                       p1_after_rgb: t_info.addjust_target_rgb![1],
                                                       p2_after_rgb: t_info.addjust_target_rgb![2],
                                                       mode: t_info.calc_mode!)
        let outVC = (storyboard?.instantiateViewController(identifier: "outcome_"))! as OutcomeViewController
        outVC.t_info = self.t_info
        self.navigationController?.pushViewController(outVC, animated: true)
    }
    
}
