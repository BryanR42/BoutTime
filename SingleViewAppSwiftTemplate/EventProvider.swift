//
//  Events.swift
//  BoutTime
//
//  Created by Bryan Richardson on 8/19/17.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import Foundation



protocol SingleEvent {
    var eventName: String { get }
    var eventDate: Date { get }
    var webAddress: URL { get }
}
/*
struct Event: SingleEvent {
    let eventName: String
    let eventDate: Date
    let webAddress: URL
}
*/


enum ListError: Error {
    case invalidFile
    case conversionFailure
}

class PlistConverter {
    static func dictionary(fromFile name: String, ofType type: String) throws -> [String: AnyObject] {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw ListError.invalidFile
        }
        guard let dictionary = NSDictionary(contentsOfFile: path) as? [String: AnyObject] else {
            throw ListError.conversionFailure
        }
        return dictionary
    }
}
class EventListUnarchiver {
    static func eventList(fromDictionary dictionary: [String: AnyObject]) throws -> [SingleEvent] {
        var listOfEvents: [SingleEvent] = []
        
        for (key, value) in dictionary {
            if let eventDictionary = value as? [String: Any], let eventName = eventDictionary["name"] as? String, let eventDate = eventDictionary["date"] as? Date, let webAddress = eventDictionary["url"] {
                let event = SingleEvent(eventName: eventName, eventDate: eventDate, webAddress: webAddress)
                
                }
                listOfEvents.append(event)
            }
    return listOfEvents
    }
}

