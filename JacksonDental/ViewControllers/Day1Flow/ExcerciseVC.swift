//
//  ExcerciseVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 24/01/22.
//

import UIKit

class ExcerciseVC: UIViewController , UNUserNotificationCenterDelegate{
    
    var timerCounting:Bool = false
    var startTime:Date?
    var stopTime:Date?
    var count : Int = 0
    var notifcationCounter : Double = 9

    var scheduledTimer: Timer?
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    @IBOutlet weak var excercise_lbl: UILabel!
    @IBOutlet weak var Img_logo: UIImageView!
    @IBOutlet weak var middleViewCentre_constraint: NSLayoutConstraint!
    @IBOutlet weak var logocentre_constraint: NSLayoutConstraint!
    @IBOutlet weak var middleView: UIView!
    @IBOutlet weak var timerLabel: UILabel!

    //Buttons outlets
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNotificationCenter.delegate = self
        if timerCounting
        {
            startTimer()
        }
        else
        {
            stopTimer()
            if let start = startTime
            {
                if let stop = stopTime
                {
                    let time = calcRestartTime(start: start, stop: stop)
                    let diff = Date().timeIntervalSince(time)
                    setTimeLabel(Int(diff))
                }
            }
        }
    }
    
    func addshadow(){
        middleView.layer.shadowColor = UIColor.black.cgColor
        middleView.layer.shadowOpacity = 0.2
        middleView.layer.shadowOffset = CGSize.zero
        middleView.layer.shadowRadius = 6
        middleView.layer.shadowPath = UIBezierPath(rect: middleView.bounds).cgPath
        //middleView.layer.shouldRasterize = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addshadow()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @IBAction func startTimer_tapped(_ sender: UIButton) {
        if sender.currentTitle == "Restart"{
            setStopTime(date: nil)
            setStartTime(date: nil)
            count = 0
            timerLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
            stopTimer()
            startBtn.backgroundColor = UIColor.init(named: "NewButtonColor")
            startBtn.setTitle("Start Timer", for: .normal)
            startBtn.isUserInteractionEnabled = true
            startBtn.setTitleColor(UIColor.white, for: .normal)
            restartBtn.backgroundColor = UIColor.init(named: "DisableButtonColor")
            restartBtn.setTitle("Restart", for: .normal)
            restartBtn.setTitleColor(UIColor.init(named: "NewButtonColor"), for: .normal)
            excercise_lbl.text = "Let’s do    an Exercise"
            Img_logo.image = UIImage.init(named: "exerciseicon")
        }else{
            if timerCounting
            {
                setStopTime(date: Date())
                stopTimer()
                userNotificationCenter.removeAllPendingNotificationRequests()
                startBtn.setTitle("Start Timer", for: .normal)
            }
            else
            {
                if let stop = stopTime
                {
                    let restartTime = calcRestartTime(start: startTime!, stop: stop)
                    setStopTime(date: nil)
                    setStartTime(date: restartTime)
                }
                else
                {
                    setStartTime(date: Date())
                }
                
                scheduleNotification(timeinterval: notifcationCounter - Double(count-1))
                startTimer()
                startBtn.setTitle("Stop Timer", for: .normal)

            }
        }
       
    }
    
    @IBAction func restart_tapped(_ sender: UIButton) {
        if sender.currentTitle == "Next"{
            let dietVC = self.storyboard?.instantiateViewController(withIdentifier: "DietVC") as! DietVC
            self.navigationController?.pushViewController(dietVC, animated: true)
        }else{
            setStopTime(date: nil)
            setStartTime(date: nil)
            timerLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
            stopTimer()
            count = 0
            startBtn.setTitleColor(UIColor.white, for: .normal)
            startBtn.backgroundColor = UIColor.init(named: "NewButtonColor")
            startBtn.isUserInteractionEnabled = true
            userNotificationCenter.removeAllPendingNotificationRequests()
            startBtn.setTitle("Start Timer", for: .normal)

        }
    }
    
    @IBAction func skip_tapped(_ sender: Any) {
        if scheduledTimer != nil{
            scheduledTimer?.invalidate()
        }
        let dietVC = self.storyboard?.instantiateViewController(withIdentifier: "DietVC") as! DietVC
        userNotificationCenter.removeAllPendingNotificationRequests()
        self.navigationController?.pushViewController(dietVC, animated: true)
    }
    
    
    func scheduleNotification(timeinterval : Double){
        let content = UNMutableNotificationContent()
        content.title = "Jackson Dental"
        content.subtitle = "Exercise Completed"
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeinterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        userNotificationCenter.add(request)
    }
}

//Timer Functionality Extension
extension ExcerciseVC{
    
    func startTimer()
    {
        scheduledTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(refreshValue), userInfo: nil, repeats: true)
        setTimerCounting(true)
    }
    
    @objc func refreshValue()
    {
        if let start = startTime
        {
            let diff = Date().timeIntervalSince(start)
            count = 0
            count = count + Int(diff)
            print("count",count)
            print("diff",diff)
            setTimeLabel(count)
            if count > 900{
                print("naviagte")
                
                userNotificationCenter.removeAllPendingNotificationRequests()
                scheduledTimer?.invalidate()
                timerLabel.text = makeTimeString(hour: 0, min: 0, sec: 10)
                Img_logo.image = UIImage.init(named: "check-circle")
                excercise_lbl.text = "Completed!"
                UIView.animate(withDuration: 0.8,
                               delay: 0.3,
                               options: [],
                               animations: { [weak self] in
                                self?.view.layoutIfNeeded()
                  }, completion: nil)
                startBtn.backgroundColor = UIColor.init(named: "DisableButtonColor")
                restartBtn.backgroundColor = UIColor.init(named: "NewButtonColor")
                startBtn.setTitle("Restart", for: .normal)
                startBtn.setTitleColor(UIColor.init(named: "NewButtonColor"), for: .normal)
                restartBtn.setTitleColor(UIColor.white, for: .normal)
                restartBtn.setTitle("Next", for: .normal)
                startBtn.isUserInteractionEnabled = true
            }
        }
        else
        {
            stopTimer()
            setTimeLabel(0)
        }
    }
        
    func setTimeLabel(_ val: Int)
    {
        let time = secondsToHoursMinutesSeconds(val)
        let timeString = makeTimeString(hour: time.0, min: time.1, sec: time.2)
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(_ ms: Int) -> (Int, Int, Int)
    {
        let hour = ms / 3600
        let min = (ms % 3600) / 60
        let sec = (ms % 3600) % 60
        return (hour, min, sec)
    }
    
    func makeTimeString(hour: Int, min: Int, sec: Int) -> String
    {
        var timeString = ""
        timeString += String(format: "%02d", hour)
        timeString += ":"
        timeString += String(format: "%02d", min)
        timeString += ":"
        timeString += String(format: "%02d", sec)
        return timeString
    }
    
    func stopTimer()
    {
        if scheduledTimer != nil
        {
            scheduledTimer?.invalidate()
        }
        setTimerCounting(false)
    }
    
    func setStartTime(date: Date?)
    {
        startTime = date
    }
    
    func setStopTime(date: Date?)
    {
        stopTime = date
    }
    
    func setTimerCounting(_ val: Bool)
    {
        timerCounting = val
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date
    {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
}
