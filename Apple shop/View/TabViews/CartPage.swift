//
//  CartPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 19/08/22.
//

import SwiftUI

struct CartPage: View {
    @EnvironmentObject var sharedData: SharedDataModel
    @State var deleteOption: Bool = false
    var body: some View {
      
        NavigationView{
            
            VStack(spacing: 10){
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        
                        HStack{
                            Text("Basket")
                                .font(.custom(customFont, size: 25).bold())
                           
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    sharedData.showOptionDelete.toggle()
                                }
                            } label: {
                                Image("Delete")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 25, height: 25)
                            }.opacity($sharedData.CartProducts.isEmpty ? 0 : 1)
                        }.padding()
                        
                        
                        if $sharedData.CartProducts.isEmpty{
                            // If liked products no
                            Group{
                                Image("NoBasket")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                                    .padding(.top,25)
                                
                                Text("No Added Products - yet")
                                    .font(.custom(customFont, size: 20).bold())
                                
                                Text("some issue has there m so therefore we dont see any image or pictures")
                                    .font(.custom(customFont, size: 16))
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .padding()
                            }
                        } else{
                            // Display Liked products
                            VStack(spacing: 10){
                                ForEach($sharedData.CartProducts){ $product in
                                   
                                    HStack{
                                        
                                        if sharedData.showOptionDelete{
                                            Button {
                                               deleteLikedCart(product: product)
                                            } label: {
                                                Image(systemName: "minus.circle.fill")
                                                    .font(.title2)
                                                    .foregroundColor(.red)
                                            }.padding(.trailing)
                                        }
                                        // Card view
                                        CardView(product: $product)
                                        
                                    }.padding(.top,6)
                                }
                            }
                            .padding(.top,22)
                            .padding(.horizontal)
                        }
                    }
                }
                
                if !$sharedData.CartProducts.isEmpty{
                    
                    Group{
                        
                        HStack{
                            
                            Text("Total")
                                .font(.custom(customFont, size: 14))
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text(sharedData.getTotalPrice())
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(Color("Purple"))
                        }
                        
                        Button {
                            
                        } label: {
                            
                            Text("Checkout")
                                .font(.custom(customFont, size: 18).bold())
                                .foregroundColor(.white)
                                .padding(.vertical,18)
                                .frame(maxWidth: .infinity)
                                .background(Color("Purple"))
                                .cornerRadius(15)
                                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 5, y: 5)
                        }
                        .padding(.bottom)
                    }
                    .padding(.horizontal,25)
                    
                }
                       
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
            
                Color("HomeBG")
                    .ignoresSafeArea()
            )
        }
    }

    
    // delete Liked cart
    func deleteLikedCart(product: Product){
        
        if let index = sharedData.CartProducts.firstIndex(where: { currentProduct in
            return product.id == currentProduct.id
        }){
          let _ =  withAnimation {
                sharedData.CartProducts.remove(at: index)
            }
           
        }
    }
}

struct CartPage_Previews: PreviewProvider {
    static var previews: some View {
        CartPage()
            .environmentObject(SharedDataModel())
    }
}


struct CardView: View{
    
    // Making Product as Binding so as to update in Real time...
    @Binding var product: Product
    
    var body: some View{
        
        HStack(spacing: 15){
            
            Image(product.productImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 8) {
                
                Text(product.title)
                    .font(.custom(customFont, size: 18).bold())
                    .lineLimit(1)
                
                Text(product.price)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                    .foregroundColor(Color("Purple"))
                
                // Quantity Buttons...
                HStack(spacing: 10){
                    
                    Text("Quantity")
                        .font(.custom(customFont, size: 14))
                        .foregroundColor(.gray)
                    
                    Button {
                        product.quantity = (product.quantity > 0 ? (product.quantity - 1) : 0)
                    } label: {
                        Image(systemName: "minus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)
                    }

                    Text("\(product.quantity)")
                        .font(.custom(customFont, size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                    
                    Button {
                        product.quantity += 1
                    } label: {
                        Image(systemName: "plus")
                            .font(.caption)
                            .foregroundColor(.white)
                            .frame(width: 20, height: 20)
                            .background(Color("Quantity"))
                            .cornerRadius(4)
                    }
                }
            }
        }
        .padding(.horizontal,10)
        .padding(.vertical,10)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(
        
            Color.white
                .cornerRadius(10)
        )
    }
}
