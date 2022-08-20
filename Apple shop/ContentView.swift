//
//  ContentView.swift
//  Apple shop
//
//  Created by cloud_vfx on 11/08/22.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("log_Status") var log_Status: Bool = false
    var body: some View {
        
        if log_Status{
            MainPage()
        }else{
            OnboardingPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
