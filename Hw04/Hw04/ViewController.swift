//
//  ViewController.swift
//  Hw04
//
//  Created by B10615013 on 2020/5/13.
//  Copyright © 2020 B10615013. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player = AVPlayer()
    var playerLayer = AVPlayerLayer()
    var movies = [URL]()
    var count = 0
    var playMode = 0; // 0:Cycle(Default) 1:SingleCycle 2:Random
    var playstatus = 1;
    
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var fileName: UILabel!
    @IBOutlet weak var playTime: UILabel!
    @IBOutlet weak var totalTime: UILabel!
    @IBOutlet weak var playTimeSlider: UISlider!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var pause: UIButton!
    @IBOutlet weak var cycleBtn: UIButton!
    @IBOutlet weak var singleCycleBtn: UIButton!
    @IBOutlet weak var randomBtn: UIButton!
    
    func playNewItem(_ url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
        fileName.text = (url as URL).lastPathComponent
        setPauseBtn(1)
        setPlayerProcess()
    }
    
    func formatConversion(time: Float64) -> String {
        let movieLength = Int(time)
        let minutes = Int(movieLength / 60)
        let seconds = Int(movieLength % 60)
        var timesStr = ""
        if minutes < 10 {
            timesStr = "0\(minutes)"
        } else {
            timesStr = "\(minutes)"
        }
        
        if seconds < 10 {
            timesStr += ":0\(seconds)"
        } else {
            timesStr += ":\(seconds)"
        }
        return timesStr
    }
    
    func setPlayerProcess() {
        
        let playerItem = AVPlayerItem(url: movies[count])
        player.replaceCurrentItem(with: playerItem)
        let duration = playerItem.asset.duration
        let totalSeconds = CMTimeGetSeconds(duration)
        let totalSecondsStr = formatConversion(time: totalSeconds)
        totalTime.text = totalSecondsStr
        playTime.text = "00:00"
        playTimeSlider.minimumValue = 0
        playTimeSlider.maximumValue = Float(totalSeconds)
        
        player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 10), queue: DispatchQueue.main, using: {(CMTime) in let currentTime =
            CMTimeGetSeconds(self.player.currentTime())
            if (self.player.currentItem?.status == .readyToPlay) {
                self.playTimeSlider.value = Float(currentTime)
                self.playTime.text = "\(self.formatConversion(time: currentTime))"
            }
        })
        
        player.actionAtItemEnd = .none
        NotificationCenter.default.addObserver(self,
                                               selector:
            #selector(playerItemDidReachEnd(noification:)), name: .AVPlayerItemDidPlayToEndTime, object: player.currentItem)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        movies.append(Bundle.main.url(forResource: "movie1", withExtension: "mov")!)
        movies.append(Bundle.main.url(forResource: "movie2", withExtension: "mov")!)
        movies.append(Bundle.main.url(forResource: "movie3", withExtension: "mov")!)
//        let layer = AVPlayerLayer(player: self.player)
//        view.layer.addSublayer(layer)
        playNewItem(movies[0])
        setPlayerProcess()
        
        playerLayer = AVPlayerLayer(player: player)
        player.externalPlaybackVideoGravity = .resize
        videoView.layer.addSublayer(playerLayer)
    }
    
    @objc func playerItemDidReachEnd(noification: Notification) {
        // 0:Cycle(Default) 1:SingleCycle 2:Random
        switch(playMode) {
        case 0:
            count = count<movies.count-1 ? count+1 : 0
            break;
        case 1:
            //Nothing to do.
            break;
        case 2:
            if(movies.count>1) {
                var rnd = count
                while(rnd == count){
                    rnd = Int.random(in: 0..<movies.count)
                }
                count = rnd
            }
            break;
        default:
            break;
        }
        playNewItem(movies[count])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        player.play()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer.frame = videoView.bounds
    }

    @IBAction func changeCurrentTime(_ sender: UISlider) {
        let seconds = Int64(playTimeSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds, timescale: 1)
        player.seek(to: targetTime)
    }
    
    @IBAction func previous(_ sender: UIButton) {
        // 0:Cycle(Default) 1:SingleCycle 2:Random
        switch(playMode) {
        case 0:
            count = count>0 ? count-1 : movies.count-1
            break;
        case 1:
            //Nothing to do.
            break;
        case 2:
            if(movies.count>1) {
                var rnd = count
                while(rnd == count){
                    rnd = Int.random(in: 0..<movies.count)
                }
                count = rnd
            }
            break;
        default:
            break;
        }
        playNewItem(movies[count])
    }
    
    @IBAction func next(_ sender: UIButton) {
        // 0:Cycle(Default) 1:SingleCycle 2:Random
        switch(playMode) {
        case 0:
            count = count<movies.count-1 ? count+1 : 0
            break;
        case 1:
            count = count<movies.count-1 ? count+1 : 0
            break;
        case 2:
            if(movies.count>1) {
                var rnd = count
                while(rnd == count){
                    rnd = Int.random(in: 0..<movies.count)
                }
                count = rnd
            }
            break;
        default:
            break;
        }
        playNewItem(movies[count])
    }
    
    @IBAction func back5sec(_ sender: UIButton) {
        let seconds = Int64(playTimeSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds-5, timescale: 1)
        player.seek(to: targetTime)
    }
    
    @IBAction func forward5sec(_ sender: UIButton) {
        let seconds = Int64(playTimeSlider.value)
        let targetTime:CMTime = CMTimeMake(value: seconds+5, timescale: 1)
        player.seek(to: targetTime)
    }
    
    
    func setPauseBtn(_ state: Int) {
        if (state == 0) { //PAUSE
            pause.setImage(UIImage(systemName: "play.fill"), for: .normal)
            self.playstatus = 0
        } else { //PLAY
            pause.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            self.playstatus = 1
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if(self.playstatus == 1) {
            player.pause()
            setPauseBtn(0)
        } else {
            player.play()
            setPauseBtn(1)
        }
    }
    
    @IBAction func movieVolume(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    
    @IBAction func setPlayCycle(_ sender: UIButton) {
        playMode = 0
        cycleBtn.tintColor = UIColor(red: 82/255, green: 177/255, blue: 158/255, alpha: 1)
        singleCycleBtn.tintColor = self.view.tintColor
        randomBtn.tintColor = self.view.tintColor
    }
    
    @IBAction func setPlaySingleCycle(_ sender: UIButton) {
        playMode = 1
        cycleBtn.tintColor = self.view.tintColor
        singleCycleBtn.tintColor = UIColor(red: 82/255, green: 177/255, blue: 158/255, alpha: 1)
        randomBtn.tintColor = self.view.tintColor
    }
    
    @IBAction func setPlayRandom(_ sender: UIButton) {
        playMode = 2
        cycleBtn.tintColor = self.view.tintColor
        singleCycleBtn.tintColor = self.view.tintColor
        randomBtn.tintColor = UIColor(red: 82/255, green: 177/255, blue: 158/255, alpha: 1)
    }
}

