//
//  WelcomeVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit

class WelcomeVC: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    
    @IBOutlet weak var heading_label: UILabel!
    @IBOutlet weak var get_startBtn: UIButton!
    var myMutableString = NSMutableAttributedString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myMutableString = NSMutableAttributedString(string: heading_label.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Poppins-SemiBold", size: 31.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "ButtonColor"), range: NSRange(location:0,length:10))
        
           // set label Attribute
        heading_label.attributedText = myMutableString
        mainVIew.layer.shadowColor = UIColor.black.cgColor
        mainVIew.layer.shadowOpacity = 0.2
        mainVIew.layer.shadowOffset = CGSize.zero
        mainVIew.layer.shadowRadius = 6
        mainVIew.layer.shadowPath = UIBezierPath(rect: mainVIew.bounds).cgPath
        //mainVIew.layer.shouldRasterize = true
    }
    
    
    @IBAction func getStarted_tapped(_ sender: UIButton) {
  
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaveGauzeVC") as! LeaveGauzeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
