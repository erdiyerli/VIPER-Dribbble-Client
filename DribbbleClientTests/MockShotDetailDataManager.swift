//
//  MockShotDetailDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockShotDetailDataManager: ShotDetailScreenDataManager
{
    var commentsByCalled    :Bool   =   false
    
    override func commentsBy(shotID shotID: Int, commentsCount: Int) {
        
        super.commentsBy(shotID: shotID, commentsCount: commentsCount)
        
        self.commentsByCalled   =   true
    }
}
