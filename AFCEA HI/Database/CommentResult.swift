import SwiftUI

struct CommentResult: Codable {
    let title: String
    let eventId: String
    let userId: String
    let comment: String
    
    init(eventId: String, userId:String, comment:String){
        self.title = UUID().uuidString
        self.eventId = eventId
        self.userId = userId
        self.comment = comment
    }
    
    func getComment(users: UserList) -> Comment?{
        guard let user = users.getUser(userId)else {
            return nil
        }
        return Comment(text: comment, user: user)
    }
    
    func getComment(user: User) -> Comment{
        return Comment(text: comment, user: user)
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
