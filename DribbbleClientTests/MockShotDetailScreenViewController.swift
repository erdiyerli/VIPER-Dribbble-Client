//
//  MockShotDetailScreenViewController.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
@testable import DribbbleClient

class MockShotDetailScreenViewController: ShotDetailScreenViewController
{

    var setupTableViewCalled    :Bool   =   false
    var displayShotCalled       :Bool   =   false
    var displayCommentsCalled   :Bool   =   false
    
    var stubTableView                   =   UITableView()
    override var tableView: UITableView!  {  get{ return stubTableView } set{} }
    
    var stubShot    :Shot   =   Shot()
    override var shot: Shot! {get{return stubShot} set{}}
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        self.shot       =   Shot()
        
        self.comments   =   []
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func setupTableVIew() {
        super.setupTableVIew()
        
        self.setupTableViewCalled   =   true
    }
    
    override func displayShot(shot: Shot) {
        super.displayShot(shot)
        
        self.displayShotCalled  =   true
    }
    
    override func displayComments(comments: [Comment]) {
        super.displayComments(comments)
        
        self.displayCommentsCalled  =   true
    }
    
}
