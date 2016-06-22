//
//  LoginScreenDataManager.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

class LoginScreenDataManager: LoginScreenDataManagerInputProtocol
{
    
    weak var interactor  : LoginScreenDataManagerOutputProtocol?
    var service     : DribbbleServiceProtocol?
    
    
    
    func authenticate()
    {
        guard let api = self.service else {return}
        
        api.authenticateUser { [weak self](response) -> (Void) in
            
            switch ( response )
            {
            case .Error(let error):
                
                self!.interactor!.authenticationFailed(error: error)
                
            break
                
            case .Success(let token):
                    self!.interactor!.authenticationSucceeded(accessToken: token as! String)
                break
                
            }
        }
    }
}
