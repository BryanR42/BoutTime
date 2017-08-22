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


struct EventList {
    var listOfEvents: [Event]
    
    mutating func randomRound() -> [Event] {
        var tempListOfEvents = listOfEvents
        var roundEventList: [Event] = []
        while roundEventList.count < 4 {
            var randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: tempListOfEvents.count)
            while self.listOfEvents[randomIndex].shownBefore == true {
                randomIndex = GKRandomSource.sharedRandom().nextInt(upperBound: tempListOfEvents.count)
            }
            self.listOfEvents[randomIndex].shownBefore = true
            roundEventList.append(tempListOfEvents[randomIndex])
        }
        return roundEventList
    }
    
}

enum ListError: Error {
    case invalidFile
    case conversionFailure
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

func sortEvents(in list: [Event]) -> [Event] {
    var copyOfEventList = list
    var sortedEventList: [Event] = []
    for _ in 1...list.count {
        let earliest = findEarliest(in: copyOfEventList)
        sortedEventList.append(copyOfEventList[earliest])
        copyOfEventList.remove(at: earliest)
    }
    return sortedEventList
}
