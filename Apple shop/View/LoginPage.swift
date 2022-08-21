//
//  LoginPage.swift
//  Apple shop
//
//  Created by cloud_vfx on 11/08/22.
//

import SwiftUI

struct LoginPage: View {
    
    @StateObject var loginData: LoginPageModel = LoginPageModel()
    
    var body: some View {
      
        VStack(spacing: 12){
            
            Text("Welcome\nBack")
                .font(.custom(customFont, size: 55).bold())
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: getRect().height / 3.5)
                .padding()
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15){
                    
                    Text(loginData.UserRegister ? "Register" : "Login")
                        .font(.custom(customFont, size: 22).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    customTextField(title: "Email", icon: "envelope", hint: "justin050@gmail.com", value: $loginData.email, showPassword: .constant(false))
                        .padding(.top,20)
                    
                    customTextField(title: "Password", icon: "lock", hint: "123456", value: $loginData.password, showPassword: $loginData.showPassword)
                        .padding(.top,20)
                    
                    if loginData.UserRegister {
                        customTextField(title: "Re-enter-Password", icon: "lock", hint: "123456", value: $loginData.re_enter_Password, showPassword: $loginData.showRe_enter_Password)
                            .padding(.top,20)
                    }
                     
                    Button {
                        
                    } label: {
                        Text("Forgot Passwod")
                            .font(.custom(customFont, size: 15))
                            .fontWeight(.semibold)
                            .foregroundColor(Color("Purple"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)
                    }
                    
                 // Login Button...
                    Button {
                        if loginData.UserRegister{
                            loginData.Register()
                        } else{
                            loginData.Login()
                        }
                    } label: {
                        Text(loginData.UserRegister ? "Register" : "Login")
                            .font(.custom(customFont, size: 15).bold())
                            .foregroundColor(Color.white)
                            .padding(.vertical, 18)
                            .frame(maxWidth: .infinity)
                            .background(Color("Purple"))
                            .cornerRadius(10)
                    }
                    .padding([.horizontal, .top],20)
                    
                    
                    Button {
                        loginData.UserRegister.toggle()
                      } label: {
                        Text(loginData.UserRegister ? "Back to Login" : "Create Account")
                            .font(.custom(customFont, size: 15).bold())
                            .foregroundColor(Color("Purple"))
                            .frame(maxWidth: .infinity)
                            .padding(.top, 5)
                    }
                    
                }.padding(30)
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Color.white
                // Applying Custom Corners...
                    .clipShape(CustomCorners(corners: [.topLeft,.topRight], radius: 25))
                    .ignoresSafeArea()
            )
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Purple"))
        .onChange(of: loginData.UserRegister) { newValue in
            loginData.email = ""
            loginData.password = ""
            loginData.re_enter_Password = ""
            loginData.showPassword = false
            loginData.showRe_enter_Password = false
        }
    }
    
    // Custom TextField...
    @ViewBuilder
    func customTextField(title: String, icon: String, hint: String, value: Binding<String>, showPassword: Binding<Bool>)-> some View{
        
        VStack(alignment: .leading, spacing: 12){
            
            Label {
                Text(title)
                    .font(.custom(customFont, size: 14))
            } icon: {
                Image(systemName: icon)
            }.foregroundColor(Color.black.opacity(0.8))
          
            // Show Secure or Text - Fields
            if title.contains("Password") && !showPassword.wrappedValue {
                SecureField(hint, text: value)
                    .padding(.top,2)
            } else{
                TextField(hint, text: value)
                    .padding(.top,2)
            }
            
            Divider()
                .background(Color.black.opacity(0.8))
            
        }.padding(.top,2)
            .overlay(
                Group{
                    
                    if title.contains("Password"){
                        Button {
                            showPassword.wrappedValue.toggle()
                        } label: {
                            Text(showPassword.wrappedValue ? "HIde" : "Show")
                                .font(.custom(customFont, size: 15))
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Purple"))
                            //.frame(maxWidth: .infinity)
                                .padding(.top, 5)
                            
                        }.offset(y: 8)
                    }
                },alignment: .trailing
            )
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
