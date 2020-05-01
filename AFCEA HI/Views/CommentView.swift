//
//  CommentView.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/27/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct CommentView: View{
    
    @ObservedObject var eventContainer: EventItemContainer
    @ObservedObject var showComment: Boolean
    var mainUser: User
    @State var textFieldMessage: String = ""
    
    var body: some View{
        print("Loading Comment View")
        let event = eventContainer.event
        let comments = event.comments.allComments
        
        return NavigationView{
            VStack{
                List{
                    ForEach(comments.indices, id: \.self){ i in
                        self.createComment(comments[i])
                    }
                }
                .padding(30)
                createField()
            }
            .navigationBarTitle("Comments", displayMode: .inline)
            .navigationBarItems(leading: backButton())
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(named:"Dark")
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named:"Light") ?? UIColor.white]
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func createComment(_ comment: Comment) -> some View{
        let user = comment.user
        return HStack{
            VStack(alignment: .leading){
                Text(comment.text)
                Text("User: \(user.firstName) \(user.lastName)")
                .fontSize(12)
            }
            Spacer()
        }
        .padding()
        .wrapRoundRectangle(stroke: Color.blue, fill: Color.blue)
    }
    
    func createField() -> some View{
        HStack{
            TextField("Enter message", text: $textFieldMessage)
            Button(action:{
                //add send code
                let commentResult = CommentResult(eventId: self.eventContainer.event.id, userId: self.mainUser.id, comment: self.textFieldMessage)
                
                if let json = commentResult.getJSON(){
                    Database.send(json, key: "comment")
                    let commentList = self.eventContainer.event.comments
                    commentList.addComment(commentResult.getComment(user: self.mainUser))
                    self.textFieldMessage = ""
                    self.eventContainer.objectWillChange.send()
                }
            }){
                Image(systemName:"paperplane.fill")
                    .imageScale(.large)

            }
            .plainButtonStyle()
        }
        .padding()

    }
    
    func backButton() -> some View{
        Button(action:{
            //add go back code
            self.showComment.set(false)
        }){
            HStack{
                Image(systemName:"chevron.left")
                    .imageScale(.large)
                Text("Back")
            }

        }
        .plainButtonStyle()
        .colorMultiply(Color.blue)
    }
}
