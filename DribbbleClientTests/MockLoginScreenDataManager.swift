//
//  MockLoginScreenDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockLoginScreenDataManager: LoginScreenDataManager {

    var authenticateCalled  :Bool = false
    
    
    override func authenticate() {
        super.authenticate()
        
        self.authenticateCalled =   true
    }
}
