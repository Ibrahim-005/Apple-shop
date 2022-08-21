//
//  Home.swift
//  Apple shop
//
//  Created by cloud_vfx on 13/08/22.
//

import SwiftUI

struct Home: View {
    
    @EnvironmentObject var shardData: SharedDataModel
    @StateObject var homeData: HomeViewModel = HomeViewModel()
    
    var animation: Namespace.ID
    
    var body: some View {
       
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 10){
                // Search Bar...
                ZStack{
                    if homeData.searchActivated{
                        searchBar()
                    }else{
                        searchBar()
                            .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                    }
                }
                .frame(width:getRect().width / 1.6)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        homeData.searchActivated = true
                    }
                }
                
                // Headline Text ...
                Text("Order online\ncollect in store")
                    .font(.custom(customFont, size: 28).bold())
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,25)
                    .padding(.top,28)
                
                
                // Product Type Tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18){
                        ForEach(ProductType.allCases, id: \.self){ type in
                            productTypeView(type: type)
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.top,17)
                
                
                // Product Card...
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18){
                        ForEach(homeData.filteredProducts){ product in
                            productCardVeiw(product: product)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top,80)
                }.padding(.top,30)
                
                
                // See More Button...
                Button {
                    homeData.showMoreProductsOnType.toggle()
                } label: {
                    
                    // Since we need image ar right...
                    Label {
                        Image(systemName: "arrow.right")
                    } icon: {
                        Text("see more")
                    }
                    .font(.custom(customFont, size: 15).bold())
                    .foregroundColor(Color("Purple"))
                }
                .frame(maxWidth: .infinity,alignment: .trailing)
                .padding(.trailing)
                .padding(.top,25)
                
                
            }
            .padding(.vertical)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("HomeBG"))
        .onChange(of: homeData.productType) { newValue in
            homeData.filterProductByType()
        }
        .sheet(isPresented: $homeData.showMoreProductsOnType) {
        
        } content: {
            MoreProducts()
        }
        .overlay(
            ZStack{
                if homeData.searchActivated{
                    SearchView(animation: animation)
                        .environmentObject(homeData)
                }
            }
        )
    }
   
    // Search Bar....
    @ViewBuilder
    func searchBar()->some View{
       
        HStack(spacing: 9){
            Image(systemName: "magnifyingglass")
                .font(.custom(customFont, size: 18))
                .foregroundColor(.gray)
            
            TextField("Search", text: .constant(""))
               
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule().strokeBorder(.gray, lineWidth: 0.8)
        )
    }
 
    // Product Tapes...
    @ViewBuilder
    func productTypeView(type: ProductType)->some View{
        Button {
            withAnimation {
                homeData.productType = type
            }
            
        } label: {
            Text(type.rawValue)
                .font(.custom(customFont, size: 16))
                .fontWeight(.semibold)
                .foregroundColor(homeData.productType == type ? Color("Purple") : .gray)
                .padding(.bottom,10)
                .overlay(
                  
                    ZStack{
                        if homeData.productType == type {
                            Capsule()
                                .fill(Color("Purple"))
                                .matchedGeometryEffect(id: "PRODUCTTAB", in: animation)
                                .frame(height: 2)
                        }else{
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 2)
                        }
                    }
                    .padding(.horizontal,-5)
                    ,alignment: .bottom
                )
        }
    }
    
    @ViewBuilder
    func productCardVeiw(product: Product)->some View{
        VStack(spacing: 10){
            
            ZStack{
                if shardData.showDetailProducts{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .opacity(0)
                } else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)IMAGE", in: animation)
                }
            }
            .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
            .offset(y: -80)
            .padding(.bottom,-70)
            
            Text(product.title)
                .font(.custom(customFont, size: 15).bold())
                .padding(.top,5)
            
            Text(product.subtitle)
                .font(.custom(customFont, size: 13))
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Text(product.price)
                .font(.custom(customFont, size: 15).bold())
                .foregroundColor(Color("Purple"))
                .padding(.vertical,10)
        }
        .padding([.horizontal,.bottom],10)
        .background(
            Color.white
                .cornerRadius(20)
        )
        .onTapGesture {
            withAnimation(.easeInOut){
                
                shardData.detailProducts = product
                shardData.showDetailProducts = true
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
