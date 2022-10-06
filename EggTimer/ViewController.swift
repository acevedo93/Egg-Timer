

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var softTime:Int = 5
    var mediumTime:Int = 7
    var hardTime:Int = 12
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player : AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func hardnessSelected(_ sender: UIButton) {
        titleLabel.text = sender.currentTitle
        timer.invalidate()
        progressBar.progress = 0.0
        secondsPassed = 0
        totalTime = checkHardnessTime(hardness: sender.currentTitle!)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer () {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let calculate = Float(secondsPassed) / Float(totalTime)
            self.progressBar.progress =  calculate
        } else {
            timer.invalidate()
            self.titleLabel.text = "Done"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try! AVAudioPlayer(contentsOf: url!)
            player.setVolume(0.2, fadeDuration: 0.2)
            player.play()
        }
    }
    
    
    func checkHardnessTime (hardness:String) -> Int {
        let eggTimes: [String : Int] = [
            "Soft": softTime,
            "Medium": mediumTime,
            "Hard": hardTime
        ]
        
        if let time = eggTimes[hardness] {
            return time
        } else {
            return 0
        }
    }
}
