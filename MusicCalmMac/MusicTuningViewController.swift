//
//  MusicTuningViewController.swift
//  MusicCalm
//
//  Created by Nithya Appannagaari on 12/3/22.
//

import UIKit

class MusicTuningViewController: UIViewController {
    
    var pauseCount = 0
    @IBOutlet weak var tuningHeartBeat: UIBarButtonItem!

    var heartCount: Int = 0
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
      //  self.setHeartBeat()
    //    self.timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { _ in
         //   self.setHeartBeat()
          //  })

        // Do any additional setup after loading the view.
    }
    
    override func loadView()
    {
        super.loadView()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                    self.setHeartBeat()
                }
    }
    
    
    func setHeartBeat()
    {
       // heartBeat.title = String(heartBeatNum)
        
        print("setting heart beat")
        
        if(heartBeatNums != nil && !heartBeatNums.isEmpty)
        {
            let num = heartBeatNums[heartCount]
            
            tuningHeartBeat?.title = String(num)
            
            print("title is \(num)")
            
            if(num < 90) {
                state = HeartState.normal
            }
            
            else if(num >= 90 && num < 120)
            {
                state = HeartState.stressed
            }
            
            else
            {
                state = HeartState.anxious
            }
            
            heartCount+=1
            
            if(heartCount >= heartBeatNums.count){
                timer.invalidate()
            }
        }
    }
    
    // create method that returns the current heartbeat
    
/*    func setHeartBeat()
    {
        tuningHeartBeat.title = String(heartBeatNum)
        
        if(heartBeatNum < 90) {
            state = HeartState.normal
        }
        
        else if(heartBeatNum >= 90 && heartBeatNum < 120)
        {
            state = HeartState.stressed
        }
        
        else
        {
            state = HeartState.anxious
        }
    }*/
    
    // create method that returns the current heartbeat
    
    @IBAction func openInsta(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: "https://www.instagram.com/music.calm2023/")! as URL, options: [:], completionHandler: nil)
    }
    @available(iOS 13.0, *)
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
