//
//  ApplicationWIreframe.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit


class ApplicationWireframe:ApplicationWireframeInputProtocol,LoginScreenWireFrameOutputProtocol,ShotsScreenWireFrameOutputProtocol
{
    var navigationController    :UINavigationController!
    
    
    var loginScreenWireFrame  :LoginScreenWireFrameProtocol!
    var shotsScreenWireFrame  :ShotsScreenWireFrameProtocol!
    var shotDetailScreenWireFrame  :ShotDetailScreenWireFrameProtocol!

    
    required init( navigationController controller:UINavigationController)
    {
        self.navigationController   =   controller
        
        self.loginScreenWireFrame   =   LoginScreenWireFrame()
        self.shotsScreenWireFrame   =   ShotsScreenWireFrame()
        
        self.shotsScreenWireFrame.appWireFrame          =   self
        self.loginScreenWireFrame.applicationWireframe  =   self
    }
    
    
    func presentInitialScreen()
    {
        
        self.shotsScreenWireFrame.presentShotsScreenModule(fromView: self.navigationController)
        
        
        guard Session.sharedSession.currentCredentials() == nil else
        {
            self.shotsScreenWireFrame.userAuthenticationCompleted()
            return
        }
        
        let time    =   dispatch_time(DISPATCH_TIME_NOW, Int64( 0.03 * Double(NSEC_PER_SEC)))
        
        dispatch_after(time, dispatch_get_main_queue()) { 
            
            self.loginScreenWireFrame.presentLoginScreenModule(fromView: self.shotsScreenWireFrame.presenter!.view!, animated: false)
            
        }
        
        
    }
    
    
    
    //MARK: LoginScreenWireFrameOutputProtocol
    func authenticationSucceeded(view fromView: LoginScreenViewProtocol)
    {
        self.loginScreenWireFrame.dismissLoginScreenModule()
        self.loginScreenWireFrame   =   nil
        self.shotsScreenWireFrame.userAuthenticationCompleted()
    }
    
    
    //MARK: ShotsScreenWireFrameOutputProtocol
    
    func shotScreenModuleDidLogout()
    {
        Session.sharedSession.clearCredentials()
        
        self.loginScreenWireFrame   =   LoginScreenWireFrame()
        self.loginScreenWireFrame.applicationWireframe  =   self
        self.loginScreenWireFrame.presentLoginScreenModule(fromView: self.shotsScreenWireFrame.presenter!.view!, animated: true)
    }
    
    func shotsScreenModuleDidSelectShot(shot shot: Shot)
    {
        self.shotDetailScreenWireFrame  =   ShotDetailScreenWireFrame()
        self.shotDetailScreenWireFrame.presentShotDetailScreenModule(fromView: self.navigationController, withShot: shot)
    }
    
}
