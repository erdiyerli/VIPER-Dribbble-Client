//
// Created by Erdi Yerli
// Copyright (c) 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import UIKit

class LoginScreenViewController: UIViewController,LoginScreenViewProtocol
{
    
    @IBOutlet weak var indicator :UIActivityIndicatorView!
    @IBOutlet weak var dribbbleButton :UIButton!
    
    var presenter: LoginScreenPresenterProtocol?
    
    var alertView:UIAlertController!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.indicator.stopAnimating()
    }
    
    
   
    func showAuthenticationFailedMessage()
    {
        self.alertView  =   UIAlertController(title: "", message: "Authentication Failed!", preferredStyle: .Alert)
        self.alertView.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alertView, animated: false, completion: nil)
        

        self.indicator.stopAnimating()
        self.dribbbleButton.userInteractionEnabled  =   true
    }
    
    func showAuthenticating()
    {
        self.indicator.hidden   =   false
        self.indicator.startAnimating()
        self.dribbbleButton.userInteractionEnabled  =   false
    }
    
    
    @IBAction func dribbbleButtonTapped(sender: AnyObject)
    {
        guard let output = self.presenter else { return }
        
        output.authenticateAction()
    }
    
}