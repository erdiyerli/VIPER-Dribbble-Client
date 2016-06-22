//
//  ShotItemCollectionViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 01/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import Kingfisher

class ShotItemCollectionViewCell: UICollectionViewCell,ShotDetailCellPotocol {

    
    @IBOutlet weak var shotImageView: UIImageView!
    @IBOutlet weak var gifView      :UIView!
    
    func configureWithShot(shot: Shot) {
        
        guard let images = shot.images else {return}
        
        self.shotImageView.kf_setImageWithURL(NSURL(string: images.teaser)!, placeholderImage: nil, optionsInfo: [.Transition(ImageTransition.Fade(0.4))])
        
        self.gifView.hidden =   !shot.animated
        
    }

}
