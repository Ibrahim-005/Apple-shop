//
//  MainPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 13/08/22.
//

import SwiftUI

struct MainPage: View {
    
    @StateObject var sharedData: SharedDataModel = SharedDataModel()
    @State var currentTab: Tab = .Home
    @Namespace var animation
    
    init(){
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
       
        VStack(spacing: 0){
            
            TabView(selection: $currentTab) {
                
                Home(animation: animation)
                    .environmentObject(sharedData)
                    .tag(Tab.Home)
                
                LikedPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Liked)
                
                ProfilePage()
                    .tag(Tab.Profile)
                
                CartPage()
                    .environmentObject(sharedData)
                    .tag(Tab.Cart)
            }
           
            HStack(spacing: 10){
                
                ForEach(Tab.allCases, id: \.self){ tab in
                   
                    Button {
                        currentTab = tab
                       // Dismis delete pins of Liked & Cart pages When changed Currently Tab
                        sharedData.showOptionDelete = false
                    } label: {
                        Image(tab.rawValue)
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 22, height: 22)
                            .background(
                                Color("Purple")
                                    .opacity(0.1)
                                    .cornerRadius(5)
                                // blurring...
                                    .blur(radius: 5)
                                // Making little big...
                                    .padding(-7)
                                    .opacity(currentTab == tab ? 1 : 0)
                            )
                            .frame(maxWidth: .infinity)
                            .foregroundColor(currentTab == tab ? Color("Purple") : Color.black.opacity(0.3)
                            )
                    }
                }
            }.padding([.horizontal, .top])
             .padding(.bottom, 10)
                
        }
        .background(Color("HomeBG").ignoresSafeArea())
        .overlay(
            ZStack{
                if let product = sharedData.detailProducts, sharedData.showDetailProducts {
                    ProductDetailPage(product: product, animation: animation)
                        .environmentObject(sharedData)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        )
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}

// Tab cases
enum Tab: String, CaseIterable{
    case Home = "Home"
    case Liked = "Liked"
    case Profile = "Profile"
    case Cart = "Cart"
}
