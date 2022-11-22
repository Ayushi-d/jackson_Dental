//
//  HelpLineVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 29/01/22.
//

import UIKit
import Lottie

class HelpLineVC: UIViewController {

    @IBOutlet weak var main_view: UIView!
    
    @IBOutlet var animated_views: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        main_view.layer.shadowColor = UIColor.black.cgColor
        main_view.layer.shadowOpacity = 0.2
        main_view.layer.shadowOffset = CGSize.zero
        main_view.layer.shadowRadius = 6
        main_view.layer.shadowPath = UIBezierPath(rect: main_view.bounds).cgPath
        //main_view.layer.shouldRasterize = true
        //setupAnimation()
    }
    
    func setupAnimation(){
        
        for i in 0...animated_views.count-1{
            let animationView = AnimationView()
            
            if i == 0{
                animationView.animation = Animation.named("blood")
            }else if i == 1{
                animationView.animation = Animation.named("time")
            }else if i == 2{
                animationView.animation = Animation.named("nosmoking")
            }else if i == 3{
                animationView.animation = Animation.named("nosmoking")
            }else if i == 4 {
                animationView.animation = Animation.named("medicine")
            }
            animationView.frame = animated_views[i].bounds
            animationView.loopMode = .loop
            animationView.contentMode = .scaleToFill
            animationView.play()
            animated_views[i].backgroundColor = UIColor.clear
            animated_views[i].addSubview(animationView)
            
        }
    }
    
    @IBAction func video_Call_tapped(_ sender: Any) {
        
    }
    
    @IBAction func restart_tapped(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
