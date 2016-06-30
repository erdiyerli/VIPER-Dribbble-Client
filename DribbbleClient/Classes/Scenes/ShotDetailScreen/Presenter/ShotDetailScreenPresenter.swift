//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

class ShotDetailScreenPresenter: ShotDetailScreenPresenterProtocol, ShotDetailScreenInteractorOutputProtocol
{
    weak var view        : ShotDetailScreenViewProtocol?
    var interactor       : ShotDetailScreenInteractorInputProtocol?
    weak var wireFrame   : ShotDetailScreenWireFrameProtocol?
    
    
    func configureView(withShot shot: Shot) {
        
        guard let view = self.view else {return}
        
        view.displayShot(shot)
    }
    
    func fetchCommentsAction(shotID shotID: Int, commentsCount:Int)
    {
        guard let interactor = self.interactor else {return}
        
        interactor.fetchComments(shotID: shotID, commentsCount: commentsCount)
    }
    
    
    func commentsFound(comments: [Comment])
    {
        guard let view = self.view else {return}
        
        view.displayComments(comments)
    }
    
    func dismissControllerAction()
    {
        guard let wireFrame = self.wireFrame else {return}
        
        wireFrame.dismissShotDetailScreen()
    }
    
}