//
//  Goals.swift
//  Fitness Stats Tracker
//
//  Created by siham on 12/1/23.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

struct GoalsView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var isEditing = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Goals")
                .font(.largeTitle)
                .fontWeight(.bold)
//                .foregroundColor(.blue)
                .padding(.bottom, 10)

            EditableCalorieGoalsView(
                goal: Binding(
                    get: { authViewModel.calorieBurnGoal ?? 0 },
                    set: { newValue in
                        authViewModel.calorieBurnGoal = newValue
                    }
                ),
                label: "Daily Calorie Burn"
            )

            EditableCalorieGoalsView(
                goal: Binding(
                    get: { authViewModel.stepsGoal ?? 0 },
                    set: { newValue in
                        authViewModel.stepsGoal = newValue
                    }
                ),
                label: "Daily Steps Count"
            )

            EditableCalorieGoalsView(
                goal: Binding(
                    get: { authViewModel.dailyWalkGoal ?? 0 },
                    set: { newValue in
                        authViewModel.dailyWalkGoal = newValue
                    }
                ),
                label: "Daily Walk"
            )
            EditableCalorieGoalsView(
                goal: Binding(
                    get: { authViewModel.dailyWorkoutTime ?? 0 },
                    set: { newValue in
                        authViewModel.dailyWorkoutTime = newValue
                    }
                ),
                label: "Daily Workout Time"
            )



//            Spacer()

            Button(action: {
                Task {
                    await authViewModel.saveDailyGoals(
                        calorieBurnGoal: authViewModel.calorieBurnGoal ?? 0, stepsGoal: authViewModel.stepsGoal ?? 0, dailyWalkGoal: authViewModel.dailyWalkGoal ?? 0,
                            dailyWorkoutTime: authViewModel.dailyWorkoutTime ?? 0
                    )
                }
            }) {
                Text("Save Goals")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
            }
            Spacer()
        }
        .padding()
        .onAppear {
            Task {
                await authViewModel.fetchDailyGoals()
            }
        }
    }



}


struct Goals_View_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView()
    }
}

struct EditableCalorieGoalsView: View {
    @State private var isEditing = false
    @Binding var goal: Int

    var label: String

    var body: some View {
        HStack {
            Text("\(label):")
                .font(.headline)

            Spacer()

            if isEditing {
                TextField("Enter Goal", text: Binding(
                    get: { "\(goal)" },
                    set: {
                        if let newValue = NumberFormatter().number(from: $0) {
                            goal = newValue.intValue
                        }
                    }
                ))
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .onTapGesture {
                    isEditing = true
                }
                .onAppear {
                    isEditing = true
                }
            } else {
                Text("\(goal)")
                    .onTapGesture {
                        isEditing = true
                    }
            }

            Button(action: {
                isEditing.toggle()
            }) {
                Image(systemName: isEditing ? "pencil.circle.fill" : "pencil.circle")
                    .foregroundColor(.blue)
            }
        }
    }
}


