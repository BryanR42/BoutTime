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
 
    var listOfEvents: EventList
    let colorProvider = ColorProvider()
    let numberOfRounds: Int = 6
    var currentRoundNumber: Int = 0
    var score: Int = 0
    var currentAnswerKey: [Event] = []
    var currentRoundEvents: [Event] = []
    var countDownClock: Int = 0
    var timer = Timer()
    
    
    // importing the Plist for the list of events
    required init?(coder aDecoder: NSCoder) {
        do {
            let dictionary = try PlistConverter.dictionary(fromFile: "EventData", ofType: "plist")
            let listOfEvents = try EventListUnarchiver.eventList(fromDictionary: dictionary)
            self.listOfEvents = EventList(listOfEvents: listOfEvents)
        } catch let error {
            fatalError("\(error)")
        }
        super.init(coder: aDecoder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        newRound()
        
        
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
    
    
    // set up a new round. Get 4 random events, start timer and update display
    func newRound() {
        currentRoundEvents = listOfEvents.randomRound()
        currentAnswerKey = sortEvents(in: currentRoundEvents)
        currentRoundNumber += 1
        endRoundButton.isHidden = true
        endRoundButton.isEnabled = false

        updateButtonDisplay()
        
        countDownClock = 30
        timerLabel.isHidden = false
        timerLabel.text = String("1:00")
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)

    }
    // loop through each event and compare with the sorted answer key. Any wrong answer = fail
    // color the buttons so the player knows which events are out of order
    func checkAnswers() {
        timer.invalidate()
        timerLabel.isHidden = true
        let buttons = [eventButton1, eventButton2, eventButton3, eventButton4]
        var passed: Bool = true
        for i in 0..<currentRoundEvents.count {
            if currentRoundEvents[i].eventName != currentAnswerKey[i].eventName {
                passed = false
                endRoundButton.setImage(#imageLiteral(resourceName: "next_round_fail"), for: .normal)
                buttons[i]?.setTitleColor(colorProvider.getUIColor(for: ColorNames.Black), for: .normal)
                buttons[i]?.backgroundColor = colorProvider.getUIColor(for: ColorNames.Red)
            } else {
                buttons[i]?.setTitleColor(colorProvider.getUIColor(for: ColorNames.Black), for: .normal)
                buttons[i]?.backgroundColor = colorProvider.getUIColor(for: ColorNames.Green)
                if i == currentRoundEvents.count - 1 && passed == true {
                    endRoundButton.setImage(#imageLiteral(resourceName: "next_round_success"), for: .normal)
                    score += 1
                }
            }
        }
        endRoundButton.isHidden = false
        endRoundButton.isEnabled = true
    }
    // update the current round event list when the reordering buttons are pressed
    @IBAction func reorderButton(_ sender: UIButton) {
        switch sender {
        case down1Button, up2Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 0), at: 1)
        case down2Button, up3Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 1), at: 2)
        case down3Button, up4Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 2), at: 3)
        default: print("No Button Pressed")
        }
        updateButtonDisplay()
    }
    
    
    @IBAction func EndRound() {
        if currentRoundNumber < numberOfRounds {
            newRound()
        } else {
            // FIXME: End game sequence
        }
        
        
    }
    
// Helper Functions
    
    // update the display
    func updateButtonDisplay() {
        let buttons: [UIButton] = [eventButton1, eventButton2, eventButton3, eventButton4]
        // reset each button to the current event order and reset button colors.
        for eachButton in buttons {
            if let index = buttons.index(of: eachButton) {
                eachButton.setTitle(currentRoundEvents[index].eventName, for: .normal)
            }
            eachButton.setTitleColor(colorProvider.getUIColor(for: ColorNames.Teal), for: .normal)
            eachButton.backgroundColor = colorProvider.getUIColor(for: ColorNames.White)
        }
    }
    
    func updateTimer() {
        countDownClock -= 1
        // need to learn a formatting option?
        if countDownClock < 10 {
            timerLabel.text = "0:0\(countDownClock)"
        } else {
            timerLabel.text = "0:\(countDownClock)"
        }
        // time runs out, stop the clock and fire the answer checker
        if countDownClock == 0 {
            checkAnswers()
        }
    }


}

