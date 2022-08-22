//
//  ProductDetailPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 18/08/22.
//

import SwiftUI

struct ProductDetailPage: View {
    
    var product: Product
    // For Matched Geometry Effect...
    var animation: Namespace.ID
    // Shared Data Model...
    @EnvironmentObject var sharedData: SharedDataModel 
    
  //  @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        
        VStack{
            
            VStack{
                HStack(spacing:0){
                    Button {
                        withAnimation(.easeInOut){
                            sharedData.showDetailProducts = false
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(Color.black.opacity(1.7))
                    }
                    Spacer()
                    
                    Button {
                        addToLiked()
                    } label: {
                        Image("Liked")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(isLiked() ? .red : Color.black.opacity(1.7))
                            .frame(width: 24, height: 24)
                            
                    }
                }.padding()
                
                Image(product.productImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .matchedGeometryEffect(id: "\(product.id)\(sharedData.fromSearchPage ? "SEARCH" : "IMAGE")", in: animation)
                    .padding(.horizontal)
                    .offset(y: -12)
                
            }
            .frame(height: getRect().height / 2.7)
            .zIndex(1)
            
            
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 15){
                    
                    Text(product.title)
                        .font(.custom(customFont, size: 20).bold())
                        
                    Text(product.subtitle)
                        .font(.custom(customFont, size: 18))
                        .foregroundColor(.gray)
                    
                    Text("Get Apple TV+ free for a year")
                        .font(.custom(customFont, size: 16).bold())
                        .padding(.top)
                    
                    Text("Available when you purchase any new iPhone, iPad, iPod Touch, Mac or Apple TV, £4.99/month after free trial.")
                        .font(.custom(customFont, size: 15))
                        .foregroundColor(.gray)
                    
                    
                    Button {
                        
                    } label: {
                        Label {
                            Image(systemName: "arrow.right")
                        } icon: {
                            Text("Full Description")
                        }
                        .foregroundColor(Color("Purple"))
                    }.padding(.top)

                    HStack(alignment: .top, spacing: 0){
                        Text("Total")
                            .foregroundColor(Color.black.opacity(0.8))
                        
                        Spacer()
                        
                        Text("\(product.price)")
                            .font(.custom(customFont, size: 19).bold())
                            .foregroundColor(Color("Purple"))
                    }.padding([.top, .bottom])
                    
                    Button {
                        addToCart()
                    } label: {
                        Text("\(isAddedToCart() ? "added" : "add") To basket")
                            .font(.custom(customFont, size: 18).bold())
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 18)
                            .background(
                                Color("Purple")
                                    .cornerRadius(15))
                            .shadow(color: Color.black.opacity(0.06), radius: 5, x: 5, y: 5)
                    }
                }
                .padding([.horizontal, .bottom, .top],22)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                    .clipShape(CustomCorners(corners: [.topLeft, .topRight], radius: 25))
                    .ignoresSafeArea()
            )
            .zIndex(0)
        }
        .background(Color("HomeBG"))
    }
    
    // check Is added to Liked
    func isLiked()-> Bool{
        return sharedData.likedProducts.contains { currentProduct in
            self.product.id == currentProduct.id
        }
    }
    
    // Check is added to Cart
    func isAddedToCart()-> Bool{
        return sharedData.CartProducts.contains { currentProduct in
            self.product.id == currentProduct.id
        }
    }
    
    func addToLiked(){
        if let index = sharedData.likedProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            sharedData.likedProducts.remove(at: index)
        } else{
            sharedData.likedProducts.append(product)
        }
    }
    
    func addToCart(){
        if let index = sharedData.CartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
            sharedData.CartProducts.remove(at: index)
        } else{
            sharedData.CartProducts.append(product)
        }
    }
}

struct ProductDetailPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
