//
//  LeaveGauzeVC.swift
//  JacksonDental
//
//  Created by Agyapal Dhiman on 26/01/22.
//

import UIKit
import Lottie

class LeaveGauzeVC: UIViewController, UNUserNotificationCenterDelegate {
    
    @IBOutlet weak var leaveView: UIView!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var animated_View: UIView!
    
    //Buttons outlets
    @IBOutlet weak var startBtn: UIButton!
    let userNotificationCenter = UNUserNotificationCenter.current()

    var timerCounting:Bool = false
    var startTime:Date?
    var stopTime:Date?
    var count : Int = 0
    let timerAnimation = AnimationView()
    var notifcationCounter : Double = 9
    
    var scheduledTimer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userNotificationCenter.delegate = self
        leaveView.layer.shadowColor = UIColor.black.cgColor
        leaveView.layer.shadowOpacity = 0.2
        leaveView.layer.shadowOffset = CGSize.zero
        leaveView.layer.shadowRadius = 6
        leaveView.layer.shadowPath = UIBezierPath(rect: leaveView.bounds).cgPath
       // leaveView.layer.shouldRasterize = true
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
        //setupAnimation()
    }
    
    func setupAnimation(){
        timerAnimation.animation = Animation.named("lf30_editor_phnbhimo")
        timerAnimation.frame = animated_View.bounds
        timerAnimation.loopMode = .loop
        timerAnimation.contentMode = .scaleToFill
        timerAnimation.play()
        animated_View.backgroundColor = UIColor.clear
        animated_View.addSubview(timerAnimation)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
    
    @IBAction func startTimer_tapped(_ sender: UIButton) {
        if timerCounting
        {
            setStopTime(date: Date())
            stopTimer()
            userNotificationCenter.removeAllPendingNotificationRequests()
            startBtn.setTitle("Start Timer", for: .normal)
            startBtn.setTitleColor(UIColor.white, for: .normal)

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
            //scheduleNotification(timeinterval: notifcationCounter - Double(count-1))
            startTimer()
            startBtn.setTitle("Stop Timer", for: .normal)
            startBtn.setTitleColor(UIColor.white, for: .normal)
        }
    }
    
    func calcRestartTime(start: Date, stop: Date) -> Date
    {
        let diff = start.timeIntervalSince(stop)
        return Date().addingTimeInterval(diff)
    }
    
    @IBAction func restart_tapped(_ sender: UIButton) {
        setStopTime(date: nil)
        setStartTime(date: nil)
        count = 0
        timerLabel.text = makeTimeString(hour: 0, min: 0, sec: 0)
        stopTimer()
        startBtn.backgroundColor = UIColor.init(named: "NewButtonColor")
        startBtn.isUserInteractionEnabled = true
        startBtn.setTitle("Start Timer", for: .normal)
        userNotificationCenter.removeAllPendingNotificationRequests()
    }
    
    @IBAction func skip_tapped(_ sender: Any) {
        if scheduledTimer != nil{
            scheduledTimer?.invalidate()
        }
        let level1VC = self.storyboard?.instantiateViewController(withIdentifier: "Level1VC") as! Level1VC
        userNotificationCenter.removeAllPendingNotificationRequests()
        self.navigationController?.pushViewController(level1VC, animated: true)
    }
    
    
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
            let time = secondsToHoursMinutesSeconds(count)
            setTimeLabel(count)
            if count > 3600 {
                print("naviagte")
                scheduledTimer?.invalidate()
                scheduleNotification()
                let level1VC = self.storyboard?.instantiateViewController(withIdentifier: "Level1VC") as! Level1VC
                userNotificationCenter.removeAllPendingNotificationRequests()
                self.navigationController?.pushViewController(level1VC, animated: true)
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
    
    func scheduleNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Jackson Dental"
        content.subtitle = "Level 1 Completed"
        content.sound = UNNotificationSound.default
       // let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeinterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
        userNotificationCenter.add(request)
    }
}
