//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

class ShotDetailScreenInteractor: ShotDetailScreenInteractorInputProtocol,ShotDetailScreenDataManagerOutputProtocol
{
    weak var presenter  : ShotDetailScreenInteractorOutputProtocol?
    var dataManager     : ShotDetailScreenDataManagerInputProtocol?
    
    
    
    
    func fetchComments(shotID shotID: Int,commentsCount:Int) {
     
        guard let dataManager = self.dataManager else {return}
        
        dataManager.commentsBy(shotID: shotID, commentsCount: commentsCount)
    }
    
    
    func commentsByShotIDCompleted(response response: DribbbleServiceResponse) {
        
        switch response {
        case .Success(let data):
            
            guard let presenter = self.presenter else {return}
            
            presenter.commentsFound( data as! [Comment])
            
            
        default:
            break
        }
        
    }
    
}