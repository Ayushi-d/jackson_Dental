//
//  Level1VC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit

class Level1VC: UIViewController {

    @IBOutlet weak var level_Lbl: UILabel!
    var comefrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if comefrom == "away"{
            level_Lbl.text = "Level 2 Accomplished!"
        }
        // Do any additional setup after loading the view.
    }
    

    @IBAction func next_tapped(_ sender: Any) {
        
        if comefrom == "away"{
            let helplineVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpLineVC") as! HelpLineVC
            self.navigationController?.pushViewController(helplineVC, animated: true)
        }else{
            let noSignageVC = self.storyboard?.instantiateViewController(withIdentifier: "NoSignageVc") as! NoSignageVc
            self.navigationController?.pushViewController(noSignageVC, animated: true)
        }
        
    }

}
