//
//  ShotCommentTableViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import Kingfisher


class ShotCommentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userCommentLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.selectionStyle =   .None
        
        self.userCommentLabel.numberOfLines     =   0
        
        self.userImageView.layer.cornerRadius   =   self.userImageView.bounds.width / 4.0
    }

    func configureWithComment(comment:Comment, isOdd:Bool)
    {
        
        var color = CommentCellColor.Light.color
        
        if !isOdd { color = CommentCellColor.Dark.color}
        
        self.contentView.backgroundColor    =   color
        
        
        self.userCommentLabel.attributedText  =   comment.attributedContent!
        
        self.userCommentLabel.sizeToFit()
        
        guard let user = comment.user else {return}
        
        self.userNameLabel.text =   user.username
        self.userNameLabel.sizeToFit()
        
        self.userImageView.kf_setImageWithURL(NSURL(string: user.avatar_url)!)
        
    }
}
