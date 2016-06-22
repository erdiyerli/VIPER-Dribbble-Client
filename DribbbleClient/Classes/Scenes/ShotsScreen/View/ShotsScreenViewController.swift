//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit
import SVPullToRefresh




let ITEM_COUNT:Int              =   3
let ITEM_SPACE:CGFloat          =   2.0
let CELL_HEIGHT_RATIO:CGFloat   =   3.0 / 4.0

class ShotsScreenViewController: UIViewController, ShotsScreenViewProtocol,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,ErrorCollectionViewCellDelegate
{
    
    //IBOutlet
    var shotsCollectionView: UICollectionView!
    
    @IBOutlet var sortControl: UISegmentedControl!
    
    
    let AllSorts:[ShotSorting]    =   [
        
        ShotSorting(sort: ShotSorting.Sort.Popular),
        ShotSorting(sort: ShotSorting.Sort.Recent),
        ShotSorting(sort: nil, list: ShotSorting.List.Animated, timeframe: nil)
    
    ]
    
        
    var presenter   : ShotsScreenPresenterProtocol?
    
    var user        : User?
    
    var shots       :[Shot]?
    
    var controllerState:ViewControllerState!{
        
        didSet{
            
            if self.controllerState != .Loaded
            {
                self.shots  =   nil
                
                
                
                guard self.sortControl != nil && self.shotsCollectionView != nil else {return}
                
                self.shotsCollectionView.showsInfiniteScrolling =   false
                self.loadMoreActionEnabled                      =   false
                self.sortControl.userInteractionEnabled         =   false
            }
            else
            {
                guard self.sortControl != nil && self.shotsCollectionView != nil else {return}
                
                self.shotsCollectionView.showsInfiniteScrolling =   true
                self.loadMoreActionEnabled                      =   true
                self.sortControl.userInteractionEnabled         =   true
            }
        }
    }
    
    var loadMoreActionEnabled   :Bool   =   true
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        self.controllerState    =   .Loading
        
        self.automaticallyAdjustsScrollViewInsets   =   false
        

        let barbuttonItem   =   UIBarButtonItem(title: "Logout", style: .Plain, target: self, action: #selector(logoutButtonTapped(_:)))

        self.navigationItem.rightBarButtonItem  =   barbuttonItem
        
        self.setupCollectionView()
        
    }
    
    
    
    func setupCollectionView()
    {
        ErrorCollectionViewCell.registerCollectionView(collectionView: self.shotsCollectionView, reuseIdentifier: ErrorCollectionViewCell.classNameReuseIdentifier)
        
        LoadingCollectionViewCell.registerCollectionView(collectionView: self.shotsCollectionView, reuseIdentifier: LoadingCollectionViewCell.classNameReuseIdentifier)
        
        ShotItemCollectionViewCell.registerCollectionView(collectionView: self.shotsCollectionView, reuseIdentifier: ShotItemCollectionViewCell.classNameReuseIdentifier)
        
        
        let layout  =   UICollectionViewFlowLayout()
        layout.scrollDirection  =   .Vertical
        
        
        self.shotsCollectionView.delegate   =   self
        self.shotsCollectionView.dataSource =   self
        
        self.shotsCollectionView.collectionViewLayout   =   layout
        
        
        self.shotsCollectionView.addInfiniteScrollingWithActionHandler { 
            
            guard self.loadMoreActionEnabled else {
                self.shotsCollectionView.infiniteScrollingView.stopAnimating()
                return
            }
            
            guard let presenter =   self.presenter else {return}
            
            presenter.loadMoreAction()

        }
    }
    
    
    
    func fetchShots(sorting sort:ShotSorting)
    {
        guard let presenter =   self.presenter else {return}
        
        self.controllerState    =   .Loading
        
        presenter.sortShotsAction(sort: sort)
        
        guard self.shotsCollectionView != nil else {return}
        
        self.shotsCollectionView.reloadData()
    }
    
    
    
    //MARK: UICollectionViewDataSource
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        if self.controllerState == ViewControllerState.Loading || self.controllerState == ViewControllerState.Error{
            return 1
        }
        
        guard let shots = self.shots else {return 0}
        
