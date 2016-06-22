//
//  ApplicaitonWireframeProtocol.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

protocol ApplicationWireframeInputProtocol
{
    var navigationController    :UINavigationController! {get set}
    
    init( navigationController controller:UINavigationController)
    
    func presentInitialScreen()
    
}


protocol ApplicationWireframeOutputProtocol
{
    
}
