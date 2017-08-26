//
//  Events.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/19/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var eventButton1: UIButton!
    @IBOutlet weak var eventButton2: UIButton!
    @IBOutlet weak var eventButton3: UIButton!
    @IBOutlet weak var eventButton4: UIButton!

    @IBOutlet weak var endRoundButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var down1Button: UIButton!
    @IBOutlet weak var down2Button: UIButton!
    @IBOutlet weak var down3Button: UIButton!
    @IBOutlet weak var up2Button: UIButton!
    @IBOutlet weak var up3Button: UIButton!
    @IBOutlet weak var up4Button: UIButton!
 
    var listOfEvents: MasterEventList
    let colorProvider = ColorProvider()
    let numberOfRounds: Int = 6
    var currentRoundNumber: Int = 0
    var score: Int = 0
    var currentAnswerKey = RoundList(listOfEvents: [])
    var currentRoundEvents = RoundList(listOfEvents: [])
    var countDownClock: Int = 0
    var timer = Timer()
    var buttonArray: [UIButton] = []
    var urlString: String?
 
    // importing the Plist for the list of events
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionary = try PlistConverter.dictionary(fromFile: "EventData", ofType: "plist")
            let listOfEvents = try EventListUnarchiver.eventList(fromDictionary: dictionary)
            self.listOfEvents = MasterEventList(listOfEvents: listOfEvents)
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        buttonArray = [eventButton1, eventButton2, eventButton3, eventButton4]
        newGame()
        

        
    }
    
    
        // make the buttons look pretty by applying masks to the corners. This had to be done after the buttons were constrained.
    override func viewDidLayoutSubviews() {
        let radii = eventButton1.frame.size.height / 15
        eventButton1.round(corners: [.bottomLeft, .topLeft], radius: radii)
        eventButton2.round(corners: [.bottomLeft, .topLeft], radius: radii)
        eventButton3.round(corners: [.bottomLeft, .topLeft], radius: radii)
        eventButton4.round(corners: [.bottomLeft, .topLeft], radius: radii)
        down1Button.round(corners: [.topRight, .bottomRight], radius: radii)
        down2Button.round(corners: .bottomRight, radius: radii)
        down3Button.round(corners: .bottomRight, radius: radii)
        up2Button.round(corners: .topRight, radius: radii)
        up3Button.round(corners: .topRight, radius: radii)
        up4Button.round(corners: [.topRight,.bottomRight], radius: radii)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var shakeLabel: UILabel!
    
    // respond to shake if the timer is running/shown
    override func becomeFirstResponder() -> Bool {
        return true
    }
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if !timerLabel.isHidden {
            checkAnswers()
        }
    }
    }
    
    
    // set up a new round. Get 4 random events, sort them for an answer key, start timer and update display
    func newRound() {
        currentRoundEvents = listOfEvents.randomRound()
        currentAnswerKey = currentRoundEvents.sortEvents(in: currentRoundEvents)
        currentRoundNumber += 1
        endRoundButton.isHidden = true
        endRoundButton.isEnabled = false
        shakeLabel.text = "Shake to complete"
        updateButtonDisplay()
        
        countDownClock = 60
        timerLabel.isHidden = false
        timerLabel.text = String("1:00")
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        
    }
    // loop through each event and compare with the sorted answer key. Any wrong answer = fail
    // color the buttons so the player knows which events are out of order also enable the buttons to open the web viewer
    func checkAnswers() {
        timer.invalidate()
        timerLabel.isHidden = true
        shakeLabel.text = "Tap an Event for more info"
        var passed: Bool = true
        for i in 0..<currentRoundEvents.listOfEvents.count {
            buttonArray[i].isEnabled = true
            if currentRoundEvents.listOfEvents[i].eventName != currentAnswerKey.listOfEvents[i].eventName {
                passed = false
                endRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
                buttonArray[i].setTitleColor(colorProvider.getUIColor(for: ColorNames.Black), for: .normal)
                buttonArray[i].backgroundColor = colorProvider.getUIColor(for: ColorNames.Red)
            } else {
                buttonArray[i].setTitleColor(colorProvider.getUIColor(for: ColorNames.Black), for: .normal)
                buttonArray[i].backgroundColor = colorProvider.getUIColor(for: ColorNames.Green)
                if i == currentRoundEvents.listOfEvents.count - 1 && passed == true {
                    endRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
                    score += 1
                }
            }
        }
        endRoundButton.isHidden = false
        endRoundButton.isEnabled = true
    }
    
    // helper functions to pass variables to the other view controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "WebSegue" {
            if let toViewController = segue.destination as? WebViewController {
                toViewController.urlString = urlString
            }
        }
        if segue.identifier == "EndGameSegue" {
            if let toViewController = segue.destination as? EndGameView {
                toViewController.scoreText = "\(score)/\(numberOfRounds)"
            }
        }
    }
    
    // in between rounds the event buttons will be active to open the webview
    @IBAction func eventButton(_ sender: UIButton) {
        if let index = buttonArray.index(of: sender) {
        urlString = currentRoundEvents.listOfEvents[index].webAddress
        }
        performSegue(withIdentifier: "WebSegue", sender: self)
    }

    // update the current round event list when the reordering buttons are pressed
    @IBAction func reorderButton(_ sender: UIButton) {
        switch sender {
        case down1Button, up2Button:
            currentRoundEvents.listOfEvents.insert(currentRoundEvents.listOfEvents.remove(at: 0), at: 1)
        case down2Button, up3Button:
            currentRoundEvents.listOfEvents.insert(currentRoundEvents.listOfEvents.remove(at: 1), at: 2)
        case down3Button, up4Button:
            currentRoundEvents.listOfEvents.insert(currentRoundEvents.listOfEvents.remove(at: 2), at: 3)
        default: print("No Button Pressed")
        }
        updateButtonDisplay()
    }
    
    @IBAction func EndRound() {
        if currentRoundNumber < numberOfRounds {
            newRound()
        } else {
            // load end game if all rounds have been played
            performSegue(withIdentifier: "EndGameSegue", sender: self)
        }
        
        
    }
    // this is where the end game view controller gets dismissed to run a new game
    @IBAction func unwindToThisViewController(segue: UIStoryboardSegue) {
        newGame()
    }
    
    // reset the score and round counter then call for a new round to start the next game
    func newGame() {
        currentRoundNumber = 0
        score = 0
        newRound()
    }
    
    
// Helper Functions
    
    // update the display
    func updateButtonDisplay() {
        // reset each button to the current event order, disable the webview and reset button colors.
        for eachButton in buttonArray {
            if let index = buttonArray.index(of: eachButton) {
                eachButton.setTitle(currentRoundEvents.listOfEvents[index].eventName, for: .normal)
                eachButton.isEnabled = false
            }
            eachButton.setTitleColor(colorProvider.getUIColor(for: ColorNames.Teal), for: .normal)
            eachButton.backgroundColor = colorProvider.getUIColor(for: ColorNames.White)
        }
    }
    
    func updateTimer() {
        countDownClock -= 1
            let stringClock = String(format: "%02d", countDownClock)
            timerLabel.text = "0:\(stringClock)"
        // time runs out, stop the clock and fire the answer checker
        if countDownClock == 0 {
            checkAnswers()
        }
    }


}

