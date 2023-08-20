import SwiftUI

struct WorkoutDetailView: View {
    @Environment(\.managedObjectContext) var viewContext

    @StateObject var workout: Workout
    @State private var exerciseName: String = ""

    var body: some View {
        Text(workout.name ?? "No Name")
        VStack {
            List {
                ForEach(workout.exercisesArray.indices, id: \.self) { index in
                    HStack {
                        Text("\(workout.exercisesArray[index].name ?? "Unknown Exercise") | \(workout.exercisesArray[index].sets) Sets | \(workout.exercisesArray[index].reps) Reps")
                    }
                }
                .onDelete(perform: deleteExercise)
            }
            .toolbar { EditButton() }
        }
    }

    private func deleteExercise(offsets: IndexSet) {
        withAnimation {
            offsets.map { workout.exercisesArray[$0] }.forEach(viewContext.delete)
            DataController.shared.saveContext()
        }
    }
}
