//
//  ShotsScreenDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 06/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

class ShotsScreenDataManager: ShotsScreenDataManagerInputProtocol
{
    var interactor: ShotsScreenDataManagerOutputProtocol?
    var api: DribbbleServiceProtocol?
    
    
        
    //MARK: ShotsScreenDataManagerInputProtocol
    func fetchShots(with sorting: ShotSorting, page: Int, perPage: Int) {
        
        guard let api = self.api else {return}
        
        api.fetchShots(with: sorting, page: page, perPage: perPage) { [weak self](response) -> (Void) in
        
            self!.interactor?.fetchingShotsCompleted(with: response)
            
        }
        
    }
}
