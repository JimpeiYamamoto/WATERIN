//
//  Cl_CheckViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/10/18.
//

import UIKit
/*
 Clの試験紙をとった写真が正しく測定できているかをチェックするViewControllerです。
 */
class Cl_CheckViewController: UIViewController
{
    
    var takenImage = UIImage()
    var t_info = take_info()
    var ref_rgb_1 = [String:[Double]]()
    var ref_rgb_2 = [String:[Double]]()
    var target_rgb = [Double]()
    var reg = Regression()
    var mode = Double()
    var Cl_Class = Cl_class()
    
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta: UIView!
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
    
    func calc_Cl() -> [String:Double]
    {
        Cl_Class.t_info = self.t_info
        let paper_after_rgb = Cl_Class.paper_adjust_rgb(ref_rgb_1: ref_rgb_1)
        print("---before---")
        print("r1:\(t_info.target!["paper_rgb"]![0])\ng1:\(t_info.target!["paper_rgb"]![1])\nb1:\(t_info.target!["paper_rgb"]![2])")
        print("---after---")
        print("r1:\(paper_after_rgb[0])\ng1:\(paper_after_rgb[1])\nb1:\(paper_after_rgb[2])")
        let mode = Cl_Class.judge_mode(paper_after_rgb: paper_after_rgb)
        let Cl_result = Cl_Class.calculate_Cl_by_mode(paper_after_rgb: paper_after_rgb)
        print("pH_outcome=", Cl_result)
        return ["pH_result":Cl_result, "r_1_after":paper_after_rgb[0], "g_1_after":paper_after_rgb[1], "b_1_after":paper_after_rgb[2], "mode":Double(mode)]
    }

    @IBAction func ok_action(_ sender: Any)
    {
        let outVC = (storyboard?.instantiateViewController(identifier: "outcome_"))! as OutcomeViewController
        outVC.t_info = self.t_info
        outVC.t_info.outcome_mulch = calc_Cl()
        outVC.ref_rgb_1 = self.ref_rgb_1
        outVC.t_info.target_image = image_view.image
        self.navigationController?.pushViewController(outVC, animated: true)
    }
    
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
    
    func set_view_ori()
    {
        let v_w = view.frame.size.width / 100
        let v_h = view.frame.size.height / 100
        full_v.frame = CGRect(x: v_w * 6.8, y: v_h * 11, width: v_w * 86.4, height: v_w * 153.6)
        image_view.frame = CGRect(x: 0, y: 0, width: full_v.frame.size.width, height: full_v.frame.size.height)
        let x_ = full_v.frame.size.width * 0.072985782
        paper_v.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.165048544, width: x_ * 1, height: x_ * 9.223300971)
        ta.frame = CGRect(x: x_ * 4.621359223, y: x_ * 4.504854369, width: x_ * 1, height: x_ * 0.902912621)
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
