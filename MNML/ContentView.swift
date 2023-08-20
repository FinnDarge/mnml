import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @State private var isAddingWorkout = false

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        isAddingWorkout = true
                    }) {
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 20)
                }
                Spacer()
                NavigationLink(destination: WorkoutsListView()) {
                                    Text("Workouts")
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                };
                Spacer()
            }
            .navigationBarTitle("", displayMode: .inline)
            .sheet(isPresented: $isAddingWorkout) {
                            AddWorkoutView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, DataController.preview.container.viewContext)
    }
}

