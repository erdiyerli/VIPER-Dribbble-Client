//
//  ShotDetailViewTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class ShotDetailViewTest: XCTestCase
{
    
    var shotDetailView  :MockShotDetailScreenViewController!
    var presenter       :MockShotDetailScenePresenter!
    
    override func setUp()
    {
        super.setUp()
        
        self.shotDetailView =   MockShotDetailScreenViewController()
        self.presenter      =   MockShotDetailScenePresenter()
        
        self.shotDetailView.presenter   =   self.presenter
        
        _ = self.shotDetailView.view
    }
    
    override func tearDown()
    {
        super.tearDown()
        
        self.shotDetailView =   nil
        self.presenter      =   nil
    }
    
    
    
    func testShoulSetupTableViewOnLoad()
    {
        _ = self.shotDetailView.view
        
        XCTAssertTrue(self.shotDetailView.setupTableViewCalled)
    }
    
    func testShouldReturnCorrectRowCountForRelatedSection()
    {
        self.shotDetailView.setupTableVIew()
        
        let userInfo    =   self.numberOfRowsInSection(.ShotDetailUserInfoSection)
        
        let shotImage    =   self.numberOfRowsInSection(.ShotDetailShotImageSection)
        
        let shotInfo    =   self.numberOfRowsInSection(.ShotDetailShotInfoSection)
        
        let comments    =   self.numberOfRowsInSection(.ShotDetailCommentsSection)
        
        self.shotDetailView.comments    =   []
        
        XCTAssertEqual(userInfo, 1)
        XCTAssertEqual(shotImage, 1)
        XCTAssertEqual(shotInfo, 1)
        XCTAssertEqual(comments, 0)
    }
    
    
    func testShouldAddShotDescriptionAsComment()
    {
        self.shotDetailView.comments    =   []
        
        self.shotDetailView.displayShot(self.shotDetailView.stubShot)
        
        XCTAssertTrue(self.shotDetailView.comments.count == 1)
    }
    
    
    func testShouldReturnRelatedCellForSection()
    {
        self.shotDetailView.setupTableVIew()
        
        let userInfo    =   self.cellForSection(.ShotDetailUserInfoSection)
        let shotImage    =   self.cellForSection(.ShotDetailShotImageSection)
        let shotInfo    =   self.cellForSection(.ShotDetailShotInfoSection)
        let comments    =   self.cellForSection(.ShotDetailCommentsSection)
        
        XCTAssertTrue( userInfo.isKindOfClass(UserInfoTableViewCell.self))
        XCTAssertTrue( shotImage.isKindOfClass(ShotImageTableViewCell.self))
        XCTAssertTrue( shotInfo.isKindOfClass(ShotInfoTableViewCell.self))
        XCTAssertTrue( comments.isKindOfClass(ShotCommentTableViewCell.self))
    }
    
    
    
    func testShoulCallFetchCommentsOnPresenterWhenNewShotGiven()
    {
        let shot    =   Shot()
        shot.id     =   0
        
        self.shotDetailView.displayShot(shot)
        
        XCTAssertTrue(self.presenter.fetchCommentsCalled)
    }
    
    
    
    
    
    //MARK: helpers
    
    
    func cellForSection(section:ShotDetailSection)->UITableViewCell
    {
        let cell    =   self.shotDetailView.tableView.dataSource!.tableView(self.shotDetailView.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: section.rawValue))
        
        return cell
    }
    
    func numberOfRowsInSection( section:ShotDetailSection)->Int
    {
        let numberOfRows    =   self.shotDetailView.tableView.dataSource!.tableView(self.shotDetailView.tableView, numberOfRowsInSection: section.rawValue)
        
        return numberOfRows
    }
    
    
}
