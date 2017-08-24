//
//  Events.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/19/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation
import GameKit


protocol SingleEvent {
    var eventName: String { get }
    var eventDate: Date { get }
    var webAddress: String { get }
    var shownBefore: Bool { get set }

}
struct Event: SingleEvent {
    var eventName: String
    var eventDate: Date
    var webAddress: String
    var shownBefore: Bool = false
    
}
protocol EventList {
    var listOfEvents: [Event] { get set }
    
}
struct RoundList: EventList {
    var listOfEvents: [Event]
    
    func sortEvents(in list: RoundList) -> RoundList {
        var copyOfEventList = list.listOfEvents
        var sortedEventList: [Event] = []
        for _ in 1...list.listOfEvents.count {
            let earliest = findEarliest(in: copyOfEventList)
            sortedEventList.append(copyOfEventList[earliest])
            copyOfEventList.remove(at: earliest)
        }
        return RoundList(listOfEvents: sortedEventList)
    }
}

struct MasterEventList: EventList {
    var listOfEvents: [Event]
    var questionsAsked: Int = 0
    
    mutating func randomRound() throws -> RoundList {
        if questionsAsked > self.listOfEvents.count - 4 {
            throw ListError.insufficientQuestions
        }
        var roundEventList: [Event] = []
        while roundEventList.count < 4 {
            var randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: listOfEvents.count)
            while self.listOfEvents[randomIndex].shownBefore == true {
                randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: listOfEvents.count)
            }
            self.listOfEvents[randomIndex].shownBefore = true
            questionsAsked += 1
            roundEventList.append(listOfEvents[randomIndex])
        }
        return RoundList(listOfEvents: roundEventList)
    }
    
}

enum ListError: Error {
    case invalidFile
    case conversionFailure
    case insufficientQuestions
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [[String: Any]] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ListError.invalidFile
        }
        guard let dictionary = NSArray(contentsOfFile: path) as? [[String: Any]] else {
            throw ListError.conversionFailure
        }
        return dictionary
    }
}
class EventListUnarchiver {
    static func eventList(fromDictionary dictionary: [[String: Any]]) throws -> [Event] {
        var listOfEvents: [Event] = []
        
        for value in dictionary {
            let eventDictionary = value
            if let eventName = eventDictionary["name"] as? String, let eventDate = eventDictionary["date"] as? Date, let webAddress = eventDictionary["url"] as? String {
                let event = Event(eventName: eventName, eventDate: eventDate, webAddress: webAddress, shownBefore: false)
                
                
                listOfEvents.append(event)
            }
        }
    return listOfEvents
    }
}

func findEarliest(in list: [Event]) -> Int {
    var earliestIndex = 0
    for i in 1..<list.count {
        if list[i].eventDate < list[earliestIndex].eventDate {
            earliestIndex = i
        }
    }
    return earliestIndex
}


