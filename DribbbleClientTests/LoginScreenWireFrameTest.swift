//
//  LoginScreenWireFrameTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest

@testable import DribbbleClient

class LoginScreenWireFrameTest: XCTestCase {
    
    var wireFrame               :MockLoginScreenWireFrame!
    var loginScreen             :LoginScreenViewController!
    var applicationWireFrame    :MockApplicationWireframe!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.wireFrame              =  MockLoginScreenWireFrame()
        self.loginScreen            =  LoginScreenViewController()
        self.applicationWireFrame   =  MockApplicationWireframe()
        
        self.wireFrame.applicationWireframe =   self.applicationWireFrame
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.wireFrame              =   nil
        self.loginScreen            =   nil
        self.applicationWireFrame   =   nil
    }
    
    func testShouldPresentLoginScreen()
    {
        
        let view    =   UIViewController()
        
        let window  =   UIWindow()
        window.rootViewController   =   view
        window.makeKeyAndVisible()
        
        self.wireFrame.presentLoginScreenModule(fromView: view, animated: false)
        
        self.loginScreen    =   view.presentedViewController as! LoginScreenViewController
        
        XCTAssertTrue(view.presentedViewController!.isKindOfClass(LoginScreenViewController.self))
        
        XCTAssertNotNil(self.loginScreen.presenter)
        
        XCTAssertNotNil(self.loginScreen.presenter?.interactor)
        XCTAssertNotNil(self.loginScreen.presenter?.wireFrame)
        XCTAssertNotNil(self.loginScreen.presenter?.view)
        
        XCTAssertNotNil(self.loginScreen.presenter?.interactor?.presenter)
        XCTAssertNotNil(self.loginScreen.presenter?.interactor?.dataManager)
        
        XCTAssertNotNil(self.loginScreen.presenter?.interactor?.dataManager?.interactor)
        XCTAssertNotNil(self.loginScreen.presenter?.interactor?.dataManager?.service)
    }
    
    
    func testInformApplicationWireframeForAuthentication()
    {
        self.wireFrame.authenticationSucceeded(view: self.loginScreen)
        
        XCTAssertTrue(self.applicationWireFrame.authenticationSucceededCalled)
    }
    
    
}
