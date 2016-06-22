//
//  ShotDetailScreenPresenterTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest
@testable import DribbbleClient
class ShotDetailScreenPresenterTest: XCTestCase {
    
    var view        :MockShotDetailScreenViewController!
    var presenter   :ShotDetailScreenPresenter!
    var wireframe   :MockShotDetailScreenWireframe!
    var interactor  :MockShotDetailScreenInteractor!
    
    override func setUp() {
        super.setUp()
        
        
        self.view       =   MockShotDetailScreenViewController()
        self.presenter  =   ShotDetailScreenPresenter()
        self.wireframe  =   MockShotDetailScreenWireframe()
        self.interactor =   MockShotDetailScreenInteractor()
        
        self.presenter.view         =   self.view
        self.presenter.wireFrame    =   self.wireframe
        self.presenter.interactor   =   self.interactor
        
                
        self.view.presenter         =   self.presenter
        
        _ = self.view
        
    }
    
    override func tearDown() {
        super.tearDown()
        
        self.presenter  =   nil
        self.wireframe  =   nil
        self.interactor =   nil
    }
    
    func testShouldInformViewForShot()
    {
        let shot =  Shot()
        
        
        self.presenter.displayShot(shot: shot)
        
        XCTAssertTrue(self.view.displayShotCalled)
    }
    
    func testShouldInformInteractorForFetchCommentAction()
    {
        self.presenter.fetchCommentsAction(shotID: 0, commentsCount: 0)
        
        XCTAssertTrue(self.interactor.fetchCommentCalled)
    }
    
    func testShouldInformViewForNewComments()
    {
        let comments = [Comment(),Comment()]
        
        self.presenter.commentsFound(comments)
        
        XCTAssertTrue(self.view.displayCommentsCalled)
    }
    
    func testShouldInformWireframeForDismiss()
    {
        self.presenter.dismissControllerAction()
        
        XCTAssertTrue(self.wireframe.dismissCalled)
    }
    
}
