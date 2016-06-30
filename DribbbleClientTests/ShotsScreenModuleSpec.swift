//
//  ShotsScreenModuleSpec.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 28/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//


import Quick
import Nimble

@testable import DribbbleClient

class ShotsScreenModuleSpec: QuickSpec
{
    var shotsView   :MockShotsScreenViewController!
    var presenter   :MockShotsScreenPresenter!
    var interactor  :MockShotsScreenInteractor!
    var dataManager :MockShotsScreenDataManager!
    var wireframe   :MockShotsScreenWireFrame!
    var api         :MockDribbbleApi!

    override func spec()
    {
        
        beforeEach { 
            
            self.shotsView  =   MockShotsScreenViewController()
            self.presenter  =   MockShotsScreenPresenter()
            self.interactor =   MockShotsScreenInteractor()
            self.dataManager =   MockShotsScreenDataManager()
            self.wireframe  =   MockShotsScreenWireFrame()
            self.api        =   MockDribbbleApi()
            
            
            self.shotsView.presenter    =   self.presenter
            
            self.presenter.view         =   self.shotsView
            self.presenter.interactor   =   self.interactor
            self.presenter.wireFrame    =   self.wireframe
            
            self.interactor.presenter   =   self.presenter
            self.interactor.dataManager =   self.dataManager
            
            self.dataManager.interactor =   self.interactor
            self.dataManager.api        =   self.api
            
        }
        
        afterEach { 
            self.shotsView  =   nil
            self.presenter  =   nil
            self.interactor =   nil
            self.dataManager    =   nil
            self.wireframe  =   nil
            self.api        =   nil
        }
        
        
        
        
        //MARK: ShotsViewController Test
        describe("View Controller") {
            
            it("should call setup on load"){
            
                _ = self.shotsView.view
                
                expect(self.shotsView.setupCalled).to(beTrue())
            }
            
            
            it("should initialise view"){
                
                self.shotsView.initialise()
                
                expect(self.shotsView.shots).to(beNil())
                expect(self.shotsView.controllerState).to(equal(ViewControllerState.Loading))
                expect(self.shotsView.stubsortControl.selectedSegmentIndex).to(equal(0))
                expect(self.shotsView.stubCollectionView.contentOffset.y).to(equal(0.0))
                expect(self.presenter.sortShotsActionCalled).to(beTrue())
    
            }
            
            
            context("when needs to update collectionView") {
                
                beforeEach{
                    self.shotsView.setupCollectionView()
                }
                
                it("should use LoadingCollectionViewCell cell for loading"){
                    
                    self.shotsView.displayLoading()
                    
                    let cell    =   self.cellForSection(NSIndexPath(forRow: 0, inSection: 0))
                    
                    expect(cell).to(beAKindOf(LoadingCollectionViewCell.self))
                    
                }
                
                it("should use ErrorCollectionViewCell cell for error"){
                    
                    self.shotsView.displayError(error: nil)
                    
                    let cell    =   self.cellForSection(NSIndexPath(forRow: 0, inSection: 0))
                    
                    expect(cell).to(beAKindOf(ErrorCollectionViewCell.self))
                    
                }
                
                it("should use ShotItemCollectionViewCell for shots"){
                    
                    self.shotsView.displayShots(shots: [Shot()])
                    
                    let cell    =   self.cellForSection(NSIndexPath(forRow: 0, inSection: 0))
                    
                    expect(cell).to(beAKindOf(ShotItemCollectionViewCell.self))
                    
                }
            }
            
            
            context("when more data loaded"){
            
                it("should append new shots to the current ones"){
                    let shots   =   [Shot](count: 3, repeatedValue: Shot())
                    
                    self.shotsView.displayShots(shots: shots)
                    
                    expect(self.shotsView.shots!.count).to(equal(shots.count))
                    
                    self.shotsView.displayShots(shots: shots)
                    
                    expect(self.shotsView.shots!.count).to(equal(shots.count * 2))
                }
                
            }
            
            
            context("when an item selected"){
                
                it("should inform presenter"){
                    let shot    =   Shot()
                    shot.title  =   "new shot"
                    
                    self.shotsView.setupCollectionView()
                    self.shotsView.displayShots(shots: [shot])
                    
                    self.shotsView.stubCollectionView.delegate!.collectionView!(self.shotsView.stubCollectionView, didSelectItemAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
                    
                    expect(self.presenter.shotsSelectedActionCalled).to(beTrue())
                    expect(self.presenter.selectedShot!.title).to(equal(shot.title))
                    
                }
            }
            
            
            context("when sort controller value changed"){
                
                it("should use related sorting when sort controller value changed"){
                    //1 for recent
                    self.shotsView.stubsortControl.selectedSegmentIndex     =   1
                    
                    self.shotsView.sortingControllerValueChanged(self.shotsView.stubsortControl)
                    
                    expect(self.presenter.sortShotsActionCalled).to(beTrue())
                    expect(self.presenter.sortType).to(equal(ShotSorting(sort: .Recent)))
                    
                }
                
            }
            
            
            context("during fetching shots"){
                
                beforeEach{
                 
                    self.shotsView.fetchShots(sorting: ShotSorting(sort: .Popular))
                }
                
                it("should disable sort controller"){
                    expect(self.shotsView.stubsortControl.userInteractionEnabled).to(beFalse())
                }
                
                it("should set controller state to Loading "){
                    expect(self.shotsView.controllerState).to(equal(ViewControllerState.Loading))
                }
            }
            
        }
        
        
        
        
        
        //MARK: Presenter Test
        describe("Presenter") {
            
            it("should initialise view"){
                self.presenter.initialiseView()
                expect(self.shotsView.initialisedCalled).to(beTrue())
            }
            
            it("should call load more action on interactor"){
                self.presenter.loadMoreAction()
                expect(self.interactor.loadMoreActionCalled).to(beTrue())
            }
            
            context("when shots fetched"){
            
                it("should infor view for error "){
                    self.presenter.errorFound(error: nil)
                    expect(self.shotsView.displayErrorCalled).to(beTrue())
                }
                
                it("should inform view for shots"){
                    let shots   =   [Shot](count:2, repeatedValue:Shot())
                    self.presenter.shotsFound(shots: shots)
                    
                    expect(self.shotsView.displayShotsCalled).to(beTrue())
                    expect(self.shotsView.shots!.count).to(equal(shots.count))
                }
            }
            
        }
        
        
        
        
        //MARK: Interactor Test
        describe("Interactor") {
            
            it("should call fetch shots on data manager"){
                let sorting =   ShotSorting(sort: .Popular)
                
                self.interactor.fetchShots(with: sorting)
                
                expect(self.dataManager.fetchShotsCalled).to(beTrue())
                expect(self.dataManager.currentSorting).to(equal(sorting))
            }
            
            it("should increase paging when load more called"){
                
                let sorting     =   ShotSorting(sort: .Recent)
                let page        =   1
                
                self.interactor.fetchShots(with: sorting)
                
                expect(self.interactor.currentPage).to(equal(page))
                
                self.interactor.loadMoreShots()
                
                expect(self.interactor.currentPage).to(equal(page + 1))
            }
            
            it("should reset page if new sorting is different"){
            
                let sorting     =   ShotSorting(sort: .Popular)
                let newSorting  =   ShotSorting(sort: .Recent)
                let page        =   1
                
                self.interactor.fetchShots(with: sorting)
                self.interactor.loadMoreShots()
                
                expect(self.interactor.currentPage).to(equal(page + 1))
                
                self.interactor.fetchShots(with: newSorting)
                
                expect(self.interactor.currentPage).to(equal(page))
            }
        }
        
        
        
        
        //MARK:DataManager Test
        
        describe("Data Manager") {
            
            context("when shots fetched"){
            
                it("should inform interactor for success"){
                    
                    let sorting =   ShotSorting(sort: .Popular)
                    let shots   =   [Shot](count:2,repeatedValue:Shot())
                    
                    self.dataManager.fetchShots(with: sorting, page: 0, perPage: 0)
                    self.api.sendSuccess(withObject: shots)
                    
                    expect(self.interactor.fetchingShotsCompleted).to(beTrue())
                    expect(self.interactor.currentResponse!).to(equal(DribbbleServiceResponse.Success(shots)))
                }
                
                it("should inform interactor for error"){
                    
                    let sorting =   ShotSorting(sort: .Popular)
                    let error   =   NSError(domain: "", code: 0, userInfo: nil)
                    
                    self.dataManager.fetchShots(with: sorting, page: 0, perPage: 0)
                    self.api.sendError(withError: error)
                    
                    expect(self.interactor.fetchingShotsCompleted).to(beTrue())
                    expect(self.interactor.currentResponse!).to(equal(DribbbleServiceResponse.Error(error)))
                }
            }
        }
        
    }
    
    
    
    
    
    //MARK: helpers
    
    
    func cellForSection(section:NSIndexPath)->UICollectionViewCell
    {
        let cell:UICollectionViewCell            =   (self.shotsView.stubCollectionView.dataSource?.collectionView(self.shotsView.stubCollectionView, cellForItemAtIndexPath: section))!
        
        return cell
    }
    
    
    
}
