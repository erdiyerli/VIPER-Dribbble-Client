//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit


protocol LoginScreenWireFrameProtocol: class
{
    var applicationWireframe    :LoginScreenWireFrameOutputProtocol? {get set}
    
    func presentLoginScreenModule(fromView fromView:AnyObject, animated:Bool )
    
    func dismissLoginScreenModule()
    
    /**
     * Add here your methods for communication PRESENTER -> WIREFRAME
     */
    
    func authenticationSucceeded( view fromView :LoginScreenViewProtocol)
}


protocol LoginScreenWireFrameOutputProtocol: class
{
    func authenticationSucceeded( view fromView :LoginScreenViewProtocol)
}


protocol LoginScreenViewProtocol: class
{
    var presenter: LoginScreenPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    
    func showAuthenticationFailedMessage()
    func showAuthenticating()
}


protocol LoginScreenPresenterProtocol: class,LoginScreenInteractorOutputProtocol
{
    var view        : LoginScreenViewProtocol? { get set }
    var interactor  : LoginScreenInteractorInputProtocol? { get set }
    var wireFrame   : LoginScreenWireFrameProtocol? { get set }
    
    /**
    * Add here your methods for communication VIEW -> PRESENTER
     will conform interactor output protocol
    */
    
    func authenticateAction( )
    
}

protocol LoginScreenInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
     //outputProtocol = Presenter
     // will conform interactorInputProtocol
    */
    
    func authenticationFailed(error error :NSError)
    func authenticationSucceeded( )
//
//    func shotsFetched(shots shots:[AnyObject])
//    func shotDetailFetched(shots shots:[AnyObject])
}

protocol LoginScreenInteractorInputProtocol: class
{
    var presenter: LoginScreenInteractorOutputProtocol? { get set }
    var dataManager: LoginScreenDataManagerInputProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
     interactor class will comform
    */
    
    func doAuthentication( )
}

protocol LoginScreenDataManagerInputProtocol: class
{
    var interactor  : LoginScreenDataManagerOutputProtocol? { get set}
    var service     : DribbbleServiceProtocol? {get set}
    
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
     data manager class will comform
     output = interactor
    */
    
    
    func authenticate( )
//    func fetchShots( with withUser:User )
//    func fetchShotDetail( with withShotID:Int )
}

protocol LoginScreenDataManagerOutputProtocol: class
{
    func authenticationFailed(error error :NSError)
    func authenticationSucceeded( accessToken accessToken:String )
}


