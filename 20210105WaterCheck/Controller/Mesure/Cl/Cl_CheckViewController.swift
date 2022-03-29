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
    var t_info = take_info()
    
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
        image_view.image = t_info.target_image
        image_view.contentMode = .scaleToFill
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
                        
    @IBAction func ok_action(_ sender: Any)
    {
        let cl = Cl_class()
        t_info.addjust_target_rgb = cl.adjust_rgb(ref_rgb: t_info.ref1_rgb![0], target_rgb: t_info.target_rgb!)
        t_info.outcome = cl.calculate_Cl_by_mode(paper_after_rgb: t_info.addjust_target_rgb![0])
        let outVC = (storyboard?.instantiateViewController(identifier: "outcome_"))! as OutcomeViewController
        outVC.t_info = self.t_info
        self.navigationController?.pushViewController(outVC, animated: true)
    }

}
