//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit

class ShotDetailScreenWireFrame: ShotDetailScreenWireFrameProtocol
{
    weak var shotDetailView  :ShotDetailScreenViewProtocol!
    weak var navController   :UINavigationController?
    
    func presentShotDetailScreenModule(fromView view: AnyObject, withShot:Shot)
    {
        
        // Generating module components
        self.shotDetailView = ShotDetailScreenViewController.createFromStoryboard(storyboardName: "Main") as! ShotDetailScreenViewController
        
        let presenter: protocol<ShotDetailScreenPresenterProtocol, ShotDetailScreenInteractorOutputProtocol> = ShotDetailScreenPresenter()
        
        let interactor: protocol<ShotDetailScreenInteractorInputProtocol,ShotDetailScreenDataManagerOutputProtocol> = ShotDetailScreenInteractor()
        
        let dataManager: ShotDetailScreenDataManagerInputProtocol   = ShotDetailScreenDataManager()
        
        let wireFrame: ShotDetailScreenWireFrameProtocol            = ShotDetailScreenWireFrame()
        
        // Connecting
        self.shotDetailView.presenter       = presenter
        presenter.view                      = self.shotDetailView
        presenter.wireFrame                 = wireFrame
        presenter.interactor                = interactor
        interactor.presenter                = presenter
        interactor.dataManager              = dataManager
        
        dataManager.interactor              = interactor
        dataManager.api                     = DribbbleApi(accessToken: Session.sharedSession.currentCredentials()!.accessToken )
        
        
        self.navController                  = view as? UINavigationController
        
        self.navController!.pushViewController(self.shotDetailView as! UIViewController, animated: true)
        
        presenter.displayShot(shot: withShot)
        
    }
    
    func dismissShotDetailScreen()
    {
        guard let nav = self.navController else {return}
        
        nav.popViewControllerAnimated(true)
    }
}