//
//  MusicTuningViewController.swift
//  MusicCalm
//
//  Created by Nithya Appannagaari on 12/3/22.
//

import UIKit
import AVFoundation

class MusicTuningViewController: UIViewController, AVAudioPlayerDelegate {
    
    
    /*
     display genres as artist
     * SZA (R&B)
     * Queen (rock/metal)
     * Symphonies (classical)
     * Adele (pop)
     * Kendrick Lamar (hip hop)
     
     */
    var pauseCount = 0
    @IBOutlet weak var tuningHeartBeat: UIBarButtonItem!
    
   
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
        self.setHeartBeat()
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
                   self.setHeartBeat()
               }
    }
    
    
    func setHeartBeat()
    {
       // heartBeat.title = String(heartBeatNum)
        
        print("setting heart beat")
        
      //  if(heartBeatNums != nil && !heartBeatNums.isEmpty)
   //     {
            let num = heartBeatNums[heartCount]
            
            tuningHeartBeat?.title = String(num)
            
            print("title is \(num)")
            
            /*if(num < 90) {
                state = HeartState.normal
            }
            
            else if(num >= 110 && num < 120)
            {
                state = HeartState.stressed
            }
            
            else if(num >= 130)
            {
                state = HeartState.anxious
            }*/
            
           // heartCount+=1
            
            if(heartCount >= 199){
                timer.invalidate()
            }
      //  }
    }
    
    
    @available(iOS 13.0, *)
    @IBAction func popClicked(_ sender: UIButton) {
        
        if(genreIndex != 3)
            
        {
            genreIndex = 3
            
            player?.stop()
            
            var songIndex = 2
            if (state == HeartState.normal) {
                songIndex = 0
            }
            else if (state == HeartState.stressed) {
                songIndex = 1
            }
            
            let randomSongInd = Int.random(in: 0...3)
            
            let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][randomSongInd], ofType: "mp3")
            
            do {
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else {
                    return
                }
                
                player.play()
            } catch {
                print("something went wrong")
            }
        }
        
        //HomePageViewController().playSong()
    }
    @available(iOS 13.0, *)
    @IBAction func classicalClicked(_ sender: UIButton) {
        if(genreIndex != 2)
        {
            genreIndex = 2
            player?.stop()
            
            var songIndex = 2
            if (state == HeartState.normal) {
                songIndex = 0
            }
            else if (state == HeartState.stressed) {
                songIndex = 1
            }
            
            let randomSongInd = Int.random(in: 0...3)
            
            let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][randomSongInd], ofType: "mp3")
            
            do {
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else {
                    return
                }
                
                player.play()
            } catch {
                print("something went wrong")
            }
        }
        
       
       // HomePageViewController().playSong()
    }
    @available(iOS 13.0, *)
    @IBAction func rockClicked(_ sender: Any) {
        if(genreIndex != 1)
        {
            genreIndex = 1
            player?.stop()
            
            var songIndex = 2
            if (state == HeartState.normal) {
                songIndex = 0
            }
            else if (state == HeartState.stressed) {
                songIndex = 1
            }
            
            let randomSongInd = Int.random(in: 0...3)
            
            let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][randomSongInd], ofType: "mp3")
            
            do {
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else {
                    return
                }
                
                player.play()
            } catch {
                print("something went wrong")
            }
            
        }
      
      //  HomePageViewController().playSong()
    }
    @available(iOS 13.0, *)
    @IBAction func hipClicked(_ sender: UIButton) {
        if(genreIndex != 4)
        {
            genreIndex = 4
            player?.stop()
            
            var songIndex = 2
            if (state == HeartState.normal) {
                songIndex = 0
            }
            else if (state == HeartState.stressed) {
                songIndex = 1
            }
            
            let randomSongInd = Int.random(in: 0...3)
            
            let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][randomSongInd], ofType: "mp3")
            
            do {
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else {
                    return
                }
                
                player.play()
            } catch {
                print("something went wrong")
            }
        }
      //  HomePageViewController().playSong()
    }
    @available(iOS 13.0, *)
    @IBAction func rbClicked(_ sender: Any) {
        if(genreIndex != 0)
        {
            genreIndex = 0
            player?.stop()
            
            var songIndex = 2
            if (state == HeartState.normal) {
                songIndex = 0
            }
            else if (state == HeartState.stressed) {
                songIndex = 1
            }
            
            let randomSongInd = Int.random(in: 0...3)
            
            let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][randomSongInd], ofType: "mp3")
            
            do {
                
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let urlString = urlString else {
                    return
                }
                
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
                player?.delegate = self
                
                guard let player = player else {
                    return
                }
                
                player.play()
            } catch {
                print("something went wrong")
            }
        }
       // HomePageViewController().playSong()
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
            player?.pause()
        }
        
        else
        {
            sender.image = UIImage(systemName: "pause.circle")
            player?.play()
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
