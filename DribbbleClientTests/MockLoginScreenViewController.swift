//
//  MockLoginScreenViewController.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockLoginScreenViewController: LoginScreenViewController {

    var showAuthenticationErrorMessageCalled    :Bool   =  false
    var showAuthenticatingCalled                :Bool   =  false
    
    
    var stubIndicator       :  UIActivityIndicatorView      =       UIActivityIndicatorView()
    var stubDribbbleButton  :  UIButton                     =       UIButton()
    
    override var indicator: UIActivityIndicatorView!
    {
        get{ return self.stubIndicator}
        set{}
    }
    
    
    override var dribbbleButton: UIButton!
    {
        get{ return self.stubDribbbleButton}
        set{}
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    override func showAuthenticationFailedMessage() {
        super.showAuthenticationFailedMessage()
        
        self.showAuthenticationErrorMessageCalled   =   true
    }
    
    override func showAuthenticating() {
        super.showAuthenticating()
        self.showAuthenticatingCalled   =   true
    }

 }
