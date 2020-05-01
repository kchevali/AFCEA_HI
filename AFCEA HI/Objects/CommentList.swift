
import SwiftUI

class CommentList:ObservableObject{
    var comments : [String: Comment] = [:]
    @Published var allComments : [Comment] = []
    
    func addComment(id: String, _ comment: Comment){
        comments[id] = comment
        allComments.append(comment)
    }
    
    func addComment(_ comment: Comment){
        let id = UUID().uuidString
        comments[id] = comment
        allComments.append(comment)
    }
    
    func getComment(_ id: String) -> Comment?{
        return comments[id]
    }
}
