//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

class ShotsScreenInteractor: ShotsScreenInteractorInputProtocol,ShotsScreenDataManagerOutputProtocol
{
    weak var presenter: ShotsScreenInteractorOutputProtocol?
    var dataManager: ShotsScreenDataManagerInputProtocol?
    
    
    let PER_PAGE        :Int    =   30
    
    
    var currentPage     :Int =   1
    var currentSorting  :ShotSorting!
    
    init() {}
    
    
    //MARK:ShotsScreenInteractorInputProtocol
    func fetchShots(with sorting: ShotSorting) {
        
        guard let dataManager = self.dataManager else {return}
        
        if sorting != self.currentSorting {
            
            self.currentPage        =   1
        }
        
        self.currentSorting     =   sorting
        
        dataManager.fetchShots(with: self.currentSorting, page: self.currentPage, perPage: PER_PAGE)
        
    }
    
    func loadMoreShots()
    {
        self.currentPage    += 1
        
        self.fetchShots(with: self.currentSorting)
        
    }
    
    
    
    //MARK: ShotsScreenDataManagerOutputProtocol
    
    func fetchingShotsCompleted(with response: DribbbleServiceResponse)
    {
        guard let presenter = self.presenter else {return}
        
        switch response
        {
        case .Error(let error):
                presenter.errorFound(error: error)
            break
            
        case .Success(let shots):
                presenter.shotsFound(shots: shots as! [Shot])
            break
            
        
            
        }
    }
    
    
}