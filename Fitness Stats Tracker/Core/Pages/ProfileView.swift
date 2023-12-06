//
//  ProfileView.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/11/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var isShowingGoalsView = false
    
    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser{
                List{
                    Section{
                        HStack {
                            Text(user.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width:72, height:72)
                                .background(Color(.systemGray3))
                                .clipShape(Circle())
                            VStack(alignment: .leading,     spacing: 4){
                                Text(user.fullname)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .padding(.top, 4)
                                Text(user.email)
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    Section("Fitness Goals"){
                        NavigationLink{
                            GoalsView()
                                .navigationBarBackButtonHidden(false)
                            
                        } label:{
                            HStack(spacing: 3){
                                Text("Goals")
                                    .fontWeight(.bold)
                            }
                            .font(.system(size: 14))
                        }
                        
                    }
                    Section("Account"){
                        Button{
                            viewModel.signOut()
                        }label: {
                            SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
                        }
                        Button{
                            print("Delete account..")
                        }label: {
                            SettingsRowView(imageName: "xmark.circle.fill", title: "Delete Account", tintColor: .red)
                        }
                    }
                }
                .navigationTitle("Profile")
            }
        }
    }
    
    struct ProfileView_Previews: PreviewProvider {
        static var previews: some View {
            ProfileView()
        }
    }
}
