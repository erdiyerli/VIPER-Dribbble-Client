//
//  MockShotsScreenInteractor.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotsScreenInteractor: ShotsScreenInteractor
{
    var fetchedShotsCalled  :Bool   =   false
    var loadMoreActionCalled:Bool   =   false
    var fetchingShotsCompleted:Bool   =   false
    
    var currentResponse     :DribbbleServiceResponse?
    
    
    var stubSorting =   ShotSorting(sort: .Recent)
    override var currentSorting: ShotSorting! {get{ return stubSorting} set{}}
    
    
    override func fetchShots(with sorting: ShotSorting) {
        
        super.fetchShots(with: sorting)
        
        self.fetchedShotsCalled =   true
    }
    
    
    override func loadMoreShots() {
        super.loadMoreShots()
        
        self.loadMoreActionCalled   =   true
    }
    
    override func fetchingShotsCompleted(with response: DribbbleServiceResponse) {
        super.fetchingShotsCompleted(with: response)
        
        self.fetchingShotsCompleted =   true
        self.currentResponse    =   response
    }

}
