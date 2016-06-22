//
//  MockLoginScreenInteractor.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockLoginScreenInteractor: LoginScreenInteractor
{
    var authenticateCalled  :Bool   =   false
    var authenticationFailedCalled  :Bool   =   false
    var authenticationSucceededCalled  :Bool   =   false
    
    override func doAuthentication() {
        
        super.doAuthentication()
        
        authenticateCalled  =   true
    }
    
    override func authenticationFailed(error error: NSError) {
        
        super.authenticationFailed(error: error)
        
        self.authenticationFailedCalled =   true
    }
    
    override func authenticationSucceeded(accessToken accessToken: String) {
        
        super.authenticationSucceeded(accessToken: accessToken)
        
        self.authenticationSucceededCalled  =   true
    }
}

