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
    
    // update the display
    func updateButtonDisplay() {
        let buttons = [eventButton1, eventButton2, eventButton3, eventButton4]
        var count = 0
        for eachButton in buttons {
            guard let thisButton = eachButton else {
                break
            }
            thisButton.setTitle(currentRoundEvents[count].eventName, for: .normal)
            thisButton.setTitleColor(colorProvider.getUIColor(for: ColorNames.Teal), for: .normal)
            thisButton.backgroundColor = colorProvider.getUIColor(for: ColorNames.White)
            count += 1
            }
        }
    
    
    func newRound() {
        currentRoundEvents = listOfEvents.randomRound()
        currentAnswerKey = sortEvents(in: currentRoundEvents)
        currentRoundNumber += 1
        endRoundButton.isHidden = true
        endRoundButton.isEnabled = false

        updateButtonDisplay()
        // start the clock
        countDownClock = 30
        timerLabel.isHidden = false
        timerLabel.text = String("1:00")
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)

    }
    func checkAnswers() {
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
    func updateTimer() {
        countDownClock -= 1
        if countDownClock < 10 {
            timerLabel.text = "0:0\(countDownClock)"
        } else {
            timerLabel.text = "0:\(countDownClock)"
        }
        if countDownClock == 0 {
            timerLabel.isHidden = true
            checkAnswers()
        }
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



}

