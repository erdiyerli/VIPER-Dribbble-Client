//
//  MockLoginScreenPresenter.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockLoginScreenPresenter: LoginScreenPresenter
{
    var authenticateCalled  :Bool   =   false
    var authenticationFailedCalled  :Bool   =   false
    var authenticationSucceededCalled  :Bool   =   false
    
    override func authenticateAction() {
        super.authenticateAction()
        self.authenticateCalled =   true
    }
    
    
    override func authenticationSucceeded() {
        super.authenticationSucceeded()
        
        self.authenticationSucceededCalled  =   true
    }
    
    
    override func authenticationFailed(error error: NSError) {
        
        super.authenticationFailed(error: error)
        
        self.authenticationFailedCalled  =   true
    }
}
