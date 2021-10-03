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
        image_view.image = takenImage
        image_view.contentMode = .scaleToFill
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func calc_pH() -> [String:Double]
    {
        pH_Class.t_info = self.t_info
        let paper1_after_rgb = pH_Class.paper1_adjust_rgb(ref_rgb_1: ref_rgb_1, ref_rgb_2: ref_rgb_2)
        let paper2_after_rgb = pH_Class.paper2_adjust_rgb(ref_rgb_1: ref_rgb_1, ref_rgb_2: ref_rgb_2)
        let paper3_after_rgb = pH_Class.paper3_adjust_rgb(ref_rgb_1: ref_rgb_1, ref_rgb_2: ref_rgb_2)
        print("---before---")
        print("r1:\(t_info.target!["paper1_rgb"]![0])\ng1:\(t_info.target!["paper1_rgb"]![1])\nb1:\(t_info.target!["paper1_rgb"]![2])")
        print("r2:\(t_info.target!["paper2_rgb"]![0])\ng2:\(t_info.target!["paper2_rgb"]![1])\nb2:\(t_info.target!["paper2_rgb"]![2])")
        print("r3:\(t_info.target!["paper3_rgb"]![0])\ng3:\(t_info.target!["paper3_rgb"]![1])\nb3:\(t_info.target!["paper3_rgb"]![2])")
        print("---after---")
        print("r1:\(paper1_after_rgb[0])\ng1:\(paper1_after_rgb[1])\nb1:\(paper1_after_rgb[2])")
        print("r2:\(paper2_after_rgb[0])\ng2:\(paper2_after_rgb[1])\nb2:\(paper2_after_rgb[2])")
        print("r3:\(paper3_after_rgb[0])\ng3:\(paper3_after_rgb[1])\nb3:\(paper3_after_rgb[2])")
        let mode = pH_Class.judge_mode(paper1_after_rgb: paper1_after_rgb, paper2_after_rgb: paper2_after_rgb, paper3_after_rgb: paper3_after_rgb)
        let pH_result = pH_Class.calculate_pH_by_mode(paper1_after_rgb: paper1_after_rgb, paper2_after_rgb: paper2_after_rgb, paper3_after_rgb: paper3_after_rgb)
        print("pH_outcome=", pH_result)
        return ["pH_result":pH_result, "r_1_after":paper1_after_rgb[0], "g_1_after":paper1_after_rgb[1], "b_1_after":paper1_after_rgb[2], "r_2_after":paper2_after_rgb[0], "g_2_after":paper2_after_rgb[1], "b_2_after":paper2_after_rgb[2], "r_3_after":paper3_after_rgb[0], "g_3_after":paper3_after_rgb[1], "b_3_after":paper3_after_rgb[0], "mode":Double(mode)]
    }

    @IBAction func ok_action(_ sender: Any)
    {
        let outVC = (storyboard?.instantiateViewController(identifier: "outcome_"))! as OutcomeViewController
        outVC.t_info = self.t_info
        outVC.t_info.outcome_mulch = calc_pH()
        outVC.ref_rgb_1 = self.ref_rgb_1
        outVC.ref_rgb_2 = self.ref_rgb_2
        outVC.t_info.target_image = image_view.image
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
