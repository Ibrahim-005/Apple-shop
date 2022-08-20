//
//  LoginPageModel.swift
//  Apple shop
//
//  Created by cloud_vfx on 11/08/22.
//

import SwiftUI

class LoginPageModel: ObservableObject {
    
    // Login details
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var showPassword: Bool = false
    // Regoster Details
    @Published var re_enter_Password: String = ""
    @Published var showReenterPaswoed : Bool = false
    
    @Published var UserRegister : Bool = false
    @AppStorage("log_Status") var log_Status: Bool = false
    
    func Login(){
        withAnimation {
            log_Status = true
        }
    }
    
    func Register(){
        withAnimation {
            log_Status = true
        }
    }
    
    func ForgotPasswod(){
        
    }
}
