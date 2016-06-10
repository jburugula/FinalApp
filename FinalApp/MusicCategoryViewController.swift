//
//  MusicCategoryViewController.swift
//  FinalApp
//
//  Created by Janaki Burugula on May/10/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MusicCategoryViewController : UITableViewController,NSFetchedResultsControllerDelegate {
    
    var userId: Int64!
    
    
    @IBOutlet var musicCatgTableView: UITableView!
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {}
        
        // this class is NSFetchedResultsControllerDelegate
        fetchedResultsController.delegate = self
        
        // check if the categories are already loaded
        
        if fetchedResultsController.fetchedObjects?.count == nil || fetchedResultsController.fetchedObjects?.count == 0 {
            
            fetchMusicCategories()
            
        }
        
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // Return number of Rows
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        _ = self.fetchedResultsController.sections![section]
        return (fetchedResultsController.fetchedObjects?.count)!
    }
    
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let CellIdentifier = "CategoryTableViewCell"
            let songCategories = fetchedResultsController.objectAtIndexPath(indexPath) as! MusicCategories
            let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as!
            CategoryTableViewCell
            cell.nameLabel.text = songCategories.categoryName
            return cell
            
    }
    
    // Show list of songs for a selected category 
    
    override func tableView(tableView: UITableView,
        didSelectRowAtIndexPath indexPath: NSIndexPath) {
            let controller =
            storyboard!.instantiateViewControllerWithIdentifier("MusicLessonCollectionVC")
                as! MusicLessonCollectionViewController
            
            let songCategories = fetchedResultsController.objectAtIndexPath(indexPath) as! MusicCategories
            
            controller.selectedCatg = songCategories.categoryName
            
            controller.userId = userId
            
            self.navigationController?.pushViewController(controller, animated: true)
            
    }
    
    
    var sharedContext: NSManagedObjectContext {
        return CoreDataStackManager.sharedInstance().managedObjectContext
    }
    
    // Fetch data from Music Categories Entity
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        
        let fetchRequest = NSFetchRequest(entityName: "MusicCategories")
        
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "categoryLevel", ascending: true)]
        
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: self.sharedContext,
            sectionNameKeyPath: nil,
            cacheName: nil)
        
        return fetchedResultsController
        
    }()
    
    func saveContext() {
        CoreDataStackManager.sharedInstance().saveContext()
    }
    
    func fetchMusicCategories(){
        
        var songcatg =  [String : AnyObject]()
        MusicClient.sharedInstance().getCategories{(result, error) in
            
            if error == nil {
                
                for (_,result) in (result?.enumerate())!{
                    
                    let catgResult = result as! GTLSongCategoryEndPointApiSongCategoryBean
                    
                    songcatg[MusicCategories.Keys.categoryName] = catgResult.name
                    songcatg[MusicCategories.Keys.categoryLevel] = catgResult.level
                    songcatg[MusicCategories.Keys.updatedDate] = catgResult.updatedDate.date
                    songcatg[MusicCategories.Keys.creationDate] = catgResult.creationDate.date
                    songcatg[MusicCategories.Keys.categoryId] = catgResult.identifier
                    
                    _ = MusicCategories(dictionary: songcatg, context: self.sharedContext)
                    
                }
                
                self.saveContext()
            }
            
        }
        do_table_refresh()
        
    }
    
    func do_table_refresh()
    {
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
            return
        })
    }
    
    // MARK: NSFetchedResultsControllerDelegate methods
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(
        controller: NSFetchedResultsController,
        didChangeObject anObject: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            switch type {
            case NSFetchedResultsChangeType.Insert:
                if let insertIndexPath = newIndexPath {
                    self.tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            case NSFetchedResultsChangeType.Delete:
                if let deleteIndexPath = indexPath {
                    self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            case NSFetchedResultsChangeType.Update:
                if let updateIndexPath = indexPath {
                    let cell = self.tableView.cellForRowAtIndexPath(updateIndexPath)
                    let catg = self.fetchedResultsController.objectAtIndexPath(updateIndexPath) as? MusicCategories
                    
                    cell!.textLabel!.text = catg!.categoryName
                    
                }
            case NSFetchedResultsChangeType.Move:
                if let deleteIndexPath = indexPath {
                    self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
                if let insertIndexPath = newIndexPath {
                    self.tableView.insertRowsAtIndexPaths([insertIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                }
            }
    }
    
    
    
    func controller(controller: NSFetchedResultsController, sectionIndexTitleForSectionName sectionName: String) -> String? {
        return sectionName
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
 

    
}