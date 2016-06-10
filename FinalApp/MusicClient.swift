//
//  MusicClient.swift
//  FinalApp
//
//  Created by Janaki Burugula on May/29/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit



class MusicClient:NSObject {
    /* Shared Session */
    var session: NSURLSession
    
    typealias CompletionHander = (result: AnyObject!, error: NSError?) -> Void
    
    override init() {
        session = NSURLSession.sharedSession()
        super.init()
    }
    
    
    // MARK: - Shared Instance
    
    class func sharedInstance() -> MusicClient {
        
        struct Singleton {
            static var sharedInstance = MusicClient()
        }
        
        return Singleton.sharedInstance
    }
    
    
}


