
import SwiftUI

class UserList{
    var users : [String: User] = [:]
    
    func addUser(id: String, _ user: User){
        users[id] = user
    }
    
    func getUser(_ id: String) -> User?{
        return users[id]
    }
}
