//
//  MockShotsScreenWireFrame.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotsScreenWireFrame: ShotsScreenWireFrame
{

    var shotSelectedCalled  :Bool   =   false
    
    
    override func shotSelected(shot shot: Shot, fromView: AnyObject) {
        super.shotSelected(shot: shot, fromView: fromView)
        
        self.shotSelectedCalled =   true
    }
    
}
