//
//  ShotsScreenPresenterTest.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 03/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import XCTest

@testable import DribbbleClient

class ShotsScreenPresenterTest: XCTestCase
{
    
    var presenter   :   MockShotsScreenPresenter!
    var view        :   MockShotsScreenViewController!
    var interactor  :   MockShotsScreenInteractor!
    var wireframe   :   MockShotsScreenWireFrame!
    
    override func setUp()
    {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.presenter  =   MockShotsScreenPresenter()
        self.view       =   MockShotsScreenViewController()
        self.interactor =   MockShotsScreenInteractor()
        self.wireframe  =   MockShotsScreenWireFrame()
        
        self.view.presenter         =   self.presenter
        
        self.presenter.view         =   self.view
        self.presenter.interactor   =   self.interactor
        self.presenter.wireFrame    =   self.wireframe
        
        self.interactor.presenter   =   self.presenter
        
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        self.presenter  =   nil
        self.view       =   nil
    }
    
    
    
    func testShouldInitialiseView()
    {
        
        self.presenter.initialiseView()
        
        XCTAssertTrue(self.view.initialisedCalled)
        
    }
    
    
    func testShouldCallLoadMoreActionOnInteractor()
    {
        self.presenter.loadMoreAction()
        
        XCTAssertTrue(self.interactor.loadMoreActionCalled)
    }
    
    
    func testShouldCallDisplayErrorOnView()
    {
        self.presenter.errorFound(error: nil)
        
        XCTAssertTrue(self.view.displayErrorCalled)
    }
    
    
    func testShouldCallDisplayShots()
    {
        let shots = [Shot(),Shot()]
        
        self.presenter.shotsFound(shots: shots)
        
        XCTAssertTrue(self.view.displayShotsCalled)
        
        XCTAssertEqual(self.view.shots?.count, 2)
        
    }
    
    
    func testShouldInformWireframeWhenAShotSelected()
    {
        let shot = Shot()
        
        self.presenter.shotSelectedAction(shot: shot)
        
        XCTAssertTrue(self.wireframe.shotSelectedCalled)
    }
    
    
    
}
