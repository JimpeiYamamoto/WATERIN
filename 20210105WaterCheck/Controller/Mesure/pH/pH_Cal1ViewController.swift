//
//  MesureViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2021/01/05.
//

import UIKit
import AVFoundation
import Charts

class pH_Cal1ViewController: UIViewController, AVCaptureDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var takeButton: UIButton!
    @IBOutlet weak var full_v: UIView!
    
    @IBOutlet weak var v_0_0: UIView!
    @IBOutlet weak var v_0_1: UIView!
    @IBOutlet weak var v_0_2: UIView!
    @IBOutlet weak var v_0_3: UIView!
    @IBOutlet weak var v_0_4: UIView!
    
    @IBOutlet weak var v_1_0: UIView!
    @IBOutlet weak var v_1_1: UIView!
    @IBOutlet weak var v_1_2: UIView!
    @IBOutlet weak var v_1_3: UIView!
    @IBOutlet weak var v_1_4: UIView!
    
    @IBOutlet weak var v_2_0: UIView!
    @IBOutlet weak var v_2_1: UIView!
    @IBOutlet weak var v_2_2: UIView!
    @IBOutlet weak var v_2_3: UIView!
    @IBOutlet weak var v_2_4: UIView!
    
    @IBOutlet weak var v_3_0: UIView!
    @IBOutlet weak var v_3_1: UIView!
    @IBOutlet weak var v_3_2: UIView!
    @IBOutlet weak var v_3_3: UIView!
    @IBOutlet weak var v_3_4: UIView!
    
    @IBOutlet weak var v_4_0: UIView!
    @IBOutlet weak var v_4_1: UIView!
    @IBOutlet weak var v_4_2: UIView!
    @IBOutlet weak var v_4_3: UIView!
    @IBOutlet weak var v_4_4: UIView!
    
    @IBOutlet weak var v_5_0: UIView!
    @IBOutlet weak var v_5_1: UIView!
    @IBOutlet weak var v_5_2: UIView!
    @IBOutlet weak var v_5_3: UIView!
    @IBOutlet weak var v_5_4: UIView!
    
    @IBOutlet weak var v_6_0: UIView!
    @IBOutlet weak var v_6_1: UIView!
    @IBOutlet weak var v_6_2: UIView!
    @IBOutlet weak var v_6_3: UIView!
    @IBOutlet weak var v_6_4: UIView!
    
    @IBOutlet weak var v_7_0: UIView!
    @IBOutlet weak var v_7_1: UIView!
    @IBOutlet weak var v_7_2: UIView!
    @IBOutlet weak var v_7_3: UIView!
    @IBOutlet weak var v_7_4: UIView!
    
    @IBOutlet weak var l_7: UILabel!
    @IBOutlet weak var l_6: UILabel!
    @IBOutlet weak var l_5: UILabel!
    @IBOutlet weak var l_4: UILabel!
    @IBOutlet weak var l_3: UILabel!
    @IBOutlet weak var l_2: UILabel!
    @IBOutlet weak var l_1: UILabel!
    @IBOutlet weak var l_0: UILabel!
    
    var rgb = RGB()
    var pH = pH_class()
    var t_info = take_info()
    let avCapture = AVCapture()

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
    
    func capture(image: UIImage)
    {
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
    }
    
    @IBAction func takeAction(_ sender: Any)
    {
        let ref_rgb = pH.ref_rgb_get(image: imageView.image!,
                                     full_v_width: full_v.frame.size.width,
                                     full_v_height: full_v.frame.size.height)
        if (ref_rgb[1][0][v.B] >= 80.0)
        {
            show_alert(title: "【注意】強い光が当たっています",
                       msg: "正しい結果が得られない恐れがあります",
                       yes_msg: "続ける", no_msg: "やり直す")
        }
        else
        {
            move_next_view()
        }
    }
    
    func move_next_view()
    {
        let Cal2VC = (storyboard?.instantiateViewController(identifier: "cal2"))! as pH_Cal2ViewController
        t_info.ref1_image = imageView.image
        t_info.ref1_rgb = pH.ref_rgb_get(image: imageView.image!,
                                         full_v_width: full_v.frame.size.width,
                                         full_v_height: full_v.frame.size.height)
        Cal2VC.t_info = self.t_info
        self.avCapture.delegate = nil
        self.avCapture.stopSession()
        self.navigationController?.pushViewController(Cal2VC, animated: true)
    }
    
    func show_alert(title:String, msg:String, yes_msg: String, no_msg:String)
    {
        
        let alertSheet = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.actionSheet)
        let action1 = UIAlertAction(title: yes_msg, style: UIAlertAction.Style.default, handler:
        { [self] (action: UIAlertAction!) in
            move_next_view()
        })
        let action2 = UIAlertAction(title: no_msg, style: UIAlertAction.Style.destructive, handler:
        { [] (action: UIAlertAction!) in
        })
        alertSheet.addAction(action1)
        alertSheet.addAction(action2)
        self.present(alertSheet, animated: true, completion: nil)
    }
    
}
