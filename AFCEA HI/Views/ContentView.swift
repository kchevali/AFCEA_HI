import SwiftUI

/*
 TODO
 Continuing Education
 Member Directory
 One-touch event registration
 Community Calendar
 Corporate directory
 Job Board
 Focused Mentoring
 */


struct ContentView: View {
    @ObservedObject var showSort = Boolean(false)
    @ObservedObject var showComment = Boolean(false)
    var commentEvent = EventItemContainer()
    var events = Events()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
//        UITableView.appearance().tableFooterView = UIView()
    }

    var body: some View {
        print("Loading ContentView: show:",showComment.value)
        let isShowSort = showSort.value
        let isShowComment = showComment.value
        let user = User(id: UUID().uuidString, firstName: "Kevin", lastName: "Chevalier", isAdmin: false)
        return ZStack{
            EventView(events: events, commentEvent: commentEvent, showSort: showSort, showComment: showComment)
                .isBlur(isShowSort || isShowComment)
            SortView(events: events, tags: events.tags, showSort:showSort)
//                .opacity(isShowSort ? 1 : 0)
                .isHidden(!isShowSort)
            CommentView(eventContainer: commentEvent,showComment: showComment, mainUser:user)
                .isHidden(!isShowComment)

        }
        .onAppear(perform:start)

    }
    
    func start(){
        Database.loadData(events)
//        events.addItems(Bundle.main.decode([EventItem].self, from: "sample.json"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
