//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit



enum ShotDetailSection:Int
{
    case ShotDetailUserInfoSection  =   0
    case ShotDetailShotImageSection =   1
    case ShotDetailShotInfoSection  =   2
    case ShotDetailCommentsSection  =   3
    case ShotDetailSectionCount     =   4

    var height:CGFloat{
        
        switch self {
        case .ShotDetailUserInfoSection:
            return 60.0
            
        case .ShotDetailShotInfoSection:
            return 40.0
            
        case .ShotDetailCommentsSection:
            return UITableViewAutomaticDimension
            
            default:break
        }
     
        return 0.0
    }
    
}



class ShotDetailScreenViewController: UIViewController, ShotDetailScreenViewProtocol,UITableViewDelegate,UITableViewDataSource
{
    var presenter: ShotDetailScreenPresenterProtocol?
    
    
    weak var shot        :Shot!
    var comments         :[Comment]  =   []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets   =   false
        
        
        self.setupTableVIew()
        
        self.presenter!.fetchCommentsAction(shotID: self.shot.id, commentsCount: self.shot.comments_count)
    }
    
    
    
    func setupTableVIew()
    {
        UserInfoTableViewCell.registerTableViewView(tableView: self.tableView, reuseIdentifier: UserInfoTableViewCell.classNameReuseIdentifier)
        ShotImageTableViewCell.registerTableViewView(tableView: self.tableView, reuseIdentifier: ShotImageTableViewCell.classNameReuseIdentifier)
        ShotInfoTableViewCell.registerTableViewView(tableView: self.tableView, reuseIdentifier: ShotInfoTableViewCell.classNameReuseIdentifier)
        ShotCommentTableViewCell.registerTableViewView(tableView: self.tableView, reuseIdentifier: ShotCommentTableViewCell.classNameReuseIdentifier)
        
        
        self.tableView.delegate             =   self
        self.tableView.dataSource           =   self
        
        self.tableView.estimatedRowHeight   =   ShotDetailSection.ShotDetailUserInfoSection.height
    }
    
    
    
    //UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return ShotDetailSection.ShotDetailSectionCount.rawValue
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let currentSection:ShotDetailSection =   ShotDetailSection(rawValue: section)!
        
        switch currentSection
        {
        case .ShotDetailUserInfoSection:    return 1
        case .ShotDetailShotImageSection:   return 1
        case .ShotDetailShotInfoSection:    return 1
        case .ShotDetailCommentsSection:    return self.comments.count
            
        default: break
            
        }
        
        return 0
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        let currentSection:ShotDetailSection  =   ShotDetailSection(rawValue: indexPath.section)!
        
        var cell:UITableViewCell!
        
        switch currentSection
        {
        case .ShotDetailUserInfoSection:
            
            cell    =   tableView.dequeueReusableCellWithIdentifier(UserInfoTableViewCell.classNameReuseIdentifier)
            
            (cell as! ShotDetailCellPotocol).configureWithShot(self.shot!)
            
        case .ShotDetailShotImageSection:
            
            cell    =   tableView.dequeueReusableCellWithIdentifier(ShotImageTableViewCell.classNameReuseIdentifier)
            
                (cell as! ShotDetailCellPotocol).configureWithShot(self.shot!)
            
        case .ShotDetailShotInfoSection:
            
            cell    =   tableView.dequeueReusableCellWithIdentifier(ShotInfoTableViewCell.classNameReuseIdentifier)
            
            (cell as! ShotDetailCellPotocol).configureWithShot(self.shot!)
        
        case .ShotDetailCommentsSection:
            
            cell    =   tableView.dequeueReusableCellWithIdentifier(ShotCommentTableViewCell.classNameReuseIdentifier)
            
            guard self.comments.count > 0 else {return cell}
            
            let comment =   self.comments[indexPath.row]
            let isOdd   =   indexPath.row % 2 == 0
            (cell as! ShotCommentTableViewCell).configureWithComment(comment, isOdd: isOdd)
            
        default: break
            
        }
        
        
        return cell
    }
    
    
    
    //UITableViewDataDelegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let section   =   ShotDetailSection(rawValue: indexPath.section)
        
        if section == .ShotDetailShotImageSection
        {
            return self.tableView.bounds.width * CELL_HEIGHT_RATIO
        }
               
        return CGFloat(section!.height)
    }
    
    
    
    //MARK:ShotDetailScreenViewProtocol
    func displayShot(shot: Shot)
    {
        self.shot       =   shot
        self.comments   =   []
        
        guard shot.description != nil else {return}
        
        let shotDescriptionAsComment    =   Comment()
        shotDescriptionAsComment.user   =   shot.user
        shotDescriptionAsComment.body   =   shot.description
        
        self.comments.append( shotDescriptionAsComment)
        
    }
    
    func displayComments(comments: [Comment])
    {
        self.comments.appendContentsOf(comments)
        self.tableView.reloadData()
    }
    
    
    
}


