//
//  Sorter.swift
//  AFCEA HI
//
//  Created by Kevin Chevalier on 3/15/20.
//  Copyright © 2020 AFCEA. All rights reserved.
//

import SwiftUI

class Sorter: ObservableObject{
    @Published var selectedSort = 0
    @Published var selectedOrder = 0
    
    var items: [SortType]
    
    init(_ items: [SortType]) {
        self.items = items
    }
    
    func getSort() -> String{
        return items[selectedSort].name
    }
    
    func getOrder() -> String{
        return items[selectedSort].orders[selectedOrder]
    }
}
