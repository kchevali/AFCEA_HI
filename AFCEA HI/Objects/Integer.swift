
import SwiftUI

class Integer: ObservableObject{
    @Published var value : Int
        
    init(_ value: Int) {
        self.value = value
    }
    
    func set(_ value: Int){
        self.value = value
    }
}
