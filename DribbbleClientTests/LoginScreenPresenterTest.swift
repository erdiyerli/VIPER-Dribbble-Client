//
//  LoginScreenPresenterTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class LoginScreenPresenterTest: XCTestCase {
    
    var view        :MockLoginScreenViewController!
    var presenter   :MockLoginScreenPresenter!
    var interactor  :MockLoginScreenInteractor!
    var wireframe   :MockLoginScreenWireFrame!
    
    override func setUp()
    {
        super.setUp()
        
        self.view       =   MockLoginScreenViewController()
        self.presenter  =   MockLoginScreenPresenter()
        self.interactor =   MockLoginScreenInteractor()
        self.wireframe  =   MockLoginScreenWireFrame()
        
        
        self.presenter.interactor   =   self.interactor
        self.presenter.wireFrame    =   self.wireframe
        
        self.presenter.view         =   self.view
        self.interactor.presenter   =   self.presenter
        
        
        
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        self.view       =   nil
        self.presenter  =   nil
        self.interactor =   nil
        self.wireframe  =   nil
    }
    
    
    func testShouldCallAuthenticationOnInteractor()
    {
        self.presenter.authenticateAction()
        
        XCTAssertTrue(self.interactor.authenticateCalled)
    }
    
    
    func testShouldInformViewToShowAuthenticating()
    {
        self.presenter.authenticateAction()
        
        XCTAssertTrue(self.view.showAuthenticatingCalled)
    }
    
    func testShouldInformViewForAuthenticationError()
    {
        self.presenter.authenticationFailed(error: NSError(domain: "", code: 0, userInfo: nil))
        
        XCTAssertTrue(self.view.showAuthenticationErrorMessageCalled)
    }
    
    
    func testShouldInformWireFrameForAuthenticationSuccess()
    {
        self.presenter.authenticationSucceeded()
        
        XCTAssertTrue(self.wireframe.authenticationSucceededCalled)
    }
    
    
    
    
}
