//
//  MockLoginScreenWireFrame.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockLoginScreenWireFrame: LoginScreenWireFrame {

    var authenticationSucceededCalled   :Bool   =   false
    
    
    var stubLoginView       =   MockLoginScreenViewController()
    
    override var loginView: LoginScreenViewProtocol! { get{ return stubLoginView } set{}}
    
    override func authenticationSucceeded(view fromView: LoginScreenViewProtocol)
    {
        super.authenticationSucceeded(view: fromView)
     
        self.authenticationSucceededCalled  =   true
    }
    
}
