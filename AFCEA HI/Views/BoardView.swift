//
//  Committee.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 4/9/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

struct BoardView: View{
        
    let directors = [
        Director(name: "Cory Lindo", position:"Chairman",image: Image("Cory")),
        Director(name: "Dick Macke", position:"ADM",image: Image("Macke")),
        Director(name: "Jeff Bloom", position:"President",image: Image("Jeff")),
        Director(name: "Dick Palmieri", position:"COL",image: Image("Palmieri")),
        Director(name: "Christine Lanning", position:"",image: Image("Christine")),
        Director(name: "Willarvis Smith", position:"",image: Image("Willarvis"))
    ]
    
    var body: some View{
        NavigationView{
            ZStack{
                gradientBackground()
                List{
                    ForEach(self.directors.indices, id:\.self) {i in
                            self.createDirector(self.directors[i])
                    }
                }
            }
            .navigationBarTitle("Board of Directors", displayMode: .inline)
            .background(NavigationConfigurator { nc in
                nc.navigationBar.barTintColor = UIColor(named:"Dark")
                nc.navigationBar.titleTextAttributes = [.foregroundColor : UIColor(named:"Light") ?? UIColor.white]
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())

    }
    
    func createDirector(_ director: Director) -> some View{
        VStack{
            fitImage(director.image)
            Text("\(director.name)\(director.position.count == 0 ? "" : " (\(director.position))")")
        }
        .padding(.vertical,30)
    }
}
