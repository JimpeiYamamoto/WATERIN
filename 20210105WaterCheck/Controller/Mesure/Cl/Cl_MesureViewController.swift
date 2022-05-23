//
//  Cal_MesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/10/18.
//

import UIKit
import AVFoundation

class Cal_MesureViewController: UIViewController, AVCaptureDelegate
{
    @IBOutlet weak var full_v: UIView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var take_button: UIButton!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta: UIView!
    
    let avCapture = AVCapture()
    var t_info = take_info()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        set_view()
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
    
    func capture(image: UIImage)
    {
        image_view.contentMode = .scaleAspectFit
        image_view.image = image
    }
    
    @IBAction func take_action(_ sender: Any)
    {
        let cl = Cl_class()
        t_info.target_image = image_view.image!
        t_info.target_rgb = cl.target_rgb_get(image: t_info.target_image!,
                                                  ful_vw: full_v.frame.size.width,
                                                  ful_vh: full_v.frame.size.height)
        let CloutVC = (storyboard?.instantiateViewController(identifier: "Cl_check_"))! as Cl_CheckViewController
        CloutVC.t_info = self.t_info
        self.navigationController?.pushViewController(CloutVC, animated: true)
        avCapture.stopSession()
    }
}
