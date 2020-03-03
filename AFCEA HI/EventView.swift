//
//  ContentView.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/1/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct EventItem: Identifiable{
    let id = UUID()
    let title: String
    let tags: [String]
    let description: String
    let image: Image
}

struct ContentView: View {
    @State private var events : [EventItem] = []
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(self.events) {item in
                        HStack{
                            VStack(alignment: .leading){
                                HStack{
                                    Text(item.title)
                                    ForEach(item.tags, id: \.self){ tag in
                                        ZStack{
                                            RoundedRectangle(cornerRadius: 30)
                                                .fill(Color(hue:Double.random(in:0...1),saturation:0.45,brightness:1,opacity:1))
                                                .frame(width:30,height:20)

                                            Text(tag)
                                        }
                                    }
                                }
                                
                                Text(item.description)
                            }
                            Spacer()
                            item.image
                        }
                    }
                }
            }
            .navigationBarTitle("Feed")
            .navigationBarItems(trailing:
                Button(action:{
                    let item = EventItem(title: "Title", tags: ["T1","T2"], description: "Good description",image:Image("afcea"))
                    self.events.append(item)
                    let _ = "hello"
                }){
                    Image(systemName:"plus")
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
