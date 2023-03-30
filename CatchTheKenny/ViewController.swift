//
//  ViewController.swift
//  CatchTheKenny
//
//  Created by Can Kanbur on 30.03.2023.
//

import UIKit

class ViewController: UIViewController {
    var score = 0
    var timer = Timer()
    var hideTimer = Timer()
    var counter = 0
    var higsScrore = 0
    var kennyArray : [UIImageView] = []
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var highScoreLabel: UILabel!
    @IBOutlet var scoreLabel: UILabel!

    @IBOutlet var kenny9: UIImageView!
    @IBOutlet var kenny8: UIImageView!
    @IBOutlet var kenny7: UIImageView!
    @IBOutlet var kenny6: UIImageView!
    @IBOutlet var kenny5: UIImageView!
    @IBOutlet var kenny4: UIImageView!
    @IBOutlet var kenny3: UIImageView!

    @IBOutlet var kenny2: UIImageView!
    @IBOutlet var kenny1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scoreLabel.text = "Score: \(score)"
        counter = 10
        
        let storedHighScore = UserDefaults.standard.object(forKey: "highscore")
        
        if let highscore = storedHighScore as? Int {
            self.higsScrore = highscore
            highScoreLabel.text = "HighScore: \(self.higsScrore)"
        }else{
            self.higsScrore = 0
            highScoreLabel.text = "HighScore: \(self.higsScrore)"
        }
        
        
        
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true

        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tabbedKenny))

        kenny1.addGestureRecognizer(gestureRecognizer1)
        kenny2.addGestureRecognizer(gestureRecognizer2)
        kenny3.addGestureRecognizer(gestureRecognizer3)
        kenny4.addGestureRecognizer(gestureRecognizer4)
        kenny5.addGestureRecognizer(gestureRecognizer5)
        kenny6.addGestureRecognizer(gestureRecognizer6)
        kenny7.addGestureRecognizer(gestureRecognizer7)
        kenny8.addGestureRecognizer(gestureRecognizer8)
        kenny9.addGestureRecognizer(gestureRecognizer9)

        kennyArray = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]

        timeLabel.text = "\(counter)"

        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideKenny), userInfo: nil, repeats: true)
        
        hideKenny()
    }

    @objc func tabbedKenny() {
        score += 1
        scoreLabel.text = "Score: \(score)"
    }

    @objc func countdown() {
        counter -= 1
        timeLabel.text = "\(counter)"
        
        if self.score > self.higsScrore {
            self.higsScrore = self.score
            highScoreLabel.text = "HighScore: \(self.higsScrore)"
            UserDefaults.standard.set(self.higsScrore, forKey: "highscore")
        }

        if counter == 0 {
            timer.invalidate()
            hideTimer.invalidate()

            let alert = UIAlertController(title: "Time's Up", message: "Do you want to olay again?", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { _ in
                self.score = 0
                self.scoreLabel.text = "Score: \(self.score)"
                self.counter = 10
                self.timeLabel.text = "\(self.counter)"
                
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideKenny), userInfo: nil, repeats: true)
            }
            alert.addAction(okButton)
            alert.addAction(replayButton)
            present(alert, animated: true, completion: nil)
        }
    }
    
   @objc func hideKenny(){
        for item in kennyArray {
            item.isHidden = true
        }
        let randomNumber = Int(arc4random_uniform(UInt32(kennyArray.count)))
        let randomKenny = kennyArray[randomNumber]
        randomKenny.isHidden = false
        
    }
}
