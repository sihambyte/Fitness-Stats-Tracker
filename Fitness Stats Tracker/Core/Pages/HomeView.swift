//
//  Home.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/30/23.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    private var repository = HKRepository()
    
    var items: [GridItem] {
        Array(repeating: .init(.adaptive(minimum: 120)), count: 2)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    LazyVGrid(columns: items, spacing: 2) {
                        ForEach(Activity.allActivities(authViewModel: viewModel)) { activity in
                            NavigationLink(destination: DetailView(activity: activity, repository: repository)){
                                VStack {
                                    Text(activity.image)
                                        .frame(width: 50, height: 50)
                                        .background(RoundedRectangle(cornerRadius: 5).fill(Color.blue.opacity(0.2)))
                                        .fixedSize()
                                    
                                    Text(activity.name)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .font(.body)
                                    Text("Goal: \(activity.goal)")
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                        .font(.caption)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                                .padding()
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .navigationTitle("Welcome")
                }
            }
            .padding()
            .onAppear {
                Task {
                    await viewModel.fetchDailyGoals()
                }
            }
            
        }
        .onAppear {
            repository.requestAuthorization { success in
                print("Auth success? \(success)")
            }
        }
    }
 
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
