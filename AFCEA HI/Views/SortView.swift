//
//  SortView.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/14/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct SortView: View{
    
    var events: Events
    @ObservedObject var tags: Tags
    @ObservedObject var showSort: Boolean
    
    
    @State var selectedSort = 0
    @State var selectedOrder = 0
    @State var selectedFilter = 0
    

    var body: some View{
        print("Loading SortView")
        events.update(selectedSort,selectedOrder, selectedFilter)

        return VStack{
            createTitle()
            createForm()
                .padding()
            createTagGrid(tags.items, columns: 3)
                .padding(5)
            createExitButton()
                .padding()
        }
//    .padding()
    }
    
    func createForm() -> some View{
        Form{
            createSortPicker()
            createOrderPicker()
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .wrapRoundRectangle(stroke: Color.white, fill: Color.gray)
    }
    
    func createTitle() -> some View{
        Text("Options")
            .font(.title)
            .wrapRoundRectangle(stroke: Color.white, fill: Color.gray)
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
        print("Tag Count: \(tags.count)")
        print("Grid: \(rows) x \(columns)")
        
        return GridStack(rows: rows, columns: columns) { row, col in
            self.createTag(tags, col + columns*row)
        }
    }
    
    func createTag(_ tags: [String], _ index: Int) -> some View{
        let isHidden = index >= tags.count
        let tag = isHidden ? "" : tags[index]
        print("Creating Tag: '\(tag)'")
        let isSelected = selectedFilter == index
        
        return Button(action:{
            self.selectedFilter = index
        }){
            Text(tag.count == 0 ? "All" : tag)
                .fontSize(20)
                .plainTextStyle()
                .padding(5)
                .wrapRoundRectangle(stroke: isSelected ? Color.white : Color.gray, fill: self.tags.getColor(tag))
                .grayOut(!isSelected)
            
                
        }
        .padding(5)
        .animation(nil)
        .isHidden(!showSort.value)
        .animation(
            Animation.easeInOut(duration: 2)
                .delay(10)
        )
//        .isHidden(isHidden)

    }
    
    func createExitButton() -> some View{
        Button(action:{
            self.showSort.set(false)
        }){
            Image(systemName:"xmark.circle.fill")
            .imageScale(.large)

        }
        .plainButtonStyle()
    }
}
