//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

protocol ShotsScreenViewProtocol: class
{
    var presenter: ShotsScreenPresenterProtocol? { get set }
    
    var user: User? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    
    func initialise()
    func displayShots( shots shots:[Shot])
    func displayError( error error:NSError?)
    func displayLoading( )
    func disableLoadingMoreAction( )
}

protocol ShotsScreenWireFrameProtocol: class
{
    var appWireFrame    :ShotsScreenWireFrameOutputProtocol? {get set}
    var presenter   :protocol<ShotsScreenPresenterProtocol, ShotsScreenInteractorOutputProtocol>? {get set}

    func presentShotsScreenModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME, APP WIREFRAME -> WIREFRAME
    */
    
    func userAuthenticationCompleted()
    func shotSelected(shot shot:Shot, fromView:AnyObject)
    func userDidLogout()
}


protocol ShotsScreenWireFrameOutputProtocol: class
{
    
    /**
     * Add here your methods for communication WIREFRAME -> App Wireframe
     */
    
    func shotsScreenModuleDidSelectShot( shot shot:Shot)
    func shotScreenModuleDidLogout()
}

protocol ShotsScreenPresenterProtocol: class
{
    var view: ShotsScreenViewProtocol? { get set }
    var interactor: ShotsScreenInteractorInputProtocol? { get set }
    var wireFrame: ShotsScreenWireFrameProtocol? { get set }
    
    
    /**
    * Add here your methods for communication VIEW -> PRESENTER , WIREFRAME -> PRESENTER
    */
    
    func initialiseView()
    
    func shotSelectedAction( shot shot:Shot)
    func sortShotsAction( sort sort:ShotSorting )
    func loadMoreAction()
    func logoutAction()
}

protocol ShotsScreenInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    
    func shotsFound( shots shots:[Shot])
    func errorFound( error error:NSError?)
}

protocol ShotsScreenInteractorInputProtocol: class
{
    var presenter: ShotsScreenInteractorOutputProtocol? { get set }
    var dataManager: ShotsScreenDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    
    func fetchShots(with sorting:ShotSorting)
    func loadMoreShots()
}

protocol ShotsScreenDataManagerInputProtocol: class
{
    var interactor: ShotsScreenDataManagerOutputProtocol? {get set}
    var api: DribbbleServiceProtocol? {get set}
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
    
    func fetchShots(with sorting:ShotSorting, page:Int, perPage:Int)
}

protocol ShotsScreenDataManagerOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    
    func fetchingShotsCompleted( with response:DribbbleServiceResponse)
    
}

