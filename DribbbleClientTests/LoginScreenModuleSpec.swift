//
//  LoginScreenModuleSpec.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 28/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import Quick
import Nimble

@testable import DribbbleClient

class LoginScreenModuleSpec: QuickSpec
{
    var loginView       :MockLoginScreenViewController!
    var presenter       :MockLoginScreenPresenter!
    var interactor      :MockLoginScreenInteractor!
    var dataManager     :MockLoginScreenDataManager!
    var wireframe       :MockLoginScreenWireFrame!
    var api             :MockDribbbleApi!
    
    override func spec()
    {
        
        beforeEach{
            
            
            self.loginView              =   MockLoginScreenViewController()
            self.presenter              =   MockLoginScreenPresenter()
            self.interactor             =   MockLoginScreenInteractor()
            self.dataManager            =   MockLoginScreenDataManager()
            self.wireframe              =   MockLoginScreenWireFrame()
            self.api                    =   MockDribbbleApi()
            
            self.loginView.presenter    =   self.presenter
            self.presenter.view         =   self.loginView
            self.presenter.interactor   =   self.interactor
            self.presenter.wireFrame    =   self.wireframe
            
            self.interactor.presenter   =   self.presenter
            self.interactor.dataManager =   self.dataManager
            
            self.dataManager.interactor =   self.interactor
            self.dataManager.service    =   self.api
            
            
        }
        
        
        afterEach { 
            self.loginView  =   nil
            self.presenter  =   nil
            self.interactor =   nil
            self.dataManager    =   nil
            self.wireframe  =   nil
            self.api        =   nil
        }
        
        
        
        //MARK: LoginViewController Test
        describe("LoginView"){
        
            context("when dribbble button tapped")
            {
                
                beforeEach({ 
                    self.loginView.dribbbleButtonTapped(NSObject())
                })
                
                it("should call authenticate on presenter") {
                    
                    expect(self.presenter.authenticateCalled).to(beTrue())
                }
                
                it("should show indicator and disable button"){
                    
                    expect(self.loginView.stubIndicator.hidden).to(beFalse())
                    expect(self.loginView.stubIndicator.isAnimating()).to(beTrue())
                    expect(self.loginView.stubDribbbleButton.userInteractionEnabled).to(beFalse())
                    
                }
            }
            
            
            context("when authentication failed")
            {
                it("should hide indicator and enable button"){
                    
                    self.loginView.showAuthenticationFailedMessage()
                    
                    expect(self.loginView.stubIndicator.hidden).to(beTrue())
                    expect(self.loginView.stubIndicator.isAnimating()).to(beFalse())
                    expect(self.loginView.stubDribbbleButton.userInteractionEnabled).to(beTrue())
                }
                
                
                it("should present alertView"){
                    
                    let nav                     =   UINavigationController(rootViewController: self.loginView)
                    
                    let window                  =   UIWindow(frame: CGRect.zero)
                    window.rootViewController   =   nav
                    
                    window.makeKeyAndVisible()
                    
                    
                    self.loginView.showAuthenticationFailedMessage()
                    
                    expect(self.loginView.presentedViewController).to(equal(self.loginView.alertView))
                }
            }
            
        
        }
        
        
        
        //MARK: LoginScreen Presenter Test
        describe("LoginScreen Presenter") { 
            
            it("should call authenticate on Interactor"){
            
                self.presenter.authenticateAction()
                expect(self.interactor.authenticateCalled).to(beTrue())
            }
            
            it("should inform view when authenticating"){
                
                self.presenter.authenticateAction()
                expect(self.loginView.showAuthenticatingCalled).to(beTrue())
            }
            
            it("should inform view for authentication error"){
                
                let error = NSError(domain: "", code: 0, userInfo: nil)
                self.presenter.authenticationFailed(error: error)
                expect(self.loginView.showAuthenticationErrorMessageCalled).to(beTrue())
            }
            
            it("should inform wireframe for authentication success"){
                
                self.presenter.authenticationSucceeded()
                expect(self.wireframe.authenticationSucceededCalled).to(beTrue())
            }
            
        }
        
        
        
        
        //MARK: LoginScreen Interactor Test
        describe("LoginScreen Interactor") {
            
            it("should call authenticate on DataManager"){
                
                self.interactor.doAuthentication()
                expect(self.dataManager.authenticateCalled).to(beTrue())
            }
            
            it("should inform presenter for authentication failure "){
                
                let error   =   NSError(domain: "", code: 0, userInfo: nil)
                self.interactor.authenticationFailed(error: error)
                expect(self.presenter.authenticationFailedCalled).to(beTrue())
            }
            
            it("should inform presenter for authentication error"){
                
                let error = NSError(domain: "", code: 0, userInfo: nil)
                self.interactor.authenticationFailed(error: error)
                expect(self.presenter.authenticationFailedCalled).to(beTrue())
            }
            
            it("should inform view for authentication success"){
                
                self.interactor.authenticationSucceeded(accessToken: "")
                expect(self.presenter.authenticationSucceededCalled).to(beTrue())
            }
            
        }
        
        
        
        //MARK: LoginScreen DataManager Test
        describe("LoginScreen DataManager") {
            
            it("should call authenticate on api"){
                
                self.dataManager.authenticate()
                expect(self.api.authenticateCalled).to(beTrue())
            }
            
            it("should inform interactor for authentication failure "){
                
                let error   =   NSError(domain: "", code: 0, userInfo: nil)
                self.dataManager.authenticate()
                self.api.sendError(withError: error)
                
                expect(self.interactor.authenticationFailedCalled).to(beTrue())
            }
            
            it("should inform interactor for authentication Success "){
                
                
                self.dataManager.authenticate()
                self.api.sendSuccess(withObject: "")
                
                expect(self.interactor.authenticationSucceededCalled).to(beTrue())
            }
            
        }
        
        
    }
    
}
