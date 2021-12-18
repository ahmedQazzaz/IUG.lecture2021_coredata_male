//
//  DBOperations.swift
//  CoreDataExample101
//
//  Created by Ahmed Qazzaz on 18/12/2021.
//

import UIKit
import CoreData

let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

class DBOperations {
    
    
    
    func insertUser(username: String,
                    firstName: String,
                    lastName: String,
                    email: String,
                    mobileNumber: String,
                    active: Bool,
                    dateOfBirth: Date,
                    profileImage: UIImage,
                    facebookAccount: URL?,
                    rate: Double){
        
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
        user?.username = username
        user?.firstName = firstName
        user?.lastName = lastName
        user?.email = email
        user?.mobile = mobileNumber
        user?.dateOfBirth = dateOfBirth
        user?.active = active
        user?.profileImage = profileImage.pngData()
        user?.facebookAccount = facebookAccount
        user?.rate = rate
        
        do{
            try context.save()
        }catch{
            print(error)
        }
    }
    
    func listAllUsers()->[User]{
        //NSFetchRequest
//        let fetchRequest = NSFetchRequest<User>(entityName: "User")
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        
//        if let users = try? fetchRequest.execute(){
//            return users
//        }
        
        if let users = try? context.fetch(fetchRequest) {
            return users
        }
        
        
        return []
    }
    
    func  getUserByUserName(name: String)->User?{
        let fetchRequest : NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "username = %@",name)
        
        let sortByName = NSSortDescriptor(key: "firstName", ascending: true)
        
        fetchRequest.sortDescriptors = [sortByName]
        

        if let users = try? context.fetch(fetchRequest) {
            return users.first
        }
        
        
        return nil
    }
    
}
