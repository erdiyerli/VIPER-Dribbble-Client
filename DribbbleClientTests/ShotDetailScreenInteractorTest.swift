//
//  ShotDetailScreenInteractorTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient

class ShotDetailScreenInteractorTest: XCTestCase {
    
    var interactor  :ShotDetailScreenInteractor!
    var presenter   :MockShotDetailScreenPresenter!
    var dataManager :MockShotDetailDataManager!
    
    override func setUp()
    {
        super.setUp()
    
        
        self.interactor =   ShotDetailScreenInteractor()
        self.presenter  =   MockShotDetailScreenPresenter()
        self.dataManager =  MockShotDetailDataManager()
        
        
        self.interactor.dataManager =   self.dataManager
        self.interactor.presenter   =   self.presenter
        
    }
    
    override func tearDown() {
    
        super.tearDown()
        
        self.dataManager    =   nil
        self.interactor     =   nil
        self.presenter      =   nil
    }
    
    
    
    func testShouldInformDataManagerForComments()
    {
        self.interactor.fetchComments(shotID: 0, commentsCount: 0)
        
        XCTAssertTrue(self.dataManager.commentsByCalled)
    }
    
    
    func testShouldInformPresenterWhenCommentsCompleted()
    {
        self.interactor.commentsByShotIDCompleted(response: .Success([ Comment() ]))
        
        XCTAssertTrue(self.presenter.commentsFoundCalled)
    }
    
    
}
