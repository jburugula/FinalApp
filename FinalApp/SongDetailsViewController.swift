//
//  SongDetailsViewController.swift
//  FinalApp
//
//  Created by Janaki Burugula on Jun/04/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import MediaPlayer

class SongDetailsViewController: UIViewController  {
    
    
    var lessonTitle: String!
    var ragam: String!
    var aarohana: String!
    var avarohana: String!
    var duration: String!
    var songDescription: String!
    var songImage: String!
    var videoUrl: String!
    var songId: Int64!
    var userId: Int64!
    var playedTime: Double!
    var lastViewed: NSDate!
    
    
    @IBOutlet weak var songDetails: UILabel!
    @IBOutlet weak var songPicture: UIImageView!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var songLastViewed: UILabel!
    @IBOutlet weak var songAvarohana: UILabel!
    @IBOutlet weak var songAarohana: UILabel!
    @IBOutlet weak var songRagam: UILabel!
    @IBOutlet weak var songTitle: UILabel!
    @IBAction func playVideo(sender: AnyObject) {
        
        
        let songDetailVC = storyboard?.instantiateViewControllerWithIdentifier("lessonVideo") as! SongVideoPlayerController
        
        let url:NSURL = NSURL(string: videoUrl)!
        
        songDetailVC.currentUserId = userId
        songDetailVC.currentSongId = songId
        songDetailVC.player = AVPlayer(URL: url)
        
        let startTime = CMTimeMakeWithSeconds(playedTime,60000);
        
        songDetailVC.player?.seekToTime(startTime)
        
        self.presentViewController(songDetailVC, animated: true){
            songDetailVC.player!.play() }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib
       
        var DateInFormat:String = ""
          let dateFormatter:NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        if lastViewed != nil{
              DateInFormat = dateFormatter.stringFromDate(lastViewed)
            
        }
        
        
        songTitle.text = lessonTitle
        songRagam.text = ragam
        songAarohana.text = aarohana
        songAvarohana.text = avarohana
        songLastViewed.text =  DateInFormat
        
        /* set the properties to display song description in multi line */
        
        songDetails.numberOfLines = 0
        songDetails.sizeToFit()
        songDetails.text = songDescription.stringByReplacingOccurrencesOfString("\\n", withString: "\n");
        
        /* set the image for the song */
        
        let fileURL =   NSURL(string: songImage)!
        if let data = NSData(contentsOfURL:fileURL){
            let picture = UIImage(data: data)
            songPicture.image = picture
            
        }
        
    }
    
    
}
