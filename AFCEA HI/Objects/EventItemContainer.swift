//
//  EventItemWrapper.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/27/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

class EventItemContainer: ObservableObject{
    @Published var event = EventItem.emptyEvent()
    
    func setEvent(_ event: EventItem){
        self.event = event
    }
}
