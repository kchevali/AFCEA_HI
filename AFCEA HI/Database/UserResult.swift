import SwiftUI

struct UserResult: Codable {
    let title: String
    let firstName: String
    let lastName: String
    let isAdmin: Bool
    
    init(firstName: String,lastName:String){
        self.title = UUID().uuidString
        self.firstName = firstName
        self.lastName = lastName
        self.isAdmin = false
    }
    
    func getUser() -> User{
        return User(id: title, firstName: firstName, lastName: lastName, isAdmin: isAdmin)
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
