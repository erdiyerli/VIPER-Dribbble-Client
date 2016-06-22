//
//  ShotInfoTableViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

class ShotInfoTableViewCell: UITableViewCell,ShotDetailCellPotocol {

    
    @IBOutlet weak var viewLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    
        self.selectionStyle =   .None
    }

    
    func configureWithShot(shot: Shot)
    {
        self.viewLabel.text      =   "\(shot.views_count) Views"
        self.commentLabel.text   =   "\(shot.comments_count) Comments"
        self.likeLabel.text      =   "\(shot.likes_count) Likes"
    }
    
}
