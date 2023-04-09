//
//  ViewController.swift
//  eggTimer
//
//  Created by Ururu on 08.04.2023.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    
    let eggTimes = ["soft" : 300, "medium" : 420, "hard" : 720]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        func viewDidLoad() {
            super.viewDidLoad()
            
        }
    }
    
    
    @IBOutlet weak var titleChange: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        
        
        timer.invalidate()
        let hardness = sender.currentTitle!
        let totalTime = eggTimes[hardness]
        progressBar.progress = 0.0
        secondsPassed = 0
        titleChange.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            
            
            if secondsPassed < totalTime! {
                secondsPassed += 1
                let percentageProgress =  Float(secondsPassed) / Float(totalTime!)
                progressBar.progress = percentageProgress
            } else {
                Timer.invalidate()
                titleChange.text = "Done!"
                playSound()
                
                
            }
        }
        
        
        
    }
    
    
    
    
}
