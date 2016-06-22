//
//  UserInfoTableViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import Kingfisher

protocol ShotDetailCellPotocol {
    func configureWithShot( shot:Shot )
}


class UserInfoTableViewCell: UITableViewCell,ShotDetailCellPotocol {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var shotNameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.selectionStyle =   .None
    }

    
    func configureWithShot( shot:Shot )
    {
        self.shotNameLabel.text =   shot.title
        
        guard let user = shot.user else {return }
        
        self.userNameLabel.text =   "by \(user.name)"
        
        self.userImageView.layer.cornerRadius   =    self.userImageView.bounds.width / 4.0
        
        guard let avatar = user.avatar_url else {return}
        
        self.userImageView.kf_setImageWithURL(NSURL(string:avatar)!)
        
        
    }
    
}
