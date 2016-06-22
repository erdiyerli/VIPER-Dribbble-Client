//
//  MockShotsScreenPresenter.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 02/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotsScreenPresenter: ShotsScreenPresenter
{
    var sortShotsActionCalled :Bool   =   false
    var loadMoreActionCalled    :Bool   =   false
    var shotsSelectedActionCalled   :Bool = false
    
    var shotsFoundCalled    :Bool   =   false
    var errorFoundCalled    :Bool   =   false
    
    var foundShots          :[Shot]?
    
    var selectedShot    :Shot?
    var sortType        :ShotSorting!
    
    override func shotSelectedAction(shot shot: Shot)
    {
        super.shotSelectedAction(shot: shot)
        
        self.shotsSelectedActionCalled  =   true
        self.selectedShot   =   shot
    }
    
    
    override func sortShotsAction(sort sort: ShotSorting) {
        super.sortShotsAction(sort: sort)
        
        self.sortShotsActionCalled  =   true
        self.sortType   =   sort
    }
    
    
    override func loadMoreAction() {
        super.loadMoreAction()
        
        self.loadMoreActionCalled   =   true
    }
    
    
    override func errorFound(error error: NSError?) {
        super.errorFound(error: error)
        
        self.errorFoundCalled   =   true
    }
    
    override func shotsFound(shots shots: [Shot]) {
        super.shotsFound(shots: shots)
        
        self.shotsFoundCalled   =   true
        
        self.foundShots =   shots
    }

}
