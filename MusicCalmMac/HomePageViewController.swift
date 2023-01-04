//
//  HomePageViewController.swift
//  MusicCalm
//
//  Created by Nithya Appannagaari on 11/28/22.
//

import UIKit
import HealthKit
import AVFoundation

enum HeartState {
    case anxious, stressed, normal
}

var state = HeartState.stressed

var heartBeatNums = [Int]()
var player: AVAudioPlayer?


/*
 To-Do for AI Generation of Music
 * play same music on all pages (AVAudioPlayer)
 * use python to train AI models to make music in 5 genres, and 3 levels per genre. 15 sections, 4 songs per section.
 * make sure songs generated flow into each other for different levels
 * categorize each audio file into their respective section
 
 * 5 genres
 * R&B
 * heavy metal
 * classical
 * pop
 * hip hop
 */
@available(iOS 13.0, *)
class HomePageViewController: UIViewController, AVAudioPlayerDelegate{
        
    var pauseCount = 0
        
  var timer = Timer()
    
    var heartCount = 0
    
  var timerHeart = Timer()
    @IBOutlet weak var heartBeat: UIBarButtonItem!
    
    // add 3 more songs to each one
    let rbNorm = ["R&B normal stress 1"] //lahari
    let rockNorm = ["gameMusic3"] //lahari
    let classicalNorm = ["gameMusic3"] //lahari
    let popNorm = ["gameMusic3"] //nithya
    let hipNorm = ["gameMusic3"] //nithya
    
    let rbStress = ["R&B normal stress 1"]
    let rockStress = ["gameMusic3"]
    let classicalStress = ["gameMusic3"]
    let popStress = ["gameMusic3"]
    let hipStress = ["gameMusic3"]
    
    let rbAnxious = ["R&B high stress 1"]
    let rockAnxious = ["gameMusic3"]
    let classicalAnxious = ["gameMusic3"]
    let popAnxious = ["gameMusic3"]
    let hipAnxious = ["gameMusic3"]
    
    var norm: [[String]]?
    var stress: [[String]]?
    var anxious: [[String]]?
    var songs: [[[String]]?]?
    // indices:
    // 0-3 --> normal and classical
    // 4-7 -->
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        norm = [rbNorm, rockNorm, classicalNorm, popNorm, hipNorm]
        
        stress = [rbStress, rockStress, classicalStress, popStress, hipStress]
        
        anxious = [rbAnxious, rockAnxious, classicalAnxious, popAnxious, hipAnxious]
        //           normal           stress          anxious
        songs =  [norm, stress, anxious]// store all 60 audio files in here
       
        let healthStore = HealthKitInterface(self)
        healthStore.readHeartRateData()
        self.setHeartBeat()
        playSong()
        timerHeart = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
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
            
            heartBeat?.title = String(num)
            
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
                timerHeart.invalidate()
            }
        }
    }
    
    func playSong()
    {
        var songIndex = 2 // stress state
        let genreIndex = 0 // 0 --> rnb
        
        if (state == HeartState.normal) {
            songIndex = 0
        }
        else if (state == HeartState.stressed) {
            songIndex = 1
        }
        
        let urlString = Bundle.main.path(forResource: songs?[songIndex]?[genreIndex][0], ofType: "mp3") // 0 = song, replace w rando num from 0-3
        
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
  
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool)
    {
        playSong()
    }
    
    func stopStong()
    {
        player?.stop()

    }
    @IBAction func openInsta(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: "https://www.instagram.com/music.calm2023/")! as URL, options: [:], completionHandler: nil)
    }
    
    @available(iOS 13.0, *)

    @IBAction func pauseOrPlay(_ sender: UIBarButtonItem) {
        pauseCount+=1
        
        if(pauseCount%2 == 1)
        {
            sender.image = UIImage(systemName: "play.circle")
            self.stopStong()
        }
        
        else
        {
            sender.image = UIImage(systemName: "pause.circle")
            self.playSong()
        }
    }
}
