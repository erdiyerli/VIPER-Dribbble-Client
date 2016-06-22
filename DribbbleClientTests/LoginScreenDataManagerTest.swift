//
//  LoginScreenDataManagerTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest

@testable import DribbbleClient

class LoginScreenDataManagerTest: XCTestCase {
    
    var interactor  :   MockLoginScreenInteractor!
    var dataManager :   MockLoginScreenDataManager!
    var service     :   MockDribbbleApi!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        self.interactor     =   MockLoginScreenInteractor()
        self.dataManager    =   MockLoginScreenDataManager()
        self.service        =   MockDribbbleApi()
        
        self.interactor.dataManager =   self.dataManager
        self.dataManager.interactor =   self.interactor
        
        self.dataManager.service    =   self.service
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testShouldCallAuthenticationOnApi()
    {
        self.dataManager.authenticate()
        
        XCTAssertTrue(self.service.authenticateCalled)
    }
    
    func testShouldInforInteractorForAuthenticationError()
    {
        let error   =   NSError(domain: "", code: 0, userInfo: nil)
        
        self.dataManager.authenticate()
        self.service.sendError(withError: error)
        
        XCTAssertTrue(self.interactor.authenticationFailedCalled)
    }
    
    func testShouldInforInteractorForAuthenticationSuccess()
    {
        
        self.dataManager.authenticate()
        self.service.sendSuccess(withObject: "")
        
        XCTAssertTrue(self.interactor.authenticationSucceededCalled)
    }
    
}
