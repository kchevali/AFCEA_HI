import SwiftUI

struct EventItem: Identifiable, Equatable, Decodable{
    let id : String
    let title: String
    let tags: [String]
    let date: String
    let description: String
    let image: Image
    let hide = false
    let reactions = Reactions()
    let comments = CommentList()
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case tags = "tags"
        case date = "date"
        case description = "description"
        case image = "imageName"
    }
    
    static func == (lhs: EventItem, rhs: EventItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func emptyEvent() -> EventItem{
        return EventItem(id: "", title: "", tags: [], date: "", description: "", image: Image(systemName: "xmark.octagon"))
    }
    
    func containsTag(_ tag: String) -> Bool{
        return tags.contains(tag)
    }
    
    func addReaction(_ index: Int){
        reactions.array[index] += 1
    }
}
