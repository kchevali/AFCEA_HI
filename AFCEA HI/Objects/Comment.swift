//
//  Comment.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/27/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct Comment{
    let text : String
    let user: User
    var reactions = Reactions()
    
    func addReaction(_ index: Int){
        reactions.array[index] += 1
    }
}
