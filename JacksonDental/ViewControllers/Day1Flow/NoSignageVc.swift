//
//  NoSignageVc.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit
import Lottie

class NoSignageVc: UIViewController {

    @IBOutlet weak var middleView: UIView!
    
    //PointsView Outlets
    @IBOutlet weak var first_View: UIView!
    @IBOutlet weak var second_View: UIView!
    @IBOutlet weak var third_view: UIView!
    
    @IBOutlet weak var animated_view: UIView!
    
    @IBOutlet weak var firstViewCentre_Constraint: NSLayoutConstraint!
    
    let alertAnimation = AnimationView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        middleView.layer.shadowColor = UIColor.black.cgColor
        middleView.layer.shadowOpacity = 0.2
        middleView.layer.shadowOffset = CGSize.zero
        middleView.layer.shadowRadius = 6
        middleView.layer.shadowPath = UIBezierPath(rect: middleView.bounds).cgPath
        //middleView.layer.shouldRasterize = true
        //setupAnimation()
    }
    
    func setupAnimation(){
        alertAnimation.animation = Animation.named("lf30_editor_fqoqhonn")
        alertAnimation.frame = animated_view.bounds
        alertAnimation.loopMode = .loop
        alertAnimation.contentMode = .scaleToFill
        alertAnimation.play()
        animated_view.backgroundColor = UIColor.clear
        animated_view.addSubview(alertAnimation)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstViewCentre_Constraint.constant += view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        firstViewCentre_Constraint.constant = 0

        UIView.animate(withDuration: 0.8,
                       delay: 0.3,
                       options: [],
                       animations: { [weak self] in
                        self?.view.layoutIfNeeded()
          }, completion: nil)

    }
    
    @IBAction func next_tapped(_ sender: Any) {
        let excerciseVC = self.storyboard?.instantiateViewController(withIdentifier: "ExcerciseVC") as! ExcerciseVC
        self.navigationController?.pushViewController(excerciseVC, animated: true)
    }

}
