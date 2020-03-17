
import SwiftUI

struct Test:  Decodable{
    let title: String
    let image:Image
    let date:Date
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case image = "imageName"
        case date = "date"
    }
}

