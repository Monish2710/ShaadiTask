//
//  UserDataEntity+CoreDataProperties.swift
//  Shaadi iOS Task
//
//  Created by Monish Kumar on 28/01/25.
//
//

import Foundation
import CoreData


extension UserDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDataEntity> {
        return NSFetchRequest<UserDataEntity>(entityName: "UserDataEntity")
    }

    @NSManaged public var title: String?
    @NSManaged public var address: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var isAccepted: Bool
    @NSManaged public var isDeclined: Bool
    @NSManaged public var email: String?
}

extension UserDataEntity : Identifiable {

}
