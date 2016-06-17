//
//  MusicCollectionViewCell.swift
//  FinalApp
//
//  Created by Janaki Burugula on Jun/04/2016.
//  Copyright © 2016 janaki. All rights reserved.
//

import Foundation
import UIKit

class MusicCollectionViewCell : UICollectionViewCell {
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var songTitle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var duration: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
     
    }
}
