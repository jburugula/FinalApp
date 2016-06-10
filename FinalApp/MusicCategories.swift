//
//  MusicCategories.swift
//  FinalApp
//
//  Created by Janaki Burugula on May/28/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(MusicCategories)

class MusicCategories : NSManagedObject {
    
    struct Keys {
        static let categoryId = "identifier"
        static let categoryName = "name"
        static let songDetails = "songDetails"
        static let categoryLevel = "level"
        static let creationDate = "creationDate"
        static let updatedDate = "updatedDate"
    }
    
    @NSManaged var categoryId: Int64
    @NSManaged var categoryName: String
    @NSManaged var categoryLevel: Int64
    @NSManaged var creationDate: NSDate
    @NSManaged var updatedDate: NSDate
    
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity = NSEntityDescription.entityForName("MusicCategories", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        categoryName = dictionary[Keys.categoryName] as! String
        categoryId =  (dictionary[Keys.categoryId]?.longLongValue)!
        categoryLevel =  (dictionary[Keys.categoryLevel]?.longLongValue)!
        creationDate =  dictionary[Keys.creationDate] as! NSDate
        updatedDate =  dictionary[Keys.updatedDate] as! NSDate
        
        
        
    }
    
    
}