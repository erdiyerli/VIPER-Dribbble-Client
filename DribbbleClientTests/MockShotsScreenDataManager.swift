//
//  MockShotsScreenDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotsScreenDataManager: ShotsScreenDataManager
{
    var fetchShotsCalled    :Bool   =   false
    var currentSorting      :ShotSorting!
    var currentPage         :Int?
    
    
    override func fetchShots(with sorting: ShotSorting, page: Int, perPage: Int) {
        
        super.fetchShots(with: sorting, page: page, perPage: perPage)
        
        self.fetchShotsCalled   =   true
        self.currentSorting     =   sorting
        self.currentPage        =   page
    }
}
