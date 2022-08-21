//
//  OnboardingPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 11/08/22.
//

import SwiftUI

let customFont = "Raleway-Regular"

struct OnboardingPage: View {
    
    @State var showloginPage : Bool = false
    
    var body: some View {
       
        VStack(alignment: .leading){
            
            Text("Find your\nGadget")
                .font(.custom(customFont, size: 55).bold())
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.white)
            
            
            Image("OnBoard")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Button {
                withAnimation {
                    showloginPage = true
                }
            } label: {
                Text("Get Started")
                    .font(.custom(customFont, size: 18).bold())
                    .foregroundColor(Color("Purple"))
                    .padding(.vertical, 18)
                    .frame(maxWidth: .infinity)
                    .background(Color.white .cornerRadius(10))
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 5, y: 5)
                
            }
            .padding(.horizontal,30)
            .offset(y: getRect().height < 750 ? 20 : 40)
            
            Spacer()
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, getRect().height < 750 ? 0 : 20)
        .background(Color("Purple"))
        // Go to LoginPage
        .overlay(
            Group{
                if showloginPage{
                    LoginPage()
                        .transition(.move(edge: .bottom))
                }
            })
    }
}

struct OnboardingPage_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingPage()
    }
}
// Get screen bounds
extension View {
    func getRect()-> CGRect {
        return UIScreen.main.bounds
    }
}
