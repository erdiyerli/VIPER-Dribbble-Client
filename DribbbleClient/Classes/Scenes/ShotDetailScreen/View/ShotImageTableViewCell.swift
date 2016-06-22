//
//  ShotImageTableViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import Kingfisher

class ShotImageTableViewCell: UITableViewCell,ShotDetailCellPotocol {

    @IBOutlet weak var shotImage: AnimatedImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.selectionStyle =   .None
        
    }


    
    func configureWithShot(shot: Shot)
    {
        
        guard !self.shotImage.isAnimating() else {return }
        
        
        guard let images = shot.images else {return}
        
        var url =   images.normal
        
        if let hidpi = images.hidpi
        {
            url =   hidpi
        }
        
        self.shotImage.kf_setImageWithURL(NSURL(string: url )!)
    }
}
