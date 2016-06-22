//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit

class ShotsScreenWireFrame: ShotsScreenWireFrameProtocol
{
    weak var appWireFrame: ShotsScreenWireFrameOutputProtocol?
    var presenter   :protocol<ShotsScreenPresenterProtocol, ShotsScreenInteractorOutputProtocol>?
    var interactor  :protocol<ShotsScreenInteractorInputProtocol,ShotsScreenDataManagerOutputProtocol>?
    
    func presentShotsScreenModule(fromView view: AnyObject)
    {
        
        // Generating module components
        
        self.presenter  = ShotsScreenPresenter()
        self.interactor = ShotsScreenInteractor()
        
        
        
        let shotsView: ShotsScreenViewProtocol = ShotsScreenViewController.createFromStoryboard(storyboardName: "Main") as! ShotsScreenViewController
        
        // Connecting
        shotsView.presenter = presenter
        self.presenter?.view = shotsView
        self.presenter?.wireFrame = self
        self.presenter?.interactor = interactor
        self.interactor?.presenter = self.presenter
        
        
        
        let navigationController    =   view as! UINavigationController
        
        navigationController.setViewControllers([shotsView as! UIViewController], animated: false)
    }
    
    
    func userAuthenticationCompleted()
    {
        let dataManager: ShotsScreenDataManagerInputProtocol = ShotsScreenDataManager()
        dataManager.api                 =   DribbbleApi(accessToken: Session.sharedSession.currentCredentials()?.accessToken )
        
        self.interactor?.dataManager    = dataManager
        dataManager.interactor          =   self.interactor
        
        self.presenter?.initialiseView()
    }
    
    func shotSelected(shot shot: Shot, fromView: AnyObject)
    {
        guard let output = self.appWireFrame else {return}
        
        output.shotsScreenModuleDidSelectShot(shot: shot)
        
    }
    
    func userDidLogout()
    {
        guard let output = self.appWireFrame else {return}
        
        output.shotScreenModuleDidLogout()
    }
    
}