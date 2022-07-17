//
//  DayCompleteVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit

class DayCompleteVC: UIViewController {
    
    @IBOutlet weak var middleView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        middleView.layer.cornerRadius = 10
        middleView.layer.shadowColor = UIColor.black.cgColor
        middleView.layer.shadowOpacity = 0.2
        middleView.layer.shadowOffset = CGSize.zero
        middleView.layer.shadowRadius = 10
        middleView.layer.shadowPath = UIBezierPath(rect: middleView.bounds).cgPath
        //middleView.layer.shouldRasterize = true
        
    }
    
    @IBAction func close_tapped(_ sender: Any) {
       // exit(0)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Welcome2VC") as! Welcome2VC
        self.navigationController?.pushViewController(vc, animated: true)
    }
   
}
