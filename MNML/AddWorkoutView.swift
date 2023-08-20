import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var workoutName = ""
    @State private var exercises: [Exercise] = []
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Workout Title")) {
                    TextField("Workout Title", text: $workoutName)
                }
                Section(header: Text("Exercise")) {
                    TextField("Exercise Name", text: $exerciseName)
                }
                Section(header: Text("Sets and Reps")) {
                    HStack {
                        TextField("Sets", text: $sets)
                        TextField("Reps", text: $reps)
                    }
                }
                Section {
                    Button("Add Exercise") {
                        addExercise()
                    }
                }
                if !exercises.isEmpty {
                    Section(header: Text("Added Exercises")) {
                        ForEach(exercises, id: \.self) { exercise in
                            HStack {
                                Text(exercise.name)
                                Spacer()
                                Text("\(exercise.sets) Sets | \(exercise.reps) Reps")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("Add Workout", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                // Perform action to save the new workout with the entered details
                saveWorkout()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func saveWorkout() {
        guard !workoutName.isEmpty else {
            return
        }
        
        // Create a new Workout entity and save it
        let newWorkout = Workout(context: viewContext)
        newWorkout.name = workoutName

        DataController.shared.saveContext()
        
        // Clear input fields and exercises array
        workoutName = ""
        exercises.removeAll()
    }
    
    private func addExercise() {
        guard !exerciseName.isEmpty,
              let setsValue = Int(sets),
              let repsValue = Int(reps) else {
            return
        }
        
        let newExercise = Exercise(name: exerciseName, sets: setsValue, reps: repsValue)
        exercises.append(newExercise)
        
        // Clear input fields
        exerciseName = ""
        sets = ""
        reps = ""
    }
}

struct Exercise: Hashable {
    let name: String
    let sets: Int
    let reps: Int
}
