import SwiftUI

struct WorkoutsListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.name, ascending: true)]) var workouts: FetchedResults<Workout>
    
    var body: some View {
            VStack {
                List {
                    ForEach(workouts) { workout in
                        NavigationLink(destination: WorkoutDetailView(workout: workout)) {
                            Text(workout.name ?? "")
                        }
                    }
                    .onDelete(perform: deleteWorkout)
                }
                .toolbar { EditButton() }
            }
        }
    
    private func deleteWorkout(offsets: IndexSet) {
        withAnimation {
            offsets.map { workouts[$0] }.forEach(viewContext.delete)
            DataController.shared.saveContext()
        }
    }
}
