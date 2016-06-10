//
//  SongPlayHistory.swift
//  FinalApp
//
//  Created by Janaki Burugula on Jun/08/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

@objc(SongPlayHistory)

class SongPlayHistory : NSManagedObject {
    
    struct Keys {
        static let songId = "songId"
        static let userId = "userId"
        static let playedTime = "playedTime"
        static let lastViewed = "lastViewed"
        
    }
    
    @NSManaged var songId: Int64
    @NSManaged var userId: Int64
    @NSManaged var playedTime: Double
    @NSManaged var lastViewed: NSDate
    
    
    
    override init(entity: NSEntityDescription, insertIntoManagedObjectContext context: NSManagedObjectContext?) {
        super.init(entity: entity, insertIntoManagedObjectContext: context)
    }
    
    /* entity to store last viewed date and total video time viewed per each song 
    This helps to resume playing the video from last stopped point
    */
    
    init(dictionary: [String : AnyObject], context: NSManagedObjectContext) {
        // Core Data
        let entity = NSEntityDescription.entityForName("SongPlayHistory", inManagedObjectContext: context)
        super.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        songId =  (dictionary[Keys.songId]?.longLongValue)!
        userId =  (dictionary[Keys.userId]?.longLongValue)!
        playedTime = (dictionary[Keys.playedTime]?.doubleValue)!
        lastViewed = dictionary[Keys.lastViewed] as! NSDate
        
        
        
    }
    
    
}