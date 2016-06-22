//
//  MockShotDetailScreenWireframe.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockShotDetailScreenWireframe: ShotDetailScreenWireFrame
{
    var dismissCalled   :Bool   =   false
    
    
    override func dismissShotDetailScreen()
    {
        super.dismissShotDetailScreen()
        
        self.dismissCalled  =   true
    }
}
