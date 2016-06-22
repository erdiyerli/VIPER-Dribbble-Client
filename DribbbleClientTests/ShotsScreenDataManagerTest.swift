//
//  DataManagerTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class ShotsScreenDataManagerTest: XCTestCase
{
    
    var dataManager :ShotsScreenDataManager!
    var interactor  :MockShotsScreenInteractor!
    var api         :MockDribbbleApi!
    
    override func setUp()
    {
        super.setUp()
    
        self.dataManager    =   ShotsScreenDataManager()
        self.interactor     =   MockShotsScreenInteractor()
        self.api            =   MockDribbbleApi()
        
        self.dataManager.interactor =   self.interactor
        self.dataManager.api        =   self.api
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    
    
    func testShouldInformInteractorWithSuccess()
    {
        let sorting = ShotSorting(sort: .Popular)
        
        let shots   =   [Shot(),Shot()]
        
        self.dataManager.fetchShots(with: sorting, page: 0, perPage: 0)
        
        self.api.sendSuccess(withObject: shots )
        
        XCTAssertTrue(self.interactor.fetchingShotsCompleted)
        XCTAssert(self.interactor.currentResponse! == DribbbleServiceResponse.Success(shots))
    }
    
    
    func testShouldInformInteractorWithError()
    {
        let sorting = ShotSorting(sort: .Popular)
        
        let error   =   NSError(domain: "", code: 0, userInfo: nil)
        
        self.dataManager.fetchShots(with: sorting, page: 1, perPage: 0)
        
        self.api.sendError(withError: error)
        
        XCTAssertTrue(self.interactor.fetchingShotsCompleted)
        XCTAssert(self.interactor.currentResponse! == DribbbleServiceResponse.Error(error))
    }
    
}
