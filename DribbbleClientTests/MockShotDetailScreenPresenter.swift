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
    var configureViewCalled           :Bool   =   false
    var commentsFoundCalled         :Bool   =   false
    var fetchCommentActionCalled    :Bool   =   false
    
    var foundComments   :[Comment]?
    
    override func configureView(withShot shot: Shot)
    {
        super.configureView(withShot: shot)
        
        self.configureViewCalled    =   true
    }
    
    override func commentsFound(comments: [Comment]) {
        super.commentsFound(comments)
        
        self.commentsFoundCalled    =   true
        self.foundComments          =   comments
    }
    
    override func fetchCommentsAction(shotID shotID: Int, commentsCount: Int) {
        
        super.fetchCommentsAction(shotID: shotID, commentsCount: commentsCount)
        
        self.fetchCommentActionCalled   =   true
    }
    
}
