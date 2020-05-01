//
//  Result.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/18/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct EventResult: Codable {
    var _id: String
    var title: String
    var slug: String
    var description: String
    var about: String
    var created: [String:String]
    var modified: [String:String]
    var status: String
    var type: String
    var registrationStatus: String
    var googleCalendarUrl: String
    var iCalendarUrl: String
    var userId: String
    var scheduleTbd: Bool
    var start: [String:String]?
    var end: [String:String]?
    var timeZoneId: String?
    var scheduleFormatted: String
    var scheduleStartDateFormatted: String?
    var scheduleStartTimeFormatted: String?
    var locationName: String
    var locationAddress: String
    var latitude: String
    var longitude: String
    var mainImage: String?
    var lowestPriceFormatted: String?
    var highestPriceFormatted: String?
    var siteEventPageUrl: String
    var registrationUrl: String
    
    /*
     case title = "title"
     case tags = "tags"
     case date = "date"
     case description = "description"
     case image = "imageName"
     */
    func getEventItem() -> EventItem{
        return EventItem(id: _id, title: title, tags: [status,type], date: scheduleFormatted, description: description, image: Image("AFCEA-HAWAII-LOGO"))
    }
    
    func getJSON() -> Data?{
        do{
            let jsonEncoder = JSONEncoder()
            return try jsonEncoder.encode(self)
        }catch{
            //JSON error
        }
        return nil
    }
    
    
}
