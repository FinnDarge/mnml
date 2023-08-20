import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var workoutName = ""
    @State private var addedExercises: [Exercise] = [] // Track added exercises
    
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
                if !addedExercises.isEmpty {
                    Section(header: Text("Added Exercises")) {
                        ForEach(addedExercises, id: \.self) { exercise in
                                Text("\(exercise.name ?? "Unknown Exercise") | \(exercise.sets) Sets | \(exercise.reps) Reps")
                            }
                    }
                }
            }
            .navigationBarTitle("Add Workout", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                // Perform action to save the new workout with the entered details and associated exercises
                saveWorkout()
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    private func addExercise() {
        guard !exerciseName.isEmpty,
              let setsValue = Int(sets),
              let repsValue = Int(reps) else {
            return
        }
        
        let newExercise = Exercise(context: viewContext)
        newExercise.name = exerciseName
        newExercise.sets = Int16(setsValue)
        newExercise.reps = Int16(repsValue)
        
        addedExercises.append(newExercise) // Track the added exercise
        
        // Clear input fields
        exerciseName = ""
        sets = ""
        reps = ""
    }
    
    private func saveWorkout() {
        guard !workoutName.isEmpty else {
            return
        }
        
        // Create a new Workout entity and save it
        let newWorkout = Workout(context: viewContext)
        newWorkout.name = workoutName
        
        // Associate the added exercises with the new workout
        for exercise in addedExercises {
            newWorkout.addToExercises(exercise)
        }

        DataController.shared.saveContext()
        
        // Clear input fields and exercises array
        workoutName = ""
        addedExercises.removeAll()
    }
}

