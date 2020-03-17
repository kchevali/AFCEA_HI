//
//  SortView.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/14/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct SortView: View{
    @State var selectedSort = 0
    @State var selectedOrder = 0
    @State var selectedFilter = 0
    @ObservedObject var tags: Tags
    var events: Events
    var showSort: Boolean

    var body: some View{
        print("Loading SortView")
        events.updateSorter(selectedSort,selectedOrder)

        return VStack{
            createForm()
                .padding()
            createTagGrid(tags.items, columns: 3)
                .padding()
            createExitButton()
        }
//    .padding()
    }
    
    func createForm() -> some View{
        Form{
            createSortPicker()
            createOrderPicker()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(Color.white)
            .opacity(0.6)
        )
    }
    
    func createSortPicker() -> some View{
        let sorts = events.sorter.items
        return Section(header:Text("Sort")){
            Picker("Select sort",selection: $selectedSort){
                ForEach(0..<sorts.count){ i in
                    Text("\(sorts[i].name)")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    func createOrderPicker() -> some View{
        let sort = events.sorter.items[selectedSort]
        return Section(header:Text("Order")){
            Picker("Select order",selection: $selectedOrder){
                ForEach(0..<sort.orders.count){ i in
                    Text("\(sort.orders[i])")
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
    
    func createTagGrid(_ tags: [String], columns: Int) -> some View{
        var div = CGFloat(tags.count) / CGFloat(columns)
        div.round(.up)
        let rows = Int(div)
//        print("Tag Count: \(tags.count)")
//        print("Grid: \(rows) x \(columns)")
        
        return GridStack(rows: rows, columns: columns) { row, col in
            self.createTag(tags, col + columns*row)
        }
    }
    
    func createTag(_ tags: [String], _ index: Int) -> some View{
        let isHidden = index >= tags.count
        let tag = isHidden ? "" : tags[index]
        let text = Text(tag.count == 0 ? "All" :tag)
            .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
            .padding(10.0)
        
        return Button(action:{
            self.selectedFilter = index
        }){
            text.background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(self.tags.getColor(tag))
                    .colorMultiply(self.selectedFilter == index ? Color.white : Color.gray)
            )
        }
        .padding(5)
        .opacity(isHidden ? 0 : 1)

    }
    
    func createExitButton() -> some View{
        Button(action:{
            self.showSort.set(false)
        }){
            Image(systemName:"xmark.circle.fill")
            .resizable()
            .frame(width:50,height:50)

        }
        .buttonStyle(PlainButtonStyle())
    }
}
