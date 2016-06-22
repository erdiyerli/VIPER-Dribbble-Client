//
//  ErrorCollectionViewCell.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 01/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit


protocol ErrorCollectionViewCellDelegate:class {
    func errorCollectionViewCellDidTapTryAgain( cell collectionViewCell:ErrorCollectionViewCell )
}

class ErrorCollectionViewCell: UICollectionViewCell {

    weak var delegate:ErrorCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func tryAgainTapped(sender: AnyObject)
    {
        guard let delegate = self.delegate else {return}
        
        delegate.errorCollectionViewCellDidTapTryAgain(cell: self)
    }
}
