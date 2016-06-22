//
//  ShotDetailScreenDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

class ShotDetailScreenDataManager: ShotDetailScreenDataManagerInputProtocol{

    var api:DribbbleServiceProtocol?
    weak var interactor: ShotDetailScreenDataManagerOutputProtocol?
    
    func commentsBy(shotID shotID: Int, commentsCount:Int)
    {
        guard let api = self.api else {return}
        
        api.fetchComments(shotID: shotID, commentsCount: commentsCount) { [weak self](response) -> (Void) in
            
            guard let interactor = self!.interactor else {return}
            
            interactor.commentsByShotIDCompleted(response: response)
        }
        
    }
    
}
