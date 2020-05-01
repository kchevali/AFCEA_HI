import SwiftUI

struct CommentReactionResult: Codable {
    let title: String
    let reactionIndex: Int
    let commentId: String
    
    init(reactionIndex: Int, commentId: String){
        self.title = UUID().uuidString
        self.reactionIndex = reactionIndex
        self.commentId = commentId
    }
    
    func addReaction(_ comments: CommentList){
        if let comment = comments.getComment(commentId){
            comment.addReaction(reactionIndex)
        }
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
