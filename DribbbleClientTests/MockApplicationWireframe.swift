//
//  MockApplicationWireframe.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 22/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockApplicationWireframe: ApplicationWireframe
{

    var authenticationSucceededCalled           :Bool                       =   false
    var shotScreenModuleDidLogoutCalled         :Bool                       =   false
    var shotsScreenModuleDidSelectShotCalled    :Bool                       =   false
    
    var stubNavigationController        :UINavigationController     =   UINavigationController()
    var stubLoginScreenWireFrame        :MockLoginScreenWireFrame   =   MockLoginScreenWireFrame()
    var stubShotsScreenWireFrame        :MockShotsScreenWireFrame   =   MockShotsScreenWireFrame()
    var stubShotDetailScreenWireFrame   :ShotDetailScreenWireFrame  =   ShotDetailScreenWireFrame()

    
    override var navigationController    :UINavigationController!  {  get{ return stubNavigationController}  set{}  }
    
    override var loginScreenWireFrame  :LoginScreenWireFrameProtocol! {  get{ return stubLoginScreenWireFrame}  set{}  }
    
    override var shotsScreenWireFrame  :ShotsScreenWireFrameProtocol! {  get{ return stubShotsScreenWireFrame}  set{}  }
    
    override var shotDetailScreenWireFrame  :ShotDetailScreenWireFrameProtocol! {  get{ return stubShotDetailScreenWireFrame} set{} }

    
    convenience init()
    {
        self.init(navigationController: UINavigationController())
    }
    
    override func presentInitialScreen() {
        super.presentInitialScreen()
    }
    
    
    override func authenticationSucceeded(view fromView: LoginScreenViewProtocol) {
        super.authenticationSucceeded(view: fromView)
        
        self.authenticationSucceededCalled  =   true
    }
    
    
    override func shotScreenModuleDidLogout() {
        super.shotScreenModuleDidLogout()
        
        self.shotScreenModuleDidLogoutCalled    =   true
    }
    
    
    override func shotsScreenModuleDidSelectShot(shot shot: Shot) {
        super.shotsScreenModuleDidSelectShot(shot: shot)
        
        self.shotsScreenModuleDidSelectShotCalled   =   true
    }
    
}
