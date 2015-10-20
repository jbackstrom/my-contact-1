//
//  Contact+CoreDataProperties.swift
//  MyContact 1
//
//  Created by webstudent on 10/19/15.
//  Copyright © 2015 James Backstrom. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Contact {

    @NSManaged var phone: String?
    @NSManaged var fullname: String?
    @NSManaged var email: String?
    @NSManaged var address: String?
    @NSManaged var gender: String? 

}
