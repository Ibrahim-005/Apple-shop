//
//  LikedPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 18/08/22.
//

import SwiftUI

struct LikedPage: View {
    
    @EnvironmentObject var sharedData: SharedDataModel
    
    var body: some View {
      
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) {
                VStack{
                    // Bar title & Delete Option
                    HStack{
                        Text("Favourites")
                            .font(.custom(customFont, size: 25).bold())
                       
                        Spacer()
                        
                        Button {
                            withAnimation {
                                sharedData.showDeleteOption.toggle()
                            }
                        } label: {
                            Image("Delete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                        }
                        .opacity(sharedData.likedProducts.isEmpty ? 0 : 1)
                    }
                    .padding()
                    
                   // Showing liked products
                    if sharedData.likedProducts.isEmpty{
                        // If liked products no
                        Group{
                            Image("NoLiked")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .padding()
                                .padding(.top,25)
                            
                            Text("No Liked Products - yet")
                                .font(.custom(customFont, size: 20).bold())
                            
                            Text("some issue has there m so therefore we dont see any image or pictures")
                                .font(.custom(customFont, size: 16))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                    } else{
                        // Display Liked products
                        VStack(spacing: 11){
                            ForEach(sharedData.likedProducts){ product in
                               
                                HStack{
                                    
                                    if sharedData.showDeleteOption {
                                        Button {
                                           deleteLikedCart(product: product)
                                        } label: {
                                            Image(systemName: "minus.circle.fill")
                                                .font(.title2)
                                                .foregroundColor(.red)
                                        }.padding(.trailing)
                                    }
                                    // Card View
                                    CardView(product: product)
                                    
                                }.padding(.top,6)
                            }
                        }
                        .padding(.top, 17)
                        .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
        }
    }
    
    @ViewBuilder
    func CardView(product: Product)->some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.subtitle)
                    .font(.custom(customFont, size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                
                
                Text(product.type.rawValue)
                    .font(.custom(customFont, size: 13))
                    .foregroundColor(.gray)
                
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            Color.white
                .cornerRadius(15)
        )
    }
    
    // delete Liked cart
    func deleteLikedCart(product: Product){
        
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
          let _ =  withAnimation {
                sharedData.likedProducts.remove(at: index)
            }
        }
    }
}

struct LikedPage_Previews: PreviewProvider {
    static var previews: some View {
        LikedPage()
            .environmentObject(SharedDataModel())
    }
}
