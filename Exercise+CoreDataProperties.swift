//
//  Exercise+CoreDataProperties.swift
//  MNML
//
//  Created by Finn-Rasmus Darge on 20.08.23.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var sets: Int16
    @NSManaged public var reps: Int16
    @NSManaged public var workout: Workout?

}

extension Exercise : Identifiable {

}
