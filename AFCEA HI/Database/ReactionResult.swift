import SwiftUI

struct ReactionResult: Codable {
    let title: String
    let reactionIndex: Int
    let eventId: String
    
    init(reactionIndex: Int, eventId: String){
        title = UUID().uuidString
        self.reactionIndex = reactionIndex
        self.eventId = eventId
    }
    
    func addReaction(_ events: Events){
        if let event = events.getItem(eventId){
            event.addReaction(reactionIndex)
        }else{
            print("Could not find event for reaction:",eventId)
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
