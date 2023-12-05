//
//  ContentView.swift
//  Fitness Stats Tracker
//
//  Created by siham on 10/24/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var selectedTab = "Home"
    
    var body: some View {
        Group{
            if viewModel.userSession != nil {
                TabView(selection:$selectedTab){
                    HomeView()
                        .tag("Home")
                        .tabItem{
                            Image(systemName:"house")
                        }
                    ProfileView()
                        .tag("Profile")
                        .tabItem { 
                            Image(systemName: "person")
                        }
                }
            } else{
                LoginView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
