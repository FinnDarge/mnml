    import CoreData

struct DataController {
    let container: NSPersistentContainer

    static let shared = DataController()

    // Convenience
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    static var preview: DataController = {
        let result = DataController(inMemory: true)
        let viewContext = result.container.viewContext

        // Workouts
        let newWorkout = Workout(context: viewContext)
        newWorkout.name = "Workout Number 1"

        let newExercise = Exercise(context: viewContext)
        newExercise.name = "Exercise 1"
        
        newWorkout.addToExercises(newExercise)
        shared.saveContext()
        
        return result
    }()

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Model") // else UnsafeRawBufferPointer with negative count
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }

    // Better save
    func saveContext() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("Error: \(error.localizedDescription)")
            }
        }
    }
}
