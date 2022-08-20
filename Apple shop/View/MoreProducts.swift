//
//  MoreProducts.swift
//  Apple shop
//
//  Created by cloud_vfx on 13/08/22.
//

import SwiftUI

struct MoreProducts: View {
    var body: some View {
        VStack{
            Text("More Products")
                .font(.custom(customFont, size: 24).bold())
                .foregroundColor(.black)
        }
        .padding()
        .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .topLeading)
        .background(Color("HomeBG").ignoresSafeArea())
    }
}

struct MoreProducts_Previews: PreviewProvider {
    static var previews: some View {
        MoreProducts()
    }
}
