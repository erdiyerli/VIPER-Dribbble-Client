//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit

class LoginScreenInteractor: LoginScreenInteractorInputProtocol,LoginScreenDataManagerOutputProtocol
{
    weak var presenter: LoginScreenInteractorOutputProtocol?
    var dataManager: LoginScreenDataManagerInputProtocol?
    
    
    func doAuthentication()
    {
        guard let manager = self.dataManager else {return}
        manager.authenticate()
    }
    
    
    func authenticationSucceeded(accessToken accessToken: String) {
        
        Session.sharedSession.updateCredentials(accessToken: accessToken)
        
        guard let output = self.presenter else { return }
        
        output.authenticationSucceeded()
        
    }
    
    
    func authenticationFailed(error error: NSError)
    {
        guard let output = self.presenter else { return }
        
        output.authenticationFailed(error: error)
    }
    
}