
import SwiftUI

class Tags: ObservableObject{
    @Published var items : [String] = [""]
    var colorDict : [String:Color] = [:]
    var selectedFilter = 0
    
    func add(_ tag: String){
        if colorDict[tag] == nil{
            colorDict[tag] = Color(hue:Double.random(in:0...1),saturation:0.45,brightness:1,opacity:1)
            items.append(tag)
        }
    }
    
    func getTag(_ index: Int) -> String {
        return index >= items.count ? "" : items[index]
    }
    
    func getColor(_ tag: String) -> Color {
        return colorDict[tag] ?? Color.white
    }

}
