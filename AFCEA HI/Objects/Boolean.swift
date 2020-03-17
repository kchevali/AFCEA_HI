
import SwiftUI

class Boolean: ObservableObject{
    @Published var value : Bool
        
    init(_ value: Bool) {
        self.value = value
    }
    
    func set(_ value: Bool){
        self.value = value
    }
}
