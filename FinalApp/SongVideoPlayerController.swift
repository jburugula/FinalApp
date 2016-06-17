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
        
        // Add UI slider to the view to control volume settings
        
        let volumeSlider = UISlider(frame:CGRectMake(20, 70,400, 20))
        volumeSlider.minimumValue = 0
        volumeSlider.maximumValue = 100
        volumeSlider.continuous = true
        volumeSlider.tintColor = UIColor.redColor()
        volumeSlider.value = 20
        volumeSlider.addTarget(self, action: #selector(SongVideoPlayerController.sliderValueDidChange(_:)), forControlEvents: .ValueChanged)
        self.view.addSubview(volumeSlider)
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
    func sliderValueDidChange(sender: UISlider) {
        
        self.player!.volume = sender.value;
        
        
    }
    
    
    
    
    
}
