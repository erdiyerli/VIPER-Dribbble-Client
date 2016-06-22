//
//  ShotsScreenInteractorTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient


/*
 
 
 */

class ShotsScreenInteractorTest: XCTestCase
{
    var interactor  :ShotsScreenInteractor!
    var presenter   :MockShotsScreenPresenter!
    var dataManager :MockShotsScreenDataManager!
    
    override func setUp()
    {
        super.setUp()
    
        
        self.interactor =   ShotsScreenInteractor()
        self.presenter  =   MockShotsScreenPresenter()
        self.dataManager    =   MockShotsScreenDataManager()
        
        self.interactor.presenter   =   self.presenter
        self.interactor.dataManager =   self.dataManager
        self.presenter.interactor   =   self.interactor
    }
    
    override func tearDown()
    {
    
        super.tearDown()
    }
    
    
    
    func testShouldCallFetchShotsOnDataManager()
    {
        let sorting =   ShotSorting(sort: .Popular)
        
        self.interactor.fetchShots(with: sorting)
        
        XCTAssertTrue(self.dataManager.fetchShotsCalled)
        
        XCTAssertEqual(self.interactor.currentSorting, sorting)
    }
    
    
    func testShouldIncreasePagingWhenLoadMoreCalled()
    {
        let sorting =   ShotSorting(sort: .Recent)
        let paging  =   1
        
        self.interactor.fetchShots(with: sorting)
        
        XCTAssertEqual(self.dataManager.currentSorting, sorting)
        XCTAssertEqual(self.dataManager.currentPage, paging)
        
        
        self.interactor.loadMoreShots()
        
        XCTAssertEqual(self.dataManager.currentSorting, sorting)
        XCTAssertEqual(self.dataManager.currentPage, paging + 1)
    }
    
    
    func testShouldResetPagingIfSortingIsDifferent()
    {
        let sorting =   ShotSorting(sort: .Recent)
        let newSorting =   ShotSorting(sort: .Popular)
        let paging  =   1
        
        self.interactor.fetchShots(with: sorting)
        
        self.interactor.loadMoreShots()
        
        XCTAssertEqual(self.dataManager.currentPage, paging + 1)

        
        self.interactor.fetchShots(with: newSorting)
        
        XCTAssertEqual(self.dataManager.currentSorting, newSorting)
        XCTAssertEqual(self.dataManager.currentPage, paging )
            
        
    }
    
    
    func testShouldInformPresenterForError()
    {
        self.interactor.fetchingShotsCompleted(with: .Error(NSError(domain: "", code: 0, userInfo: nil)))
        
        
        XCTAssertTrue(self.presenter.errorFoundCalled)
    }
    
    
    func testShouldInformPresenterForShots()
    {
        let shots   =   [Shot(),Shot(),Shot()]
        
        self.interactor.fetchingShotsCompleted(with: .Success(shots))
        
        XCTAssertTrue(self.presenter.shotsFoundCalled)
        XCTAssertEqual(self.presenter.foundShots!.count, shots.count)
    }
    
    
}
