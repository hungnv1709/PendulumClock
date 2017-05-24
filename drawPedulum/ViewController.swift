//
//  ViewController.swift
//  drawPedulum
//
//  Created by Nguyen Van Hung on 5/23/17.
//  Copyright © 2017 Nguyen Van Hung. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var pendulum: UIImageView!
    var clock: UIImageView!
    var hour: UIImageView!
    var minutes: UIImageView!
    var seconds: UIImageView!
    var time: Timer!
    var goc1: CGFloat!
    var goc2: CGFloat!
    var goc3: CGFloat!
    var bird: UIImageView!
    var audio = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goc1 = CGFloat.pi
        goc2 = CGFloat.pi/4
        goc3 = CGFloat.pi/6
        drawPendulum()
        drawClock()
        drawHour()
        drawMinute()
        drawSecond()
        drawBird()
        rotate()
        flyBird()
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(runSecond), userInfo: nil, repeats: true)
        time = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(runMinute), userInfo: nil, repeats: true)
        time = Timer.scheduledTimer(timeInterval: 720, target: self, selector: #selector(runHour), userInfo: nil, repeats: true)
    }

    func drawPendulum() {
        
        pendulum = UIImageView(frame: CGRect (x: 180, y: 300, width: 50, height: 200))
        pendulum.image = UIImage(named : "pendulum.png")
        pendulum.layer.anchorPoint = CGPoint(x:0.5, y:0)
        self.pendulum.transform = CGAffineTransform(rotationAngle: CGFloat.pi/8)
        view.addSubview(pendulum)
    }
    
    func drawClock(){
        clock = UIImageView(frame: CGRect(x:100, y: 100, width: 200, height: 200))
        clock.image = UIImage(named: "clock2.png")
        view.addSubview(clock)
    }
    
    func drawHour(){
        hour = UIImageView(frame: CGRect(x:193, y:175, width:12, height:40))
        hour.image = UIImage(named:"hour")
        hour.layer.anchorPoint = CGPoint(x:0.5, y:0)
        self.hour.transform = CGAffineTransform(rotationAngle :CGFloat.pi/6)
        view.addSubview(hour)
    }
    
    func drawMinute(){
        minutes = UIImageView(frame: CGRect(x:193, y:173, width:12, height:50))
        minutes.image = UIImage(named:"minutes")
        minutes.layer.anchorPoint = CGPoint(x:0.5, y:0)
        self.minutes.transform = CGAffineTransform(rotationAngle :CGFloat(M_PI_4))
        view.addSubview(minutes)
    }
    
    func drawSecond(){
        seconds = UIImageView(frame: CGRect(x:193, y:170, width:12, height:60))
        seconds.image = UIImage(named:"second")
        seconds.layer.anchorPoint = CGPoint(x:0.5, y:0.05)
        self.seconds.transform = CGAffineTransform(rotationAngle :CGFloat.pi)
        view.addSubview(seconds)
    }
    
    func runSecond(){
        goc1 = goc1 + CGFloat.pi/30
        self.seconds.transform = CGAffineTransform(rotationAngle: goc1)
    }
    
    func runMinute(){
        goc2 = goc2 + CGFloat.pi/30
        self.minutes.transform = CGAffineTransform(rotationAngle: goc2)
    }
    
    
    func runHour(){
        goc3 = goc3 + CGFloat.pi/30
        self.hour.transform = CGAffineTransform(rotationAngle: goc3)
    }
    
    func drawBird(){
        bird = UIImageView(frame: CGRect(x:-30, y:20, width: 30, height: 30))
        bird.image = UIImage(named: "bird.png")
        view.addSubview(bird)
    }

    func flyBird(){
        UIView.animate(withDuration: 3, animations: {
            self.bird!.center = CGPoint(x:100 ,y:self.bird!.center.y)
            self.bird!.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
            //self.bird!.alpha = 1
        })
        { _ in
            UIView.animate(withDuration: 3, animations: {
            self.bird!.center = CGPoint(x:-30, y:self.bird!.center.y)
            self.bird!.transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            })
            { _ in
                self.flyBird()
            }
        
        }
    }
    
    func mp3(){
        let path = Bundle.main.path(forResource: "chim", ofType: ".mp3")!
        let url = URL (fileURLWithPath: path)
        audio = try! AVAudioPlayer (contentsOf: url)
        audio.prepareToPlay()
        audio.play()
    }
    
    func rotate ()
    {
        UIView.animate(withDuration: 0.5, animations:
        {
                self.pendulum.transform = CGAffineTransform(rotationAngle: CGFloat.pi/8)
        }) {_ in
            UIView.animate(withDuration: 0.5, animations:
                {
                    self.pendulum.transform = CGAffineTransform(rotationAngle: -(CGFloat.pi/8))
            }){_ in
                self.rotate()
            }
        }
    }
}

