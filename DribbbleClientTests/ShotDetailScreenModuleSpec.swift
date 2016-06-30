//
//  ShotDetailScreenModuleSpec.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 29/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import Quick
import Nimble
@testable import DribbbleClient

class ShotDetailScreenModuleSpec: QuickSpec
{
    var view            :MockShotDetailScreenViewController!
    var presenter       :MockShotDetailScreenPresenter!
    var interactor      :MockShotDetailScreenInteractor!
    var dataManager     :MockShotDetailDataManager!
    var wireframe       :MockShotDetailScreenWireframe!
    var api             :MockDribbbleApi!
    
    override func spec()
    {
        beforeEach { 
            
            self.view           =   MockShotDetailScreenViewController()
            self.presenter      =   MockShotDetailScreenPresenter()
            self.interactor     =   MockShotDetailScreenInteractor()
            self.dataManager    =   MockShotDetailDataManager()
            self.wireframe      =   MockShotDetailScreenWireframe()
            self.api            =   MockDribbbleApi()
            
            self.view.presenter         =   self.presenter
            
            self.presenter.view         =   self.view
            self.presenter.wireFrame    =   self.wireframe
            self.presenter.interactor   =   self.interactor
            
            self.interactor.presenter   =   self.presenter
            self.interactor.dataManager =   self.dataManager
            
            self.dataManager.interactor =   self.interactor
            self.dataManager.api        =   self.api
        }
        
        afterEach { 
            
            self.view   =   nil
            self.presenter  =   nil
            self.interactor =   nil
            self.dataManager    =   nil
            self.api        =   nil
        }
        
        
        //MARK:ViewController Test
        describe("ViewController"){
        
            
            it("should call fetch comment on load"){
                
                _ = self.view.view
                expect(self.presenter.fetchCommentActionCalled).to(beTrue())
            }
            
            context("when tableview setup") {
                
                
                beforeEach({ 
                    self.view.setupTableVIew()
                })
                
                it("should have correct row count for related section"){
                
                    let userInfo    =   self.numberOfRowsInSection(.ShotDetailUserInfoSection)
                    
                    let shotImage    =   self.numberOfRowsInSection(.ShotDetailShotImageSection)
                    
                    let shotInfo    =   self.numberOfRowsInSection(.ShotDetailShotInfoSection)
                    
                    let comments    =   self.numberOfRowsInSection(.ShotDetailCommentsSection)
                    
                    expect(userInfo).to(equal(1))
                    expect(shotImage).to(equal(1))
                    expect(shotInfo).to(equal(1))
                    expect(comments).to(equal(0))
                    
                }
                
                
                it("should have correct cell for related section"){
                    
                    let userInfo    =   self.cellForSection(.ShotDetailUserInfoSection)
                    let shotImage   =   self.cellForSection(.ShotDetailShotImageSection)
                    let shotInfo    =   self.cellForSection(.ShotDetailShotInfoSection)
                    let comments    =   self.cellForSection(.ShotDetailCommentsSection)
                    
                    
                    expect(userInfo).to(beAKindOf(UserInfoTableViewCell.self))
                    expect(shotImage).to(beAKindOf(ShotImageTableViewCell.self))
                    expect(shotInfo).to(beAKindOf(ShotInfoTableViewCell.self))
                    expect(comments).to(beAKindOf(ShotCommentTableViewCell.self))
                    
                }
            }
            
            
            context("when display shots called") {
                
                it("should add shot description as a comment"){
                
                    self.view.displayShot(self.view.stubShot)
                    
                    expect(self.view.comments.count).to(equal(1))
                }
            }
            
        }
        
        
        
        
        
        
        //MARK: Presenter Test
        describe("Presenter") {
            
            it("should configure view with shot"){
                
                self.presenter.configureView(withShot: Shot())
                
                expect(self.view.displayShotCalled).to(beTrue())
            }
            
            it("inform interactor for fetch comments action"){
                
                self.presenter.fetchCommentsAction(shotID: 0, commentsCount: 0)
                expect(self.interactor.fetchCommentCalled).to(beTrue())
            }
            
            it("should inform view for new comments"){
                
                let comments    =   [Comment](count:2, repeatedValue:Comment())
                
                self.presenter.commentsFound(comments)
                
                expect(self.view.displayCommentsCalled).to(beTrue())
            }
            
            it("sjould inform wireframe for dismiss"){
                
                self.presenter.dismissControllerAction()
                expect(self.wireframe.dismissCalled).to(beTrue())
            }
            
        }
        
        
        //MARK: Interactor Test
        describe("Interactor") {
            
            
            it("should inform data manager for comments"){
                
                self.interactor.fetchComments(shotID: 0, commentsCount: 0)
                
                expect(self.dataManager.commentsByCalled).to(beTrue())
            }
            
            it("should inform presenter for comments"){
                
                self.interactor.commentsByShotIDCompleted(response: .Success([]))
                
                expect(self.presenter.commentsFoundCalled).to(beTrue())
            }
            
        }
        
        
        
        //MARK:DataManager Test
        
        describe("DataManager") {
            
            it("should inform interactor for service response"){
                
                self.dataManager.commentsBy(shotID: 0, commentsCount: 0)
                self.api.sendSuccess(withObject: [])
                
                expect(self.interactor.commentsByShotIDCompletedCalled).to(beTrue())
            }
        }
        
        
    }
    
    
    
    
    
    //MARK: helpers
    
    
    func cellForSection(section:ShotDetailSection)->UITableViewCell
    {
        let cell    =   self.view.tableView.dataSource!.tableView(self.view.tableView, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: section.rawValue))
        
        return cell
    }
    
    func numberOfRowsInSection( section:ShotDetailSection)->Int
    {
        let numberOfRows    =   self.view.tableView.dataSource!.tableView(self.view.tableView, numberOfRowsInSection: section.rawValue)
        
        return numberOfRows
    }
    
}






