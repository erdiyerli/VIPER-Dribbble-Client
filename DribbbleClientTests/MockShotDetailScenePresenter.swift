//
//  MockShotDetailScenePresenter.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockShotDetailScenePresenter: ShotDetailScreenPresenter
{
    var fetchCommentsCalled :Bool   =   false
    
    override func fetchCommentsAction(shotID shotID: Int, commentsCount: Int) {
        
        super.fetchCommentsAction(shotID: shotID, commentsCount:commentsCount)
        
        self.fetchCommentsCalled    =   true
    }
}
