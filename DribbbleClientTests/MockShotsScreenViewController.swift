//
//  MockShotsScreenViewController.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 02/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

@testable import DribbbleClient

class MockShotsScreenViewController: ShotsScreenViewController
{
    
    var setupCalled :Bool   =   false
    var fetchShotsOnLoadCalled :Bool   =   false

    var displayErrorCalled :Bool   =   false
    var displayShotsCalled :Bool   =   false
    var displayLoadingCalled :Bool   =   false
    var disableLoadingMoreCalled :Bool   =   false
    var initialisedCalled       :Bool   =   false
    
    var stubCollectionView:UICollectionView!
    var stubsortControl:UISegmentedControl!
    
    
    override var shotsCollectionView: UICollectionView!
    {
        get { return stubCollectionView}
        set {}
    }
    
    override var sortControl: UISegmentedControl!
    {
        get {return stubsortControl}
        set {}
    }
    
    
    init()
    {
        super.init(nibName: nil, bundle: nil)
        
        self.stubCollectionView    =   UICollectionView(frame: UIScreen.mainScreen().bounds, collectionViewLayout: UICollectionViewFlowLayout())
        
        self.stubCollectionView.addInfiniteScrollingWithActionHandler(nil)
        
        self.stubsortControl            =   UISegmentedControl(items: ["Recent","Popular","Most Viewed"])
        
        self.controllerState        =   .Loading
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()

    }

    override func initialise() {
        super.initialise()
        
        self.initialisedCalled  =   true
    }

    override func setupCollectionView() {
        super.setupCollectionView()
        
        self.setupCalled    =   true
    }
  
    
    
    
    override func displayError(error error: NSError?) {
        super.displayError(error: error)
        
        self.displayErrorCalled =   true
    }
    
    override func displayShots(shots shots: [Shot]) {
        super.displayShots(shots: shots)
        
        self.displayShotsCalled =   true
    }
    
    
    override func disableLoadingMoreAction() {
        super.disableLoadingMoreAction()
        
        self.disableLoadingMoreCalled   =   true
    }

}
