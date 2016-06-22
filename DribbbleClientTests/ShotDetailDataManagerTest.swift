//
//  ShotDetailDataManagerTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class ShotDetailDataManagerTest: XCTestCase
{
    
    var dataManager :ShotDetailScreenDataManager!
    var interactor  :MockShotDetailScreenInteractor!
    var api         :MockDribbbleApi!
    
    override func setUp() {
        super.setUp()
        
        self.dataManager    =   ShotDetailScreenDataManager()
        self.interactor     =   MockShotDetailScreenInteractor()
        self.api            =   MockDribbbleApi()
        
        
        self.dataManager.interactor =   self.interactor
        self.dataManager.api        =   self.api
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.dataManager    =   nil
        self.interactor     =   nil
        self.api            =   nil
    }
    
    
    func testShouldInformInteractorForServiceResponse()
    {
        self.dataManager.commentsBy(shotID: 0, commentsCount: 0)
        
        self.api.sendSuccess(withObject: [Comment()])
        
        XCTAssertTrue(self.interactor.commentsByShotIDCompletedCalled)
    }
    
    
}
