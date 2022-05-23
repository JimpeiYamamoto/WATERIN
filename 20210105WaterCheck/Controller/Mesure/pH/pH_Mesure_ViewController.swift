//
//  Mesure_ViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/08/22.
//

import UIKit
import AVFoundation

class pH_Mesure_ViewController: UIViewController, AVCaptureDelegate
{
    var t_info = take_info()
    var rgb = RGB()
    var pH_Class = pH_class()
    let avCapture = AVCapture()
    var stillImageOutput: AVCapturePhotoOutput?
    
    @IBOutlet weak var full_v: UIView!
    @IBOutlet weak var image_view: UIImageView!
    @IBOutlet weak var take_button: UIButton!
    @IBOutlet weak var paper_v: UIView!
    @IBOutlet weak var ta_1: UIView!
    @IBOutlet weak var ta_2: UIView!
    @IBOutlet weak var ta_3: UIView!
    @IBOutlet weak var ta_4: UIView!
    
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
        let checkVC = (storyboard?.instantiateViewController(identifier: "check_"))!
                    as CheckPicViewController
        t_info.target_rgb = pH_Class.target_rgb_get(image: image_view.image!,
                                                    full_v_width: full_v.frame.self.width,
                                                    full_v_height: full_v.frame.size.height)
        t_info.target_image = image_view.image!
        checkVC.t_info = self.t_info
        self.navigationController?.pushViewController(checkVC, animated: true)
        avCapture.stopSession()
    }

    
}
