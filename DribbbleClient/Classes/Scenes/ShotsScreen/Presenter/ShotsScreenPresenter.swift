//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

class ShotsScreenPresenter: ShotsScreenPresenterProtocol, ShotsScreenInteractorOutputProtocol
{
    weak var view: ShotsScreenViewProtocol?
    var interactor: ShotsScreenInteractorInputProtocol?
    var wireFrame: ShotsScreenWireFrameProtocol?
    
    
    //MARK: ShotsScreenPresenterProtocol
    func sortShotsAction(sort sort: ShotSorting) {
        
        guard let interactor = self.interactor else {return}
        
        interactor.fetchShots(with: sort)
        
        
        guard let view = self.view else {return}
        
        view.displayLoading()
        
    }
    
    func initialiseView()
    {
        guard let view = self.view else {return}
        
        view.initialise()
    }
    
    func shotSelectedAction(shot shot: Shot)
    {
        guard let wireframe = self.wireFrame else {return}
        
        wireframe.shotSelected(shot: shot, fromView: self.view!)
    }
    
    func loadMoreAction()
    {
        guard let interactor = self.interactor else {return}
        
        interactor.loadMoreShots()
    }
    
    func logoutAction()
    {
        guard let wireframe = self.wireFrame else {return}
        
        wireframe.userDidLogout()
    }
    
    
    //MARK: ShotsScreenInteractorOutputProtocol
    
    func shotsFound(shots shots: [Shot])
    {
        guard let view = self.view else {return}
        
        view.displayShots(shots: shots)
    }
    
    func errorFound(error error: NSError?)
    {
        guard let view = self.view else {return}
        
        view.displayError(error: error)
    }
    
}