//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit


class LoginScreenWireFrame: NSObject, LoginScreenWireFrameProtocol,UIViewControllerTransitioningDelegate
{
    weak var applicationWireframe    :LoginScreenWireFrameOutputProtocol?
    
    weak var loginView               :LoginScreenViewProtocol!
    
    var modalTransition              :ModalTransition!
    
    
    func presentLoginScreenModule(fromView fromView: AnyObject, animated:Bool) {
        
        
        self.modalTransition                        =   ModalTransition(direction: .Bottom, transtitionDuration: 0.3)
        
        let loginScreen :LoginScreenViewController  =   LoginScreenViewController.createFromStoryboard(storyboardName: "Main") as! LoginScreenViewController
        
        loginScreen.transitioningDelegate   =   self
        loginScreen.modalPresentationStyle  =   .Custom
        
        let presenter       =   LoginScreenPresenter()
        let interactor      =   LoginScreenInteractor()
        let dataManager     =   LoginScreenDataManager()
        
        
        
        
        self.loginView           =   loginScreen
        loginView.presenter     =   presenter
        
        presenter.view          =   loginView
        presenter.interactor    =   interactor
        presenter.wireFrame     =   self
        
        interactor.presenter    =   presenter
        interactor.dataManager  =   dataManager
        
        dataManager.interactor  =   interactor
        dataManager.service     =   DribbbleApi(accessToken: nil)
        
        
        let controller:UIViewController   =   fromView as! UIViewController
        
        controller.presentViewController(self.loginView as! UIViewController, animated: animated, completion: nil)
    }
    
    
    func authenticationSucceeded(view fromView: LoginScreenViewProtocol)
    {
        guard let output = self.applicationWireframe else {return}
        
        output.authenticationSucceeded(view: fromView)
    }
    
    func dismissLoginScreenModule()
    {
        (self.loginView as! UIViewController).dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.modalTransition.transitionStep =   .Push
        return self.modalTransition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.modalTransition.transitionStep =   .Pop
        return self.modalTransition
    }
    
}