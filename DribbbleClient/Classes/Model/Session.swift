//
//  Session.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 15/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit


let TOKEN_KEY   =   "token"

class Session: NSObject
{
    class var sharedSession:Session
        {
        
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: Session? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = Session()
        }
        return Static.instance!
    }
    
    
    private func accessToken()->String?
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        return defaults.objectForKey(TOKEN_KEY) as? String
    }
    
    func currentCredentials()->Credentials?
    {
        guard let token = self.accessToken() else {return nil}
        
        return Credentials(accessToken: token)
    }
    
    
    func updateCredentials(accessToken token:String)
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(token, forKey: TOKEN_KEY)
        defaults.synchronize()
    }
    
    func clearCredentials()
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        defaults.setObject(nil, forKey: TOKEN_KEY)
        defaults.synchronize()
        
    }
    
}
