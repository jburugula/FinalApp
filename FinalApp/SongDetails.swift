//
//  SongDetails.swift
//  FinalApp
//
//  Created by Janaki Burugula on Jun/04/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(SongDetails)

class SongDetails : NSManagedObject {
    
    struct Keys {
        static let songId = "identifier"
        static let aarohana = "aarohana"
        static let avarohana = "avarohana"
        static let categoryName = "categoryName"
        static let duration = "duration"
        static let creationDate = "creationDate"
        static let pictureUrl = "pictureUrl"
        static let ragam = "ragam"
        static let songDescription = "songDescription"
        static let title = "title"
        static let updatedDate = "updatedDate"
        static let videoUrl = "videoUrl"
        
    }
    
    @NSManaged var songId: Int64
    @NSManaged var categoryName: String
    @NSManaged var aarohana: String
    @NSManaged var avarohana: String
    @NSManaged var duration: Double
    @NSManaged var pictureUrl: String
    @NSManaged var ragam: String
    @NSManaged var songDescription: String
    @NSManaged var title: String
    @NSManaged var videoUrl: String
    @NSManaged var creationDate: NSDate
    @NSManaged var updatedDate: NSDate
    
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity = NSEntityDescription.entityForName("SongDetails", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        categoryName = dictionary[Keys.categoryName] as! String
        songId =  (dictionary[Keys.songId]?.longLongValue)!
        aarohana = dictionary[Keys.aarohana] as! String
        avarohana = dictionary[Keys.avarohana] as! String
        duration = (dictionary[Keys.duration]?.doubleValue)!
        pictureUrl = dictionary[Keys.pictureUrl] as! String
        ragam = dictionary[Keys.ragam] as! String
        songDescription = dictionary[Keys.songDescription] as! String
        title = dictionary[Keys.title] as! String
        videoUrl = dictionary[Keys.videoUrl] as! String
        creationDate =  dictionary[Keys.creationDate] as! NSDate
        updatedDate =  dictionary[Keys.updatedDate] as! NSDate
        
    }
    
    
    
}
