//
//  Welcome2VC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 29/01/22.
//

import UIKit

class Welcome2VC: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    
    @IBOutlet weak var heading_lbl: UILabel!
    var myMutableString = NSMutableAttributedString()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myMutableString = NSMutableAttributedString(string: heading_lbl.text!, attributes: [NSAttributedString.Key.font:UIFont(name: "Poppins-SemiBold", size: 31.0)!])
        myMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(named: "ButtonColor"), range: NSRange(location:0,length:10))
        heading_lbl.attributedText = myMutableString
        
        mainVIew.layer.shadowColor = UIColor.black.cgColor
        mainVIew.layer.shadowOpacity = 0.2
        mainVIew.layer.shadowOffset = CGSize.zero
        mainVIew.layer.shadowRadius = 6
        mainVIew.layer.shadowPath = UIBezierPath(rect: mainVIew.bounds).cgPath
       // mainVIew.layer.shouldRasterize = true
    }
   
    
    @IBAction func next_tapped(_ sender: UIButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RinseMouthVC") as! RinseMouthVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    

}
