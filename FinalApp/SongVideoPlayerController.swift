//
//  SongVideoPlayerController.swift
//  FinalApp
//
//  Created by Janaki Burugula on Jun/08/2016.
//  Copyright © 2016 janaki. All rights reserved.
//



import UIKit
import AVKit
import AVFoundation
import CoreData


class SongVideoPlayerController: AVPlayerViewController  ,NSFetchedResultsControllerDelegate{
    
    
    var currentUserId: Int64!
    var currentSongId: Int64!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // save the video play time history
    
    func savePlayHistory(){
        
        let todaysDate:NSDate = NSDate()
        let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let DateInFormat:String = dateFormatter.stringFromDate(todaysDate)
        let todayDate = dateFormatter.dateFromString(DateInFormat)
        
        
        var songPlayHistory =  [String : AnyObject]()
       
        let currentplayedTime: Double = CMTimeGetSeconds((self.player?.currentTime())!)
       
        
        songPlayHistory[SongPlayHistory.Keys.playedTime] = currentplayedTime
        songPlayHistory[SongPlayHistory.Keys.lastViewed] = todayDate
        songPlayHistory[SongPlayHistory.Keys.userId] = NSNumber(longLong:currentUserId )
        songPlayHistory[SongPlayHistory.Keys.songId] = NSNumber(longLong:currentSongId)
        
        _ = SongPlayHistory(dictionary: songPlayHistory, context: self.sharedContext)
        self.saveContext()
        
        
        
    }
    
    
    // Once the video play is done, save the video play time history for later use
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        savePlayHistory()
             
        }
    
}
