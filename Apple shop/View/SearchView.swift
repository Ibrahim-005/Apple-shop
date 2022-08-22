//
//  SearchView.swift
//  Apple shop
//
//  Created by cloud_vfx on 16/08/22.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var homeData: HomeViewModel
    @EnvironmentObject var sharedData : SharedDataModel
    @FocusState var startTF : Bool
    
    var animation : Namespace.ID
    
    var body: some View {
      
        VStack(spacing: 0){
           //Search Bar
            HStack(spacing: 20){
                Button {
                    withAnimation {
                        homeData.searchActivated = false
                    }
                    homeData.searchText = ""
                    sharedData.fromSearchPage = false
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundColor(Color.black.opacity(0.7))
                }
                
               //Searchbar
                HStack(spacing: 9){
                    Image(systemName: "magnifyingglass")
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $homeData.searchText)
                        .focused($startTF)
                        .textCase(.lowercase)
                        .disableAutocorrection(true)
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(
                    Capsule().strokeBorder(Color("Purple"), lineWidth: 1.5)
                )
                .matchedGeometryEffect(id: "SEARCHBAR", in: animation)
                .padding(.trailing,20)
                
            }
            .padding(.horizontal)
            .padding(.top)
            
            // Filter Results
            
            if let products = homeData.searchedProducts{
                
                if products.isEmpty{
                    
                    // No Results Found....
                    VStack(spacing: 10){
                        
                        Image("NotFound")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.top,60)
                        
                        Text("Item Not Found")
                            .font(.custom(customFont,size: 22).bold())
                        
                        Text("Try a more generic search term or try looking for alternative products.")
                            .font(.custom(customFont,size: 16))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal,30)
                    }
                    .padding()
                }
                else{
                    // Filter Results....
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        VStack(spacing: 0){
                            
                            // Found Text...
                            Text("Found \(products.count) results")
                                .font(.custom(customFont, size: 24).bold())
                                .padding(.vertical)
                            
                            // Staggered Grid...
                            // See my Staggered Video..
                            // Link in Bio...
                            StaggeredGrid(columns: 2,spacing: 20, list: products) {product in
                                // Card View....
                                productCardVeiw(product: product)
                            }
                        }
                        .padding()
                    }
                }
            }
            else{
                ProgressView()
                    .padding(.top,30)
                    .opacity(homeData.searchText == "" ? 0 : 1)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("HomeBG").ignoresSafeArea())
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                startTF = true
            }
        }
    }
    @ViewBuilder
    func productCardVeiw(product: Product)->some View{
        VStack(spacing: 10){
            
            ZStack{
                if sharedData.showDetailProducts{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } else{
                    Image(product.productImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "\(product.id)SEARCH", in: animation)
                }
            }
                .frame(width: getRect().width / 2.5, height: getRect().width / 2.5)
                .offset(y: -50)
                .padding(.bottom,-50)
            
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
        }
        .padding([.horizontal,.bottom],10)
        .background(
            Color.white
                .cornerRadius(20)
        )
        .padding(.top, 50)
        .onTapGesture {
            withAnimation(.easeInOut){
                sharedData.fromSearchPage = true
                sharedData.detailProducts = product
                sharedData.showDetailProducts = true
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
      MainPage()
           // .environmentObject(SharedDataModel())
    }
}
