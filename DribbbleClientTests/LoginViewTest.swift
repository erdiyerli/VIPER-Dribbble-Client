//
//  LoginViewTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest

@testable import DribbbleClient

class LoginViewTest: XCTestCase
{
    
    var loginView   :MockLoginScreenViewController!
    var presenter   :MockLoginScreenPresenter!
    
    override func setUp()
    {
        super.setUp()
    
        self.loginView              =   MockLoginScreenViewController()
        
        self.presenter              =   MockLoginScreenPresenter()
        
        self.loginView.presenter    =   self.presenter
        self.presenter.view         =   self.loginView
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        self.loginView  =   nil
        self.presenter  =   nil
    }
    
    
    func testShouldCallAuthenticateOnPresenterWhenDribbbleButtonTapped()
    {
        self.loginView.dribbbleButtonTapped( NSObject() )
        
        XCTAssertTrue(self.presenter.authenticateCalled)
    }
    
    
    func testShouldShowIndicatorAndDisableButtonWhenAuthenticating()
    {
        self.loginView.showAuthenticating()
        
        XCTAssertFalse(self.loginView.stubIndicator.hidden)
        XCTAssertTrue(self.loginView.stubIndicator.isAnimating())
        XCTAssertFalse(self.loginView.stubDribbbleButton.userInteractionEnabled)
    }
    
    
    func testShouldHideIndicatorAndEnableButtonWhenAnErrorOccurred()
    {
        self.loginView.showAuthenticationFailedMessage()
        
        XCTAssertTrue(self.loginView.stubIndicator.hidden)
        XCTAssertFalse(self.loginView.stubIndicator.isAnimating())
        XCTAssertTrue(self.loginView.stubDribbbleButton.userInteractionEnabled)
    }
    
    func testShouldShowErrorMessageForAuthenticationError()
    {
        let nav     =   UINavigationController(rootViewController: self.loginView)
        
        let window  =   UIWindow(frame: CGRect.zero)
        window.rootViewController   =   nav
        
        window.makeKeyAndVisible()
        
        
        self.presenter.authenticationFailed(error: NSError(domain: "", code: 0, userInfo: nil))
        
        let controller  =       self.loginView.presentedViewController
        
        XCTAssertEqual(controller, self.loginView.alertView)
    }
    
}
