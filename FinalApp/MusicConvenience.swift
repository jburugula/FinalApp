//
//  MusicConvenience.swift
//  FinalApp
//
//  Created by Janaki Burugula on May/29/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation


extension MusicClient {
    
    /* get Song Categories */
    
    func getCategories(completionHandler: (result: [AnyObject]?, error: NSError?) -> Void){
        
        var catgservice: GTLServiceSongCategoryEndPointApi? = nil
        if catgservice == nil {
            catgservice = GTLServiceSongCategoryEndPointApi()
            catgservice?.retryEnabled = true
        }
        
        let catgquery : GTLQuerySongCategoryEndPointApi = GTLQuerySongCategoryEndPointApi.queryForGetCategoriesWithAfter(0)
        _ = catgservice!.executeQuery(catgquery, completionHandler: { (catgticket: GTLServiceTicket!, catgobject: AnyObject!, error: NSError!) -> Void in
            
            if (catgobject == nil) {
                completionHandler(result: nil, error: NSError(domain: "Music Categories", code: 0, userInfo: [NSLocalizedDescriptionKey: "Music categories not found."]))
                
            }
            else {
                let catgresp : GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean = catgobject as! GTLSongCategoryEndPointApiCollectionResponseSongCategoryBean
                
                completionHandler(result: catgresp.items(), error: nil)
                
            }
            
        })
        
    }
    
    /* get Song Details */
    
    
    func getSongDetails(completionHandler: (result: [AnyObject]?, error: NSError?) -> Void){
        
        var songservice: GTLServiceSongDetailsEndPointApi? = nil
        if songservice == nil {
            songservice = GTLServiceSongDetailsEndPointApi()
            songservice?.retryEnabled = true
        }
        
        let songquery : GTLQuerySongDetailsEndPointApi = GTLQuerySongDetailsEndPointApi.queryForGetAllSongsDetailsWithAfter(0)
        _ = songservice!.executeQuery(songquery, completionHandler: { (songticket: GTLServiceTicket!, songobject: AnyObject!, error: NSError!) -> Void in
            
            if (songobject == nil) {
                completionHandler(result: nil, error: NSError(domain: "Song Details", code: 0, userInfo: [NSLocalizedDescriptionKey: "Song Details not found."]))
                
            }
            else {
                let songresp : GTLSongDetailsEndPointApiCollectionResponseSongDetailsBean = songobject as! GTLSongDetailsEndPointApiCollectionResponseSongDetailsBean
                
                completionHandler(result: songresp.items(), error: nil)
                
            }
            
        })
        
    }
    
    
}
