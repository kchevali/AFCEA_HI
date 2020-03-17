//
//  ContentView.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/1/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI


struct EventView: View {
    //=================================================================================
    //VARIABLES
    //=================================================================================
    @ObservedObject var events: Events
    @ObservedObject var showSort: Boolean
    @State private var tappedEvent : EventItem? = nil

//    var isPrimary = true
    
    //================================================================================
    //BODY
    //================================================================================
    var body: some View {//isPrimary ? Color.gray : Color.white
        print("Loading EventView")

        return NavigationView{
            ZStack{
                LinearGradient(gradient:
                    Gradient(colors: [Color("Dark"), Color("MedDark")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.vertical)
                List{
                    ForEach(self.events.items.indices, id:\.self) {i in
                        self.createRow(item: self.events.items[i], color: i % 2 == 0 ? Color.gray : Color.white)
                            .isHidden(self.events.items[i].hide)
                    }
                }
                .navigationBarTitle("Feed", displayMode: .inline)
                .navigationBarItems(trailing:
                    self.createTrailingNaviItems()
                )
                .background(NavigationConfigurator { nc in
                    nc.navigationBar.barTintColor = UIColor(named:"Dark")
                    nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named:"Light") ?? UIColor.white]
                })
            }
            
        }
        .colorMultiply(showSort.value ? .gray: .white)
//        .allowsHitTesting(!(showSort.value))
            .blur(radius: showSort.value ? 20 : 0)
        .animation(.default)

    }
    
    //================================================================================
    //ROW
    //================================================================================
    func createRow(item: EventItem, color: Color) -> some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 5){
                self.createTitle(item.title)
                HStack{
                    ForEach(item.tags, id: \.self){ tag in
                        self.createTag(tag)
                    }
                }
                createDate(item.date)
                createDescription(self.tappedEvent != nil && self.tappedEvent == item ? item.description : "")
            }
            Spacer()
            createImage(item.image)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                .stroke(Color("MedDark"), lineWidth: 4)
            )
            .foregroundColor(Color("MedLight"))
        )
        .onTapGesture {
            self.tappedEvent = self.tappedEvent == nil || self.tappedEvent != item ? item : nil
        }
//        .listRowBackground(color)
    }
    
    //================================================================================
    //COMPONENTS
    //================================================================================
    
    func createImage(_ image: Image) -> some View{
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
//            .frame(width: 64.0, height: 64.0)
    }
    
    func createTag(_ tag: String) -> some View{
        ZStack{
            Text(tag)
                .foregroundColor(Color.black)
            .multilineTextAlignment(.center)
            .font(.system(size: 10))
            .padding(4)
            .background(
               RoundedRectangle(cornerRadius: 15)
                .fill(self.events.tags.getColor(tag))
            )
        }
    }
    
    func createDate(_ date: Date) -> some View{
        let f = DateFormatter()
        f.dateStyle = .short
        return Text(f.string(from: date))
            .foregroundColor(Color.black)
    }
    
    func createTitle(_ title: String) -> some View{
        Text(title)
            .foregroundColor(Color.black)
            .bold()
            .font(.headline)
    }
    
    func createDescription(_ description: String) -> some View{
        Text(description)
            .foregroundColor(Color.black)
            .italic()
    }
    
    func createTrailingNaviItems() -> some View{
        HStack{
            Button(action:{
                self.showSort.set(true)
            }){
                Image(systemName:"arrow.up.arrow.down.circle.fill")
                .resizable()
                .frame(width:30,height:30)
            }
            .buttonStyle(PlainButtonStyle())
            .colorMultiply(.secondary)
            .padding()
//            .sheet(isPresented: $showSheet) {
//                SortView(events: self.events)
//            }
            Button(action:{
                var tags : [String] = []
                for _ in 0..<3{
                    tags.append("T\(Int.random(in:1...10))")
                }
                let item = EventItem(title: "Title", tags:tags,date:Date(), description: "This is the best description you have ever seen just by clicking the cell. Isn't this great? If you tap me again then the description will disappear. You can also directly click on another cell to show it as well.",image:Image("afcea"))
                self.events.addItem(item)
            }){
                Image(systemName:"plus")
            }
            .buttonStyle(PlainButtonStyle())
            .colorMultiply(.secondary)
        }
    }
    
    
    
    
}


