//
//  DietVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit
import Lottie

class DietVC: UIViewController {

    let drinkAnimation = AnimationView()
    
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var middleView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        middleView.layer.shadowColor = UIColor.black.cgColor
        middleView.layer.shadowOpacity = 0.2
        middleView.layer.shadowOffset = CGSize.zero
        middleView.layer.shadowRadius = 6
        middleView.layer.shadowPath = UIBezierPath(rect: middleView.bounds).cgPath
       // middleView.layer.shouldRasterize = true
        
        //setupAnimation()
    }
    
    func setupAnimation(){
        drinkAnimation.animation = Animation.named("69615-4-chills")
        drinkAnimation.frame = animationView.bounds
        drinkAnimation.loopMode = .loop
        drinkAnimation.contentMode = .scaleToFill
        drinkAnimation.play()
        animationView.backgroundColor = UIColor.clear
        animationView.addSubview(drinkAnimation)
    }
    
    @IBAction func next_tapped(_ sender: Any) {
        let dayCompleteVC = self.storyboard?.instantiateViewController(withIdentifier: "DayCompleteVC") as! DayCompleteVC
        self.navigationController?.pushViewController(dayCompleteVC, animated: true)
    }
}
