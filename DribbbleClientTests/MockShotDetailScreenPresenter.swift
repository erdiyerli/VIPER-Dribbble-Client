//
//  MockShotDetailScreenPresenter.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotDetailScreenPresenter: ShotDetailScreenPresenter
{
    var displayShotCalled           :Bool   =   false
    var commentsFoundCalled         :Bool   =   false
    var fetchCommentActionCalled    :Bool   =   false
    
    var foundComments   :[Comment]?
    
    override func displayShot(shot shot: Shot)
    {
        super.displayShot(shot: shot)
        
        self.displayShotCalled  =   true
    }
    
    override func commentsFound(comments: [Comment]) {
        super.commentsFound(comments)
        
        self.commentsFoundCalled    =   true
    }
    
    override func fetchCommentsAction(shotID shotID: Int, commentsCount: Int) {
        
        super.fetchCommentsAction(shotID: shotID, commentsCount: commentsCount)
        
        self.fetchCommentActionCalled   =   true
    }
    
}
