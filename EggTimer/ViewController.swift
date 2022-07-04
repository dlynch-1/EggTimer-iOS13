//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    let eggTimes = [
        "Soft":3, "Medium":4, "Hard":7
    ]
    
    var secondsRemaining = 0
    var timer = Timer()
    var player: AVAudioPlayer!
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var eggStatus: UILabel!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        timer.invalidate()
        progressBar.progress = 0.0
        let hardness = sender.currentTitle!
        eggStatus.text = hardness
//        print(eggTimes[hardness]!)
        secondsRemaining = eggTimes[hardness]!
        let progbarPct = 1.0 / Float(secondsRemaining)
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    print ("\(self.secondsRemaining) seconds")
                    self.secondsRemaining -= 1
                    self.progressBar.progress += progbarPct
                } else {
                    self.timer.invalidate()
                    self.eggStatus.text = "Done!"
                    self.playSound(theNote: "alarm_sound")
                }
            }
    }
    
    func playSound(theNote: String) {
        let url = Bundle.main.url(forResource: theNote, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
