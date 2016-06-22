//
//  DribbbleApi.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import Foundation
import OAuthSwift
import ObjectMapper


class DribbbleApi: DribbbleServiceProtocol
{
    var oauthSwift :    OAuth2Swift!
    var accessToken :   String?
    
    init( accessToken:String?)
    {
        self.accessToken    =   accessToken
        
        self.oauthSwift =   OAuth2Swift(
            consumerKey: DRIBBBLE_APP_KEY,
            consumerSecret: DRIBBBLE_APP_SECRET,
            authorizeUrl: "https://dribbble.com/oauth/authorize",
            accessTokenUrl: "https://dribbble.com/oauth/token",
            responseType: "code")
    }
    
    
    func authenticateUser(completion: DribbbleServiceCompletionBlock)
    {
        let callBackUrl =   "dribbble-client://oauth-callback/dribbble"
        
        self.oauthSwift.authorizeWithCallbackURL(NSURL(string: callBackUrl)!, scope: "public", state: "Dribbble", success: { (credential, response, parameters) in
            
            completion(response: .Success( credential.oauth_token))
            
            }) { (error) in
            
            completion(response: .Error(error))
        }
    }
    
    
    let FetchShotsURL   =   "https://api.dribbble.com/v1/shots?"
    
    func fetchShots(with sorting: ShotSorting, page: Int, perPage: Int, completion: DribbbleServiceCompletionBlock) {
        
        var url = "\(FetchShotsURL)page=\(page)&per_page=\(perPage)"
        
        if let sort = sorting.sort {
            
            url += "&sort=\(sort.rawValue)"
        }
        
        if let list = sorting.list
        {
            url += "&list=\(list.rawValue)"
        }
        
        
        if let timeframe = sorting.timeframe
        {
            url += "&timeframe=\(timeframe.rawValue)"
        }
        
        self.oauthSwift.client.get(url,
                                   parameters: [:],
                                   headers: ["Authorization":"Bearer \(self.accessToken!)"],
                                   success: { (data, response) in
                                   
                                    
                                    do{
                                        
                                        let json:[AnyObject]    =   try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
                                        
                                        
                                        let shots = Mapper<Shot>().mapArray(json)
                                        
                                        completion(response: .Success(shots))
                                        
                                        
                                    }catch let error{
                                        
                                        completion(response: .Error(error as NSError))
                                    }
                                   
            }) { (error) in
                
                completion(response: .Error(error as NSError))
        }
        
    }
    
    
    let FetchCommentsURL   =   "https://api.dribbble.com/v1/shots/%d/comments?per_page=%d"
    
    func fetchComments(shotID shotID: Int, commentsCount:Int, completion: DribbbleServiceCompletionBlock)
    {
        let url =   String(format: FetchCommentsURL, arguments: [shotID,commentsCount])
        
        self.oauthSwift.client.get(url,
                                   parameters: [:],
                                   headers: ["Authorization":"Bearer \(self.accessToken!)"],
                                   success: { (data, response) in
                                    
                                    
                                    do{
                                        
                                        let json:[AnyObject]    =   try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
                                        
                                        
                                        let comments = Mapper<Comment>().mapArray(json)
                                        
                                        completion(response: .Success(comments))
                                        
                                        
                                    }catch let error{
                                        
                                        completion(response: .Error(error as NSError))
                                    }
                                    
        }) { (error) in
            
            completion(response: .Error(error as NSError))
        }

    }
    
}
