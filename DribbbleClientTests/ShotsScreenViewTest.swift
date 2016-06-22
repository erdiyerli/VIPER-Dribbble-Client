//
//  ShotsScreenViewTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 02/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class ShotsScreenViewTest: XCTestCase {
    
    var shotScreen  :MockShotsScreenViewController!
    var shotScreenPresenter :MockShotsScreenPresenter!
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.shotScreen                 =   MockShotsScreenViewController()
        self.shotScreenPresenter        =   MockShotsScreenPresenter()
        
        self.shotScreen.presenter       =   self.shotScreenPresenter
        
        self.shotScreenPresenter.view   =   self.shotScreen
        
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.shotScreen =   nil
        self.shotScreenPresenter    =   nil
    }
    
    func testShouldCallSetupOnLoad()
    {
        _ = self.shotScreen.view
        
        XCTAssertTrue(self.shotScreen.setupCalled)
    }
    
    
    func testShouldInitialiseView()
    {
        self.shotScreen.initialise()
        
        XCTAssertNil(self.shotScreen.shots)
        
        XCTAssertEqual(self.shotScreen.controllerState, ViewControllerState.Loading)
        
        XCTAssertEqual(self.shotScreen.stubsortControl.selectedSegmentIndex, 0)
        
        XCTAssertEqual(self.shotScreen.stubCollectionView.contentOffset.y, 0.0)
        
        XCTAssertTrue(self.shotScreenPresenter.sortShotsActionCalled)
    }
    
    
    func testShouldComformCollectionDelegateAfterSetupCalled()
    {
        _ = self.shotScreen.view
        
        
        XCTAssertTrue(self.shotScreen.stubCollectionView.delegate!.isKindOfClass(MockShotsScreenViewController.self))
        XCTAssertTrue(self.shotScreen.stubCollectionView.dataSource!.isKindOfClass(MockShotsScreenViewController.self))
    }
   
    
    func testShouldUseLoadingCellWhenDisplayLoadingCalled()
    {
        self.shotScreen.setupCollectionView()
        
        self.shotScreen.displayLoading()
        
        
        let numberOfItems    =   self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, numberOfItemsInSection: 0)
        
        let cell:UICollectionViewCell            =   (self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, cellForItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)))!
        
        XCTAssertEqual( numberOfItems, 1  )
        
        XCTAssert(cell is LoadingCollectionViewCell)
        
        
    }
    
    
    func testShouldUseErrorCellWhenDisplayErrorCalled()
    {
        
        self.shotScreen.setupCollectionView()
        
        self.shotScreen.displayError(error: nil)
        
        
        let numberOfItems    =   self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, numberOfItemsInSection: 0)
        
        let cell:UICollectionViewCell            =   (self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, cellForItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)))!

        XCTAssertEqual( numberOfItems, 1  )
        
        XCTAssertTrue(cell is ErrorCollectionViewCell)
        
        
    }
    
    
    
    func testShouldUseShotItemCellWhenDisplayShotsCalled()
    {
        
        self.shotScreen.setupCollectionView()
        
        let shots   =   [Shot(),Shot(),Shot()]
        
        self.shotScreen.displayShots(shots: shots)
        
        
        let numberOfItems   =   self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, numberOfItemsInSection: 0)
        
        
        XCTAssertEqual(numberOfItems, 3)
        
        let cell:UICollectionViewCell            =   (self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, cellForItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0)))!
        
        
        XCTAssertTrue(cell is ShotItemCollectionViewCell)
        
        
    }
    
    
    
    
    func testShouldAppendNewShotsToCurentShots()
    {
        self.shotScreen.setupCollectionView()
        
        let shots   =   [Shot(),Shot(),Shot()]
        
        self.shotScreen.displayShots(shots: shots)
        
        var numberOfItems   =   self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, numberOfItemsInSection: 0)
        
        
        XCTAssertEqual(numberOfItems, 3)
        
        
        self.shotScreen.displayShots(shots: shots)
        
        numberOfItems   =   self.shotScreen.stubCollectionView.dataSource?.collectionView(self.shotScreen.stubCollectionView, numberOfItemsInSection: 0)
        
        
        XCTAssertEqual(numberOfItems, 6)
        
    }
    
    func testShouldDisableLoadMoreAction()
    {
        self.shotScreen.disableLoadingMoreAction()
        
        XCTAssertFalse(self.shotScreen.loadMoreActionEnabled)
    }
    
    
    
    func testShouldCallPresenterWhenAnItemSelected()
    {
        self.shotScreen.setupCollectionView()
        
        let shot    =   Shot()
        shot.title  =   "new shot"
        
        self.shotScreen.displayShots(shots: [shot])
        
        self.shotScreen.stubCollectionView.delegate!.collectionView!(self.shotScreen.stubCollectionView, didSelectItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        
        XCTAssertTrue(self.shotScreenPresenter.shotsSelectedActionCalled)
        
        XCTAssert(self.shotScreenPresenter.selectedShot!.title == "new shot")
    }
    
    
    func testShouldUseRelatedSortingWhenSortingControllerValueChanged()
    {
        // 0 for popular sorting must be nil
        self.shotScreen.stubsortControl.selectedSegmentIndex    =   0
        
        self.shotScreen.sortingControllerValueChanged(self.shotScreen.stubsortControl)
        
        XCTAssertTrue(self.shotScreenPresenter.sortShotsActionCalled)
        XCTAssertEqual(self.shotScreenPresenter.sortType, ShotSorting(sort: .Popular))
        
        
        // 0 for popular sorting must be nil
        self.shotScreen.stubsortControl.selectedSegmentIndex    =   1
        
        self.shotScreen.sortingControllerValueChanged(self.shotScreen.stubsortControl)
        
        XCTAssertTrue(self.shotScreenPresenter.sortShotsActionCalled)
        XCTAssertEqual(self.shotScreenPresenter.sortType, ShotSorting(sort: .Recent))
    }
    
    
    func testControllerStateShouldBeLoadingWhenSortingControllerValueChanged()
    {
        // 0 for popular sorting must be nil
        self.shotScreen.stubsortControl.selectedSegmentIndex    =   0
        
        self.shotScreen.sortingControllerValueChanged(self.shotScreen.stubsortControl)
        
        XCTAssertEqual(self.shotScreen.controllerState, ViewControllerState.Loading)
        

    }
    
    func testSortingControllerShouldBeUnselectableDuringFething()
    {
        self.shotScreen.fetchShots(sorting: ShotSorting(sort: .Popular))
        
        XCTAssertFalse(self.shotScreen.stubsortControl.userInteractionEnabled)
    }
    
    
    
    func testCellShouldHaveFullSizeWhenLoadingOrErrorState()
    {
        let expectedSize    = self.shotScreen.stubCollectionView.bounds.size
        
        self.shotScreen.controllerState =   .Loading
        
        self.shotScreen.stubCollectionView.reloadData()
        
        var cellSize        =   self.shotScreen.collectionView(self.shotScreen.stubCollectionView, layout: self.shotScreen.stubCollectionView.collectionViewLayout, sizeForItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        
        XCTAssertEqual(expectedSize, cellSize)
        
        
        self.shotScreen.controllerState =   .Error
        
        self.shotScreen.stubCollectionView.reloadData()
        
        
        cellSize        =   self.shotScreen.collectionView(self.shotScreen.stubCollectionView, layout: self.shotScreen.stubCollectionView.collectionViewLayout, sizeForItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        
        
        XCTAssertEqual(expectedSize, cellSize)

        
        
    }
    
}





