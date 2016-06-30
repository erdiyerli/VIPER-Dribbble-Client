//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation

protocol ShotDetailScreenViewProtocol: class
{
    var presenter: ShotDetailScreenPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    
    func displayShot( shot:Shot )
    func displayComments( comments:[Comment])
}

protocol ShotDetailScreenWireFrameProtocol: class
{
    func presentShotDetailScreenModule(fromView view: AnyObject, withShot shot:Shot)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    
    func dismissShotDetailScreen()
}



protocol ShotDetailScreenWireFrameOutputProtocol: class
{
    
    /**
     * Add here your methods for communication WIREFRAME -> App Wire Frame
     */
}

protocol ShotDetailScreenPresenterProtocol: class
{
    weak var view        : ShotDetailScreenViewProtocol? { get set }
    var interactor       : ShotDetailScreenInteractorInputProtocol? { get set }
    weak var wireFrame   : ShotDetailScreenWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    
    func configureView(withShot shot:Shot)
    func dismissControllerAction()
    func fetchCommentsAction(shotID shotID:Int, commentsCount:Int)
}

protocol ShotDetailScreenInteractorOutputProtocol: class
{
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    
    
    func commentsFound( comments:[Comment])
    
}

protocol ShotDetailScreenInteractorInputProtocol: class
{
    var presenter   : ShotDetailScreenInteractorOutputProtocol? { get set }
    var dataManager : ShotDetailScreenDataManagerInputProtocol? { get set }
    
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    
    func fetchComments( shotID shotID:Int, commentsCount:Int)
}

protocol ShotDetailScreenDataManagerInputProtocol: class
{
    var api :DribbbleServiceProtocol? {get set}
    var interactor :ShotDetailScreenDataManagerOutputProtocol? {get set}
    
    /**
    * Add here your methods for communication INTERACTOR -> DATAMANAGER
    */
    
    func commentsBy(shotID shotID:Int, commentsCount:Int)
}

protocol ShotDetailScreenDataManagerOutputProtocol: class
{
    /**
     * Add here your methods for communication INTERACTOR -> DATAMANAGER
     */
    
    func commentsByShotIDCompleted( response response:DribbbleServiceResponse )
}

