//
//  Workout+CoreDataProperties.swift
//  MNML
//
//  Created by Finn-Rasmus Darge on 20.08.23.
//
//

import Foundation
import CoreData

extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    @NSManaged public var exercises: NSSet?

    public var exercisesArray: [Exercise] {
        let exerciseSet = exercises as? Set<Exercise> ?? []

        return exerciseSet.sorted {
            ($0 as AnyObject).name ?? "" < ($1 as AnyObject).name ?? ""
        }
    }
}

// MARK: Generated accessors for exercises
extension Workout {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}

extension Workout : Identifiable {

}
