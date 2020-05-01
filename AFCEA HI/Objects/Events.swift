
import SwiftUI

class Events: ObservableObject{
    @Published var items = [EventItem]()
    private var allItems = [EventItem]()
    private var itemDict = [String: EventItem]()
    var tags = Tags()
    let sorter = Sorter( [
        SortType(name: "date", orders: ["Recent", "Oldest"]),
        SortType(name: "title", orders: ["A-Z",  "Z-A"])
    ])
        
    func addItems(_ events: [EventItem]){
        for item in events{
            addItem(item)
        }
        updateItems()
    }
    
    private func addItemPrivate(_ item: EventItem){
        for tag in item.tags{
            tags.add(tag)
        }
        allItems.insert(item, at:0)
        itemDict[item.id] = item
    }
    
    func addItem(_ item: EventItem){
        addItemPrivate(item)
        updateItems()
    }
    
    func getItem(_ id: String) -> EventItem?{
        return itemDict[id]
    }
    
    func update(_ sort: Int, _ order: Int, _ filter: Int){
        sorter.selectedSort = sort
        sorter.selectedOrder = order
        tags.selectedFilter = filter
        updateItems()
    }
    
    
    func updateItems(){
        var filteredItems : [EventItem] = []
        //filter
        if(!tags.hasFilter()){
            filteredItems = allItems
        }else{
            let tag = tags.getFilter()
            for item in allItems{
                if item.containsTag(tag){
                    filteredItems.append(item)
                }
            }
        }
        
        //sort
        let isAscending = sorter.selectedOrder == 0
        switch sorter.getSort() {
            case "date":
                 items = filteredItems.sorted(by: { ($0.date < $1.date) != isAscending})
                break
            case "title":
                items = filteredItems.sorted(by: {  ($0.title > $1.title) != isAscending })
                break
            default:
                items = filteredItems.sorted(by: { ($0.title > $1.title) || isAscending})
        }
    }
}
