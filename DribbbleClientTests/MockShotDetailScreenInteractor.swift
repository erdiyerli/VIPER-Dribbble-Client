//
//  MockShotDetailScreenInteractor.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockShotDetailScreenInteractor: ShotDetailScreenInteractor
{
    
    var fetchCommentCalled              :Bool   =   false
    var commentsByShotIDCompletedCalled :Bool   =   false

    override func fetchComments(shotID shotID: Int, commentsCount: Int) {
        
        super.fetchComments(shotID: shotID, commentsCount: commentsCount)
        
        self.fetchCommentCalled =   true
    }
    
    override func commentsByShotIDCompleted(response response: DribbbleServiceResponse)
    {
        super.commentsByShotIDCompleted(response: response)
        
        self.commentsByShotIDCompletedCalled    =   true
    }
    
}
