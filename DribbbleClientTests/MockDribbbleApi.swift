//
//  MockDribbbleApi.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockDribbbleApi: DribbbleApi {

    var authenticateCalled  :Bool   =   false
    var fetchShotsCalled    :Bool   =   false
    var fetchCommentsCalled    :Bool   =   false
    
    var currentCompletion   :DribbbleServiceCompletionBlock!
    
    
    convenience init()
    {
        self.init(accessToken: "")
    }
    
    override func authenticateUser(completion: DribbbleServiceCompletionBlock) {
        
        
        
        self.currentCompletion  =   completion
        self.authenticateCalled =   true
    }
    
    override func fetchShots(with sorting: ShotSorting, page: Int, perPage: Int, completion: DribbbleServiceCompletionBlock) {
        
        self.currentCompletion  =   completion
        self.fetchShotsCalled   =   true
    }
    
    override func fetchComments(shotID shotID: Int, commentsCount:Int, completion: DribbbleServiceCompletionBlock) {
        
        self.currentCompletion  =   completion
        self.fetchCommentsCalled    =   true
    }
    
    
    func sendError(withError error:NSError)
    {
        self.currentCompletion(response: DribbbleServiceResponse.Error(error ))
    }
    
    func sendSuccess(withObject object:Any)
    {
        self.currentCompletion(response: DribbbleServiceResponse.Success( object ) )
        
    }
    
    
    
}
