import SwiftUI

struct EventItem: Identifiable, Equatable, Decodable{
    let id = UUID()
    let title: String
    let tags: [String]
    let date: Date
    let description: String
    let image: Image
    let hide = false
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case tags = "tags"
        case date = "date"
        case description = "description"
        case image = "imageName"
    }
    
    static func == (lhs: EventItem, rhs: EventItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func containsTag(_ tag: String) -> Bool{
        return tags.contains(tag)
    }
}
