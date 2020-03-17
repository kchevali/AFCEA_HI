
import SwiftUI

class Events: ObservableObject{
    @Published var items = [EventItem]()
    private var allItems = [EventItem]()
    var tags = Tags()
    let sorter = Sorter( [
        SortType(name: "date", orders: ["Recent", "Oldest"]),
        SortType(name: "title", orders: ["A-Z",  "Z-A"])
    ])
        
    func addItems(_ events: [EventItem]){
        for item in events{
            addItem(item)
        }
        sortItems()
    }
    
    private func addItemPrivate(_ item: EventItem){
        for tag in item.tags{
            tags.add(tag)
        }
        allItems.insert(item, at:0)
    }
    
    func addItem(_ item: EventItem){
        addItemPrivate(item)
        sortItems()
    }
    
    func updateSorter(_ sort: Int, _ order: Int){
        sorter.selectedSort = sort
        sorter.selectedOrder = order
        sortItems()
    }
    
    func sortItems(){
        let isAscending = sorter.selectedOrder == 0
        switch sorter.getSort() {
            case "date":
                 items = allItems.sorted(by: { ($0.date < $1.date) != isAscending})
                break
            case "title":
                items = allItems.sorted(by: {  ($0.title > $1.title) != isAscending })
                break
            default:
                items = allItems.sorted(by: { ($0.title > $1.title) || isAscending})
        }
    }
}
