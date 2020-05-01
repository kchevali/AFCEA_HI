//
//  Response.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/18/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct Response: Codable {
    var events: [EventResult]
    var users: [UserResult]
    var reactions: [ReactionResult]
    var comments: [CommentResult]
    var commentReactions: [CommentReactionResult]
    
    func updateEvents(_ eventList: Events){
        let userList = UserList()
        let commentList = CommentList()
        
        for event in events{
            eventList.addItem(event.getEventItem())
        }
        for reaction in reactions{
            reaction.addReaction(eventList)
        }
        for user in users{
            userList.addUser(id: user.title, user.getUser())
        }
        for comment in comments{
            if let commentObject = comment.getComment(users: userList){
                commentList.addComment(id: comment.title,commentObject )

            }
        }
        for commentReaction in commentReactions{
            commentReaction.addReaction(commentList)
        }
    }
}
