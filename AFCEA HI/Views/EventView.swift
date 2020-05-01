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
    @ObservedObject var commentEvent: EventItemContainer
    @ObservedObject var showSort: Boolean
    @ObservedObject var showComment: Boolean
    @ObservedObject var showMenu = Boolean(false)
    @State var showBoard = false
    @State private var tappedEvent : EventItem? = nil

//    var isPrimary = true
    
    //================================================================================
    //BODY
    //================================================================================
    var body: some View {
        print("Loading EventView")

        return NavigationView{
            HStack{
//                createMenu()
//                    .frame(width: showMenu.value ? 200 : 0)
//                    .edgesIgnoringSafeArea(.all)
//                    .background(Color(red: 32/255, green: 32/255, blue: 32/255))
//                    .offset(x: showMenu.value ? 0 : -100)
                createFeed()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        


    }
    
    func createFeed() -> some View{
        ZStack{
            gradientBackground()
            List{
                ForEach(self.events.items.indices, id:\.self) {i in
                    self.createRow(item: self.events.items[i], color: i % 2 == 0 ? Color.gray : Color.white)
                        .isHidden(self.events.items[i].hide)
                }
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .navigationBarItems(leading:
                self.createLeadingNaviItems(), trailing: self.createTrailingNaviItems()
            )
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(named:"Dark")
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named:"Light") ?? UIColor.white]
            })
        }
            
        
    }
    
    func createMenu() -> some View{
        VStack(alignment: .leading){
            Text("Menu")
                .foregroundColor(.gray)
                .font(.largeTitle)
                .padding(.horizontal,50)
//                .background(
//                   Rectangle()
//                    .stroke(Color.gray, lineWidth: 2)
//                    .foregroundColor(Color.clear)
//                )
                .padding(.top,100)
            Button(action:{
                self.showMenu.toggle()
            }){
                HStack{
                    Image(systemName:"person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Events")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                    .padding(.horizontal,50)
                    .padding(.vertical,10)
                .background(
                   Rectangle()
                    .stroke(Color.gray, lineWidth: 2)
                    .foregroundColor(Color.clear)
                )
            }
//            .padding(.top,100)
            
            Button(action:{
                self.showBoard.toggle()
            }){
                HStack{
                    Image(systemName:"person")
                        .foregroundColor(.gray)
                        .imageScale(.large)
                    Text("Committee")
                        .foregroundColor(.gray)
                        .font(.headline)
                }
                    .padding(.horizontal,35)
                    .padding(.vertical,10)
                    .background(
                       Rectangle()
                        .stroke(Color.gray, lineWidth: 2)
                        .foregroundColor(Color.clear)
                    )
            }
//            .padding(.top,100)
            
            Spacer()

        }
        
    }
    
    //================================================================================
    //ROW
    //================================================================================
    func createRow(item: EventItem, color: Color) -> some View{
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 5){
                createTitle(item.title)
                createTags(item.tags)
                createDate(item.date)
                createDescription(self.tappedEvent != nil && self.tappedEvent == item ? item.description : "")
            }
            fitImage(item.image)
            createReactionList(item.reactions)
            createEventButtons(item)
        }
        .padding(8)
        .wrapRoundRectangle(stroke: Color("MedDark"), fill: Color("MedLight"))
        .onTapGesture {
            self.tappedEvent = self.tappedEvent == nil || self.tappedEvent != item ? item : nil
        }
//        .listRowBackground(color)
    }
    
    //================================================================================
    //COMPONENTS
    //================================================================================
    
    
    
    func createTags(_ tags: [String]) -> some View{
        HStack{
            ForEach(tags, id: \.self){ tag in
                self.createTag(tag)
            }
        }
    }
    
    func createTag(_ tag: String) -> some View{
        let color = self.events.tags.getColor(tag)
        return ZStack{
            Text(tag)
                .plainTextStyle()
                .fontSize(12)
                .wrapRoundRectangle(stroke: color, fill:color)
        }
    }
    
    func createDate(_ date: String) -> some View{
//        let f = DateFormatter()
//        f.dateStyle = .short
        //Text(f.string(from: date))
        return Text(date)
            .foregroundColor(Color.black)
            .padding(5)
    }
    
    func createTitle(_ title: String) -> some View{
        Text(title)
            .foregroundColor(Color.black)
            .bold()
            .font(.headline)
            .padding(10)
//            .wrapRoundRectangle(stroke: Color.black, fill: Color("Light"))
//            .padding()
    }
    
    func createDescription(_ description: String) -> some View{
        Text(description)
            .foregroundColor(Color.black)
            .italic()
    }
    
    func createReactionList(_ reactions: Reactions) -> some View{
        return HStack{
            ForEach(reactions.array.indices, id: \.self){ i in
                Text(reactions.array[i] == 0 ? "" : "\(Reactions.symbols[i]) \(reactions.array[i]) ")
            }
        }
    }
    
    func createEventButtons(_ event: EventItem) -> some View{
        HStack{
            Button(action:{
                //add reaction code
                if let reaction = ReactionResult(reactionIndex: 0, eventId: event.id).getJSON(){
                    Database.send(reaction, key: "reaction")
                    event.reactions.array[0] += 1
                    self.events.objectWillChange.send()
                }
                
            }){
                Image(systemName:"hand.thumbsup.fill")
                    .imageScale(.large)

            }
            .plainButtonStyle()
            
            Button(action:{
                print("Pressed Comment Button")
                self.commentEvent.setEvent(event)
                self.showComment.set(true)
            }){
                Image(systemName:"bubble.left.fill")
                    .imageScale(.large)

            }
            .plainButtonStyle()
        }
    }
    
    
    func createTrailingNaviItems() -> some View{
        HStack{
            Button(action:{
                self.showSort.set(true)
            }){
                Image(systemName:"arrow.up.arrow.down.circle.fill")
                    .imageScale(.large)

            }
            .plainButtonStyle()

            Button(action:{
                var tags : [String] = []
                for _ in 0..<3{
                    tags.append("T\(Int.random(in:1...10))")
                }
                let item = EventItem(id:UUID().uuidString,title: "Title", tags:tags,date:"Jan 01, 2020", description: "This is the best description you have ever seen just by clicking the cell. Isn't this great? If you tap me again then the description will disappear. You can also directly click on another cell to show it as well.",image:Image("afcea"))
                self.events.addItem(item)
            }){
                Image(systemName:"plus")
                    .imageScale(.large)
            }
            .plainButtonStyle()
        }
    }
    
    func createLeadingNaviItems() -> some View{
        Button(action:{
            self.showBoard = true
        }){
            Image(systemName:"person.3")
                .imageScale(.large)
        }
            .plainButtonStyle()
            .sheet(isPresented: $showBoard) {
                BoardView()
            }
    }
    
    
    
    
}


