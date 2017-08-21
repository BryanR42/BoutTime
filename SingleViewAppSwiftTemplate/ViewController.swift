//
//  Events.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/19/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var EventButton1: UIButton!
    @IBOutlet weak var EventButton2: UIButton!
    @IBOutlet weak var EventButton3: UIButton!
    @IBOutlet weak var EventButton4: UIButton!

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var Down1Button: UIButton!
    @IBOutlet weak var Down2Button: UIButton!
    @IBOutlet weak var Down3Button: UIButton!
    @IBOutlet weak var Up2Button: UIButton!
    @IBOutlet weak var Up3Button: UIButton!
    @IBOutlet weak var Up4Button: UIButton!
 
    var listOfEvents: EventList
    var score = 0
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
        let radii = EventButton1.frame.size.height / 15
        EventButton1.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton2.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton3.round(corners: [.bottomLeft, .topLeft], radius: radii)
        EventButton4.round(corners: [.bottomLeft, .topLeft], radius: radii)
        Down1Button.round(corners: [.topRight, .bottomRight], radius: radii)
        Down2Button.round(corners: .bottomRight, radius: radii)
        Down3Button.round(corners: .bottomRight, radius: radii)
        Up2Button.round(corners: .topRight, radius: radii)
        Up3Button.round(corners: .topRight, radius: radii)
        Up4Button.round(corners: [.topRight,.bottomRight], radius: radii)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // update the display
    func updateButtonDisplay() {
        let buttons = [EventButton1, EventButton2, EventButton3, EventButton4]
        var count = 0
        for eachButton in buttons {
            eachButton!.setTitle(currentRoundEvents[count].eventName, for: .normal)
            count += 1
        }
    }
    
    func newRound() {
        currentRoundEvents = listOfEvents.randomRound()
        currentAnswerKey = sortEvents(in: currentRoundEvents)
        updateButtonDisplay()
        // start the clock
        countDownClock = 30
        timerLabel.isHidden = false
        timerLabel.text = String(countDownClock) + " Sec"
        timer = Timer.scheduledTimer(timeInterval: 1, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)

    }
    func updateTimer() {
        countDownClock -= 1
        timerLabel.text = String("0:\(countDownClock)")
        if countDownClock == 0 {
           print("End")
        }
    }
    // update the current round event list when the reordering buttons are pressed
    @IBAction func reorderButton(_ sender: UIButton) {
        switch sender {
        case Down1Button, Up2Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 0), at: 1)
        case Down2Button, Up3Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 1), at: 2)
        case Down3Button, Up4Button:
            currentRoundEvents.insert(currentRoundEvents.remove(at: 2), at: 3)
        default: print("No Button Pressed")
        }
        updateButtonDisplay()
    }



}

