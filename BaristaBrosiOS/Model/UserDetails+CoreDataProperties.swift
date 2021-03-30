//
//  UserDetails+CoreDataProperties.swift
//  BaristaBrosiOS
//
//  Created by Aryan Chordia on 3/30/21.
//
//

import Foundation
import CoreData


extension UserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserDetails> {
        return NSFetchRequest<UserDetails>(entityName: "UserDetails")
    }

    @NSManaged public var age: Int32
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var nickname: String?
    @NSManaged public var password: String?

}

extension UserDetails : Identifiable {

}
