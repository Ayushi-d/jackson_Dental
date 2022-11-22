//
//  AwayFromSocketVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 29/01/22.
//

import UIKit
import Lottie

class AwayFromSocketVC: UIViewController {

    @IBOutlet weak var mainVIew: UIView!
    @IBOutlet weak var animated_view: UIView!
    let animation = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        mainVIew.layer.shadowColor = UIColor.black.cgColor
        mainVIew.layer.shadowOpacity = 0.2
        mainVIew.layer.shadowOffset = CGSize.zero
        mainVIew.layer.shadowRadius = 6
        mainVIew.layer.shadowPath = UIBezierPath(rect: mainVIew.bounds).cgPath
        //mainVIew.layer.shouldRasterize = true
       // setupAnimation()
    }
    
    func setupAnimation(){
        animation.animation = Animation.named("lf30_editor_fipkhdfj")
        animation.frame = animated_view.bounds
        animation.loopMode = .loop
        animation.contentMode = .scaleToFill
        animation.play()
        animated_view.backgroundColor = UIColor.clear
        animated_view.addSubview(animation)
    }
    
    @IBAction func next_tapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Level1VC") as! Level1VC
        vc.comefrom = "away"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