        return shots.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var cell    :UICollectionViewCell?
        
        
        if self.controllerState == ViewControllerState.Loading
        {
            cell    =   collectionView.dequeueReusableCellWithReuseIdentifier(LoadingCollectionViewCell.classNameReuseIdentifier, forIndexPath: indexPath)
        }
        else if self.controllerState == ViewControllerState.Error
        {
            cell    =   collectionView.dequeueReusableCellWithReuseIdentifier(ErrorCollectionViewCell.classNameReuseIdentifier, forIndexPath: indexPath)
            (cell as! ErrorCollectionViewCell).delegate  =   self
        }
        else if self.controllerState == ViewControllerState.Loaded
        {
            cell    =   collectionView.dequeueReusableCellWithReuseIdentifier(ShotItemCollectionViewCell.classNameReuseIdentifier, forIndexPath: indexPath)
            
            guard let shots = self.shots else {return cell!}
            
            (cell as! ShotDetailCellPotocol).configureWithShot( shots[indexPath.row])
        }
        
        
        
        return cell!
    }
    
    
    
    //MARK: UICollectionViewDelegate
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        guard let presenter = self.presenter else {return}
        
        guard let shots = self.shots else {return}
        
        let selectedShot:Shot    =   shots[indexPath.row]
        
        presenter.shotSelectedAction(shot: selectedShot)
    }
    
    
    
    
    //MARK: UICollectionViewDelegateFlowLayout
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        if self.controllerState == .Loading || self.controllerState == .Error {
            return self.shotsCollectionView.bounds.size
        }
        
        let bounds          =   self.shotsCollectionView.bounds.size.width
        let cellWidth       =   (bounds - (CGFloat(ITEM_COUNT - 1) * ITEM_SPACE)) / CGFloat(ITEM_COUNT)
        let cellHeight      =   cellWidth * CELL_HEIGHT_RATIO
        
        return  CGSizeMake(cellWidth, cellHeight)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return ITEM_SPACE
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return ITEM_SPACE
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(ITEM_SPACE, 0.0, ITEM_SPACE, 0.0)
    }
    
    
    
    
    
    //MARK: ShotsScreenViewProtocol
    
    func initialise()
    {
        self.shots  =   nil
        self.controllerState    =   .Loading
        
        
        self.fetchShots(sorting: AllSorts[0] )
        
        guard self.sortControl != nil && self.shotsCollectionView != nil else {return}
        
        self.shotsCollectionView.setContentOffset(CGPointZero, animated: false)
        
        self.sortControl.selectedSegmentIndex   =   0
    }
    
    
    func displayShots(shots shots: [Shot])
    {
        self.controllerState    =   .Loaded
        
        if self.shots == nil
        {
            self.shots = shots
        
        }
        else
        {
            self.shots!.appendContentsOf(shots)
        }
        
        
        self.shotsCollectionView.infiniteScrollingView.stopAnimating()
        
        self.shotsCollectionView.reloadData()
    }
    
    
    func displayLoading()
    {
        self.controllerState    =   .Loading
        
        guard self.shotsCollectionView != nil else {return}
        
        self.shotsCollectionView.reloadData()
    }
    
    
    func displayError(error error: NSError?)
    {
        self.controllerState    =   .Error
        
        self.shotsCollectionView.reloadData()
        
    }
    
    func disableLoadingMoreAction()
    {
        self.loadMoreActionEnabled  =   false
    }
    
    
    
    
    //MARK: ErrorCollectionViewCellDelegate
    
    func errorCollectionViewCellDidTapTryAgain(cell collectionViewCell: ErrorCollectionViewCell)
    {
        self.fetchShots(sorting: AllSorts[self.sortControl.selectedSegmentIndex])
    }
    
    
    //MARK: Actions
    
    
    func logoutButtonTapped(sender:AnyObject)
    {
        guard let presenter = self.presenter else {return}
        
        presenter.logoutAction()
    }
    
    @IBAction func sortingControllerValueChanged(sender: AnyObject)
    {
        let index = self.sortControl.selectedSegmentIndex
        self.fetchShots(sorting: AllSorts[index])
        
        self.shotsCollectionView.setContentOffset(CGPointZero, animated: false)
    }
    
}