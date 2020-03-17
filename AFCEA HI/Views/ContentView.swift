import SwiftUI


struct ContentView: View {
    @ObservedObject var showSort = Boolean(false)
    var events = Events()
    
    init(){
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
//        UITableView.appearance().tableFooterView = UIView()
    }

    var body: some View {//isPrimary ? Color.gray : Color.white
        print("Loading ContentView")
        let isShowSort = showSort.value
        return ZStack{
            EventView(events: events, showSort: showSort)
            SortView(tags: events.tags, events: events, showSort:showSort)
//                .opacity(isShowSort ? 1 : 0)
                .animation(.default)
                .offset(x: 0, y: isShowSort ? 0 : 1000)
//                .frame(width: isShowSort ? 350 : 0)
        }
        .onAppear(perform:start)

    }
    
    func start(){
        events.addItems(Bundle.main.decode([EventItem].self, from: "sample.json"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
