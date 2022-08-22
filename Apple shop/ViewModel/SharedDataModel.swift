//
//  SharedDataModel.swift
//  Apple shop
//
//  Created by cloud_vfx on 18/08/22.
//

import SwiftUI

class SharedDataModel: ObservableObject {
 
    @Published var detailProducts: Product?
    @Published var showDetailProducts : Bool = false
    
    @Published var fromSearchPage : Bool = false
    
    @Published var likedProducts : [Product] = []
    @Published var CartProducts : [Product] = []
    
    @Published var showDeleteOption: Bool = false
    // calculating Total price...
    func getTotalPrice()->String{
        
        var total: Int = 0
        
        CartProducts.forEach { product in
            
            let price = product.price.replacingOccurrences(of: "$", with: "") as NSString
            
            let quantity = product.quantity
            let priceTotal = quantity * price.integerValue
            
            total += priceTotal
        }
        
        return "$\(total)"
    }
}
