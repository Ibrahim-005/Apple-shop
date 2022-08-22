//
//  ProfilePage.swift
//  Apple shop
//
//  Created by cloud_vfx on 17/08/22.
//

import SwiftUI

struct ProfilePage: View {
    var body: some View {
        
        NavigationView{
            ScrollView(.vertical, showsIndicators: false) { 
                VStack{
                    
                    Text("Profile")
                        .font(.custom(customFont, size: 28).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    VStack(spacing: 15){
                        
                        Image("Profile_Image")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                            .offset(y: -30)
                            .padding(.bottom,-30)
                        
                        Text("Lauido Ana")
                            .font(.custom(customFont, size: 18))
                            .fontWeight(.semibold)
                        
                        HStack(alignment: .top, spacing: 10){
                            Image(systemName: "location.north.circle.fill")
                                .foregroundColor(.gray)
                                .rotationEffect(.init(degrees: 180))
                            
                            Text("Address: 43 Oxford Road\nM13 4GR\nManchester, UK")
                                .font(.custom(customFont, size: 14))
                                .foregroundColor(Color.black.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.horizontal, .bottom])
                    .background(Color.white .cornerRadius(10))
                    .padding([.top, .horizontal],40)
                    
                    // Custom Navigation Links...
                    
                    CustomNavigationLink(title: "Edit Profile") {
                        
                        Text("")
                            .navigationTitle("Edit Profile")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }.padding(.top,30)
                    
                    CustomNavigationLink(title: "Shopping address") {
                        
                        Text("")
                            .navigationTitle("Shopping address")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Order history") {
                        
                        Text("")
                            .navigationTitle("Order history")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Cards") {
                        
                        Text("")
                            .navigationTitle("Cards")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                    
                    CustomNavigationLink(title: "Notifications") {
                        
                        Text("")
                            .navigationTitle("Notifications")
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("HomeBG").ignoresSafeArea())
                    }
                }
                .padding(.horizontal,22)
                .padding(.vertical,20)
            }
            .navigationBarHidden(true)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("HomeBG").ignoresSafeArea())
        }
       
    }
    
    // Avoiding new Structs...
    @ViewBuilder
    func CustomNavigationLink<Detail: View>(title: String,@ViewBuilder content: @escaping ()->Detail)->some View{
        
        NavigationLink {
            content()
        } label: {
            
            HStack{
                Text(title)
                    .font(.custom(customFont, size: 17))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .foregroundColor(.black)
            .padding()
            .background( Color.white .cornerRadius(12) )
            .padding(.horizontal)
            .padding(.top,10)
        }
    }
}


struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
