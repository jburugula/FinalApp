//
//  MusicLessonCollectionViewController.swift
//  FinalApp
//
//  Created by Janaki Burugula on May/14/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation
import CoreData

class MusicLessonCollectionViewController: UICollectionViewController , NSFetchedResultsControllerDelegate {
    
    var fetchedResultsProcessingOperations: [NSBlockOperation] = []
    
    var playHistoryfetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    var imageCache = NSMutableDictionary()
    
    
    @IBOutlet weak var colectflow: UICollectionViewFlowLayout!
    
    var selectedCatg: String!
    
    var userId: Int64!
    
    var songHistory: AnyObject!
    
    //   var lastViewedDate : NSDate!
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        // reload collection view
        collectionView!.reloadData()
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set cell format
        
        let space: CGFloat = 2.0
        let dimension = (view.frame.size.width - (2 * space)) / 2.0
        
        colectflow.minimumInteritemSpacing = space
        colectflow.itemSize = CGSizeMake(dimension, dimension)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
         self.showAlertView(" No Music Lessons Found for this Cateogry. Please select Different Category ")}
        
        // this class is NSFetchedResultsControllerDelegate
        fetchedResultsController.delegate = self
        
        
        if fetchedResultsController.fetchedObjects?.count == nil || fetchedResultsController.fetchedObjects?.count == 0 {
            
            fetchSongDetails()
            
        }
        
        
    }
    
    // number of sections
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(tableView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
        
    }
    
    // retreive data and update each cell
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("musicCollection", forIndexPath: indexPath) as! MusicCollectionViewCell
        
        let songs = fetchedResultsController.objectAtIndexPath(indexPath) as! SongDetails
        
        // calculate % viewed time for each song from  data in song play history and song details entities
        // for each song
        
        let viewedTime = getViewedPercent(userId,songId: songs.songId,duration: songs.duration)
        
        // reset pevious images in the cell
        cell.imageView.image = nil
        
        // show activity indicator busy
        cell.backgroundColor = UIColor.blackColor()
        cell.imageView.image = UIImage(named: "placeholder")
        cell.activityIndicator.hidden = false
        cell.activityIndicator.startAnimating()
        cell.imageView.alpha = 0.5
        cell.songTitle.text = songs.title
        cell.duration.text = String(format:"%.2f",viewedTime)+"%"
        
        // If this image is already cached, don't re-download
        
        let pictureUrlString: NSString = songs.pictureUrl
        let picture: UIImage? = self.imageCache.valueForKey(pictureUrlString as String) as? UIImage
        
        if picture != nil {
            cell.imageView.image = picture
            cell.activityIndicator.hidden = true
            cell.activityIndicator.stopAnimating()
            cell.imageView.alpha = 0.0
            UIView.animateWithDuration(0.2,
                                       animations: { cell.imageView.alpha = 1.0 })
        }
        else {
            // The image isn't cached, download the img data
            // We should perform this in a background thread
            
            
            MusicClient.sharedInstance().getPictureForImageUrl(songs.pictureUrl, completionHandler: { (picture, error) in
                
                if error == nil{
                    self.imageCache[pictureUrlString] = picture
                    
                    // Update the cell
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageView.image = picture as? UIImage
                        cell.activityIndicator.hidden = true
                        cell.activityIndicator.stopAnimating()
                        cell.imageView.alpha = 0.0
                        UIView.animateWithDuration(0.2,
                            animations: { cell.imageView.alpha = 1.0 })
                        
                        
                    })
                    
                    
                }
                else {
                    self.showAlertView(" Unable to fetch  image for Music Leesons.Please check your Network connectivity ")
                }
            })
            
        }
        
        
        
        return cell
        
    }
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "SongDetails")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        fetchRequest.predicate = NSPredicate(format: "categoryName == %@", self.selectedCatg)
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: self.sharedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return fetchedResultsController
        
    }()
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    // set values for Sond=g Details screen for a selected song
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        
        let songs = fetchedResultsController.objectAtIndexPath(indexPath) as! SongDetails
        
        let (viewedDate,ViewedTime) = getViewedDate(userId,songId: songs.songId)
        
        let controller =
        storyboard!.instantiateViewControllerWithIdentifier("SongDetailsVC")
            as! SongDetailsViewController
        
        
        
        controller.lessonTitle = songs.title
        controller.ragam = songs.ragam
        controller.aarohana = songs.aarohana
        controller.avarohana = songs.avarohana
        controller.songDescription = songs.songDescription
        controller.songImage = songs.pictureUrl
        controller.videoUrl = songs.videoUrl
        controller.userId = userId
        controller.songId = songs.songId
        controller.lastViewed = viewedDate
        controller.playedTime = ViewedTime
        
        
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    // Fetch data from Song Details entity
    
    func fetchSongDetails(){
        
        var songDetails =  [String : AnyObject]()
        MusicClient.sharedInstance().getSongDetails{(result, error) in
            
            if error == nil {
                
                for (_,result) in (result?.enumerate())!{
                    
                    
                    let songDetailsResult = result as! GTLSongDetailsEndPointApiSongDetailsBean
                    
                    songDetails[SongDetails.Keys.categoryName] = songDetailsResult.categoryName
                    songDetails[SongDetails.Keys.aarohana] = songDetailsResult.aarohana
                    songDetails[SongDetails.Keys.avarohana] = songDetailsResult.avarohana
                    songDetails[SongDetails.Keys.duration] = songDetailsResult.duration
                    songDetails[SongDetails.Keys.aarohana] = songDetailsResult.aarohana
                    songDetails[SongDetails.Keys.pictureUrl] = songDetailsResult.pictureUrl
                    songDetails[SongDetails.Keys.ragam] = songDetailsResult.ragam
                    songDetails[SongDetails.Keys.videoUrl] = songDetailsResult.videoUrl
                    songDetails[SongDetails.Keys.title] = songDetailsResult.title
                    songDetails[SongDetails.Keys.songDescription] = songDetailsResult.details
                    songDetails[SongDetails.Keys.updatedDate] = songDetailsResult.updatedDate.date
                    songDetails[SongDetails.Keys.creationDate] = songDetailsResult.creationDate.date
                    songDetails[SongDetails.Keys.songId] = songDetailsResult.identifier
                    
                    _ = SongDetails(dictionary: songDetails, context: self.sharedContext)
                    
                    
                }
                
                self.saveContext()
            }
            else {
                self.showAlertView(" Unable to fetch   Music Leesons.Please check your Network connectivity ")
            }
            
        }
        
    }
    
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        
        switch type {
        case .Insert:
            addFetchedResultsProcessingBlock {self.collectionView!.insertItemsAtIndexPaths([newIndexPath!])}
        case .Update:
            addFetchedResultsProcessingBlock {self.collectionView!.reloadItemsAtIndexPaths([indexPath!])}
        case .Move:
            addFetchedResultsProcessingBlock {
                // If installsStandardGestureForInteractiveMovement is on
                // the UICollectionViewController will handle this on its own.
                guard !self.installsStandardGestureForInteractiveMovement else {
                    return
                }
                self.collectionView!.moveItemAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
            }
        case .Delete:
            addFetchedResultsProcessingBlock {self.collectionView!.deleteItemsAtIndexPaths([indexPath!])}
        }    }
    
    
    private func addFetchedResultsProcessingBlock(processingBlock:(Void)->Void) {
        fetchedResultsProcessingOperations.append(NSBlockOperation(block: processingBlock))
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        
        switch type {
        case .Insert:
            addFetchedResultsProcessingBlock {self.collectionView!.insertSections(NSIndexSet(index: sectionIndex))}
        case .Update:
            addFetchedResultsProcessingBlock {self.collectionView!.reloadSections(NSIndexSet(index: sectionIndex))}
        case .Delete:
            addFetchedResultsProcessingBlock {self.collectionView!.deleteSections(NSIndexSet(index: sectionIndex))}
        case .Move:
            break
        }
        
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        collectionView!.performBatchUpdates({ () -> Void in
            for operation in self.fetchedResultsProcessingOperations {
                operation.start()
            }
            }, completion: { (finished) -> Void in
                self.fetchedResultsProcessingOperations.removeAll(keepCapacity: false)
        })
    }
    
    deinit {
        for operation in fetchedResultsProcessingOperations {
            operation.cancel()
        }
        
        fetchedResultsProcessingOperations.removeAll()
    }
    
    
    
    /* fetch song play history details */
    
    func playHistoryFetchRequest(userId: Int64, songId: Int64) -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "SongPlayHistory")
        fetchRequest.sortDescriptors = []
        
        let predicate1:NSPredicate = NSPredicate(format: "userId == %@",String(userId))
        let predicate2:NSPredicate = NSPredicate(format:"songId == %@",String(songId))
        let predicate:NSPredicate  = NSCompoundPredicate(andPredicateWithSubpredicates: [predicate1,predicate2] )
        fetchRequest.predicate = predicate
        
        return fetchRequest
    }
    
    // Fecth Paly History Entity details
    
    func getplayHistoryFetchedResultController(userId: Int64, songId: Int64) -> NSFetchedResultsController {
        let fetchedResultController = NSFetchedResultsController(fetchRequest: playHistoryFetchRequest(userId,songId: songId), managedObjectContext:self.sharedContext, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    // Calculate  Video viewed %  based on total length of the video and  viewed time
    
    func getViewedPercent(userId: Int64, songId: Int64 , duration: Double) -> Double {
        
        
        // fetch song play history for each song
        
        var viewedPercent: Double = 0
        playHistoryfetchedResultController = getplayHistoryFetchedResultController(userId,songId: songId)
        playHistoryfetchedResultController.delegate = self
        do {
            try playHistoryfetchedResultController.performFetch()
        } catch {}
        
        
        for playHistory in playHistoryfetchedResultController.fetchedObjects! as! [SongPlayHistory] {
            
            viewedPercent = (playHistory.playedTime/(duration*60) ) * 100
            
            
        }
        
        
        return viewedPercent
        
    }
    
    // Get the last viewed Date from play history entity for selected song
    
    func getViewedDate(userId: Int64, songId: Int64 ) -> (NSDate , Double) {
        
        
        // fetch song play history for each song
        
        var viewedDate: NSDate =  NSDate()
        var totalViewed: Double = 0.0
        playHistoryfetchedResultController = getplayHistoryFetchedResultController(userId,songId: songId)
        playHistoryfetchedResultController.delegate = self
        do {
            try playHistoryfetchedResultController.performFetch()
        } catch {}
        
        
        for playHistory in playHistoryfetchedResultController.fetchedObjects! as! [SongPlayHistory] {
            
            viewedDate = playHistory.lastViewed
            totalViewed = playHistory.playedTime
            
        }
        
        return (viewedDate,totalViewed)
        
    }
    
    // Display Alert when no images retreived
    
    func showAlertView(errorMessage: String?) {
        
        let alertController = UIAlertController(title: nil, message: errorMessage!, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "Dismiss", style: .Cancel) {(action) in
            
        }
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true){
            
        }
        
    }
    
    
}