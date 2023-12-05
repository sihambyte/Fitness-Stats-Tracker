//
//  AuthViewModel.swift
//  Fitness Stats Tracker
//
//  Created by siham on 11/11/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

protocol AuthenticationFormProtocol{
    var formIsValid: Bool { get }
}
@MainActor

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    @Published var calorieBurnGoal: Int?
    @Published var stepsGoal: Int?
    @Published var dailyWalkGoal: Int?
    @Published var dailyWorkoutTime: Int?


    
    init() {
        self.userSession = Auth.auth().currentUser

        
        Task{
            await fetchUser()
            
            
        }
    }
    
    func signIn(withEmail email : String, password: String) async throws {
        do{
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession=result.user
            await fetchUser()
        } catch{
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    func createUser(withEmail email: String, password: String, fullname: String) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)

            // Fetch user data
            await fetchUser()

            // Create the daily_goals collection for the new user
            if let userId = userSession?.uid {
                let goalsCollection = Firestore.firestore().collection("user_goals").document(userId).collection("daily_goals")

                // Specify the default properties
                let defaultGoals: [String: Any] = [
                    "calorieBurnGoal": 2000,
                    "stepsGoal": 10000,
                    "dailyWalkGoal": 5,
                    "dailyWorkoutTime" : 1
                ]

                // Attempt to create the collection with the specified properties
                goalsCollection.addDocument(data: defaultGoals) { error in
                    if let error = error {
                        print("Error creating daily_goals collection: \(error.localizedDescription)")
                    } else {
                        print("daily_goals collection created successfully with default properties.")
                    }
                }
            }

           
            
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
        }
    }

    func signOut(){
        do{
            try Auth.auth().signOut() // sign out user backend
            self.userSession = nil //remove user session and takes us back to login screen
            self.currentUser = nil // removes current user data
        } catch {
            print ("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
        
    }
    func deleteAccount(){
        
    }
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else { return }
        self.currentUser = try? snapshot.data(as: User.self)
        

        
    }
    func fetchDailyGoals() async {
        do {
            guard let userId = userSession?.uid else {
                print("DEBUG: User not authenticated.")
                return
            }

            let goalsCollection = Firestore.firestore().collection("user_goals").document(userId).collection("daily_goals")
            let snapshot = try await goalsCollection.getDocuments()

            if snapshot.isEmpty {
                print("DEBUG: No daily_goals found for the user.")
                return
            }

        
            if let dailyGoalsDocument = snapshot.documents.first {
                let data = dailyGoalsDocument.data()

                if let calorieBurnGoal = data["calorieBurnGoal"] as? Int,
                   let stepsGoal = data["stepsGoal"] as? Int,
                   let dailyWalkGoal = data["dailyWalkGoal"] as? Int,
                   let dailyWorkoutTime = data["dailyWorkoutTime"] as? Int{
                    // Update published properties
                    self.calorieBurnGoal = calorieBurnGoal
                    self.stepsGoal = stepsGoal
                    self.dailyWalkGoal = dailyWalkGoal
                    self.dailyWorkoutTime = dailyWorkoutTime
                } else {
                    print("DEBUG: Failed to parse daily_goals data.")
                }
            }
        } catch {
            print("DEBUG: Failed to fetch daily_goals with error \(error.localizedDescription)")
        }
    }
    
    func saveDailyGoals(calorieBurnGoal: Int, stepsGoal: Int, dailyWalkGoal: Int, dailyWorkoutTime: Int) async {
            do {
                guard let userId = userSession?.uid else {
                    print("DEBUG: User not authenticated.")
                    return
                }

                let goalsCollection = Firestore.firestore().collection("user_goals").document(userId).collection("daily_goals")
                
                let existingDocumentId = try? await goalsCollection.getDocuments().documents.first?.documentID
                
                let documentReference = goalsCollection.document(existingDocumentId ?? "")
                
                // Specify the properties to be updated
                let updatedGoals: [String: Any] = [
                    "calorieBurnGoal": calorieBurnGoal,
                    "stepsGoal": stepsGoal,
                    "dailyWalkGoal": dailyWalkGoal,
                    "dailyWorkoutTime": dailyWorkoutTime,
                ]

                // Attempt to update the document with the specified properties
                try await documentReference.setData(updatedGoals, merge: true)

                
                // Update the published properties for local use
                self.calorieBurnGoal = calorieBurnGoal
                self.stepsGoal = stepsGoal
                self.dailyWalkGoal = dailyWalkGoal
                self.dailyWorkoutTime = dailyWorkoutTime

                print("DEBUG: Daily goals updated successfully.")
            } catch {
                print("DEBUG: Failed to save daily goals with error \(error.localizedDescription)")
            }
        }


}
