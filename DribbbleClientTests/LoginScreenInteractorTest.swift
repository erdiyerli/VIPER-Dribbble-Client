//
//  LoginScreenInteractorTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 26/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest

@testable import DribbbleClient

class LoginScreenInteractorTest: XCTestCase
{
    
    var interactor  :   LoginScreenInteractor!
    var presenter   :   MockLoginScreenPresenter!
    var dataManager :   MockLoginScreenDataManager!
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        self.dataManager    =   MockLoginScreenDataManager()
        self.interactor     =   LoginScreenInteractor()
        self.presenter      =   MockLoginScreenPresenter()
        
        
        self.presenter.interactor   =   self.interactor
        
        self.interactor.presenter   =   self.presenter
        self.interactor.dataManager =   self.dataManager
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testShouldCallDataManagerForAuthentication()
    {
        self.interactor.doAuthentication()
        
        XCTAssertTrue(self.dataManager.authenticateCalled)
    }
    
    
    func testShouldCallPresenterForAuthenticationFailure()
    {
        self.interactor.authenticationFailed(error: NSError(domain: "", code: 0, userInfo: nil))
        
        XCTAssertTrue(self.presenter.authenticationFailedCalled)
    }
    
    func testShouldCallPresenterForAuthenticationSuccess()
    {
        self.interactor.authenticationSucceeded(accessToken: "")
        
        XCTAssertTrue(self.presenter.authenticationSucceededCalled)
    }
    
}
