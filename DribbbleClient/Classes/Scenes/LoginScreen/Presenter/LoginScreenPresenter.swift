//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit

class LoginScreenPresenter: LoginScreenPresenterProtocol, LoginScreenInteractorOutputProtocol
{
    weak var view        : LoginScreenViewProtocol?
    var interactor  : LoginScreenInteractorInputProtocol?
    var wireFrame   : LoginScreenWireFrameProtocol?
    
    
    func authenticateAction( )
    {
        guard let presenterView = self.view else{return}
        
        presenterView.showAuthenticating()
        
        guard let interactor = self.interactor else{return}
        
        interactor.doAuthentication()
        
    }
    
    
    func authenticationSucceeded()
    {
        guard let router = self.wireFrame else { return }
        
        router.authenticationSucceeded(view: self.view!)
    }
    
    
    func authenticationFailed(error error: NSError)
    {
        guard let presenterView = self.view else{return}
        
        presenterView.showAuthenticationFailedMessage()
    }
}