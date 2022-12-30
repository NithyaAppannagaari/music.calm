//
//  HomePageViewController.swift
//  MusicCalm
//
//  Created by Nithya Appannagaari on 11/28/22.
//

import UIKit
import HealthKit

var prevHeartBeat = 98

class HomePageViewController: UIViewController {
    
    var pauseCount = 0
    
    @IBOutlet weak var heartBeat: UIBarButtonItem!
    
    var state = HeartState.stressed
    
  
    
    var prevState = HeartState.stressed
    
    enum HeartState {
        case anxious, stressed, normal
    }
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.setHeartBeat()
            })

        // Do any additional setup after loading the view.
    }
    
    // create method that returns the current heartbeat
    
    func setHeartBeat()
    {
        var num = 0
        // default - 70 bpm
        
        // states:
        // anxious --> >120
        // stress --> 90-120
        // normal --> <90
        
        if (state == prevState) {
            num = Int.random(in: prevHeartBeat-5...prevHeartBeat+5)
            if (state == HeartState.normal) {
                if (num >= 90) {
                    prevState = state
                    state = HeartState.stressed
                }
            }
            else if (state == HeartState.stressed) {
                if (num <= 90) {
                    prevState = state
                    state = HeartState.normal
                }
                else if (num >= 120) {
                    prevState = state
                    state = HeartState.anxious
                }
            }
            else {
                if (num <= 120) {
                    prevState = state
                    state = HeartState.stressed
                }
                else if (num >= 250) {
                    num = 240
                }
            }
        }
        
        else {
            if (state == HeartState.anxious) {
                num = Int.random(in: 120...250)
                prevState = HeartState.anxious
            }
            else if (state == HeartState.stressed) {
                num = Int.random(in: 90...120)
                prevState = HeartState.stressed
            }
            else {
                num = Int.random(in: 50...90)
                prevState = HeartState.normal
            }
        }
        
        prevHeartBeat = num
        heartBeat.title = String(num)
    }
  
    @IBAction func openInsta(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: "https://www.instagram.com/music.calm2023/")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func pauseOrPlay(_ sender: UIBarButtonItem) {
        pauseCount+=1
        
        if(pauseCount%2 == 1)
        {
            sender.image = UIImage(systemName: "play.circle")
        }
        
        else
        {
            sender.image = UIImage(systemName: "pause.circle")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
