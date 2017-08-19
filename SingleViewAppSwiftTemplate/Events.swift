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

struct Event: SingleEvent {
    let eventName: String
    let eventDate: Date
    let webAddress: URL
}

struct EventList {
    var eventList: [SingleEvent]
    
    
}






