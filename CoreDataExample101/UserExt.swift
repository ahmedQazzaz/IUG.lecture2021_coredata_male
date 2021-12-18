//
//  UserExt.swift
//  CoreDataExample101
//
//  Created by Ahmed Qazzaz on 18/12/2021.
//

import UIKit
import CoreData



extension User {
    
    @discardableResult
    static func createUser(username: String,
                           firstName: String,
                           lastName: String,
                           email: String,
                           mobileNumber: String,
                           active: Bool,
                           dateOfBirth: Date,
                           profileImage: UIImage,
                           facebookAccount: URL?,
                           rate: Double, usingContext context: NSManagedObjectContext)throws -> User? {
        
        let user = User(context: context)
        user.username = username
        user.firstName = firstName
        user.lastName = lastName
        user.email = email
        user.mobile = mobileNumber
        user.active = active
        user.dateOfBirth = dateOfBirth
        user.profileImage = profileImage.pngData()
        user.facebookAccount = facebookAccount
        user.rate = rate
        
        try context.save()
        
        return user
    }
    
}
