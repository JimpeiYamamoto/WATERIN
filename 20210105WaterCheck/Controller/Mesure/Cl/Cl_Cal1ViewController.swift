//
//  Cl_Cal1ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/10/18.
//

import UIKit
import AVFoundation

class Cl_Cal1ViewController: UIViewController, AVCaptureDelegate
{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var full_v: UIView!

    @IBOutlet weak var v_0: UIView!
    @IBOutlet weak var v_1: UIView!
    @IBOutlet weak var v_2: UIView!
    @IBOutlet weak var v_3: UIView!
    @IBOutlet weak var v_4: UIView!
    @IBOutlet weak var v_5: UIView!
    
    @IBOutlet weak var l_0: UILabel!
    @IBOutlet weak var l_1: UILabel!
    @IBOutlet weak var l_2: UILabel!
    @IBOutlet weak var l_3: UILabel!
    @IBOutlet weak var l_4: UILabel!
    @IBOutlet weak var l_5: UILabel!
    
    let avCapture = AVCapture()
    var t_info = take_info()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        ref_color_set()
        ref_set_v()
        viewSetting()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        view.isUserInteractionEnabled = false
        avCapture.delegate = self
        avCapture.start_session()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        sleep(1)
        view.isUserInteractionEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        avCapture.stopSession()
    }
    
    var loop_num = 0
    func capture(image: UIImage)
    {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        loop_num += 1
    }

    @IBAction func takeAction(_ sender: Any)
    {
        let cl_class = Cl_class()
        let f_v_w = full_v.frame.size.width
        let f_v_h = full_v.frame.size.height
        
        t_info.ref1_rgb = cl_class.ref_rgb_get(image: imageView.image!, ful_vw: f_v_w, ful_vh: f_v_h)
        t_info.ref1_image = imageView.image
        let ClmesureVC = (storyboard?.instantiateViewController(identifier: "Cl_mesure_"))! as Cal_MesureViewController
        ClmesureVC.t_info = t_info
        self.avCapture.delegate = nil
        self.avCapture.stopSession()
        self.navigationController?.pushViewController(ClmesureVC, animated: true)
    }
}
