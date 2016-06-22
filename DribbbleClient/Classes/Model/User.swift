//
//  User.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import ObjectMapper

class User:Mappable
{
    var id                      :Int!
    var name                    :String!
    var username                :String!
    var html_url                :String!
    var avatar_url              :String!
    var bio                     :String!
    var location                :String!
    var web_link                :String!
    var twitter_link            :String!
    var bucket_count            :Int!
    var comments_recieved_count :Int!
    var followers_count         :Int!
    var followings_count        :Int!
    var likes_count             :Int!
    var likes_recieved_count    :Int!
    var project_count           :Int!
    var rebounds_received_count :Int!
    var shots_count             :Int!
    var teams_count             :Int!
    var can_upload_shot         :Bool!
    var type                    :String!
    var pro                     :Bool!
    var buckets_url             :String!
    var followers_url           :String!
    var following_url           :String!
    var likes_url               :String!
    var shots_url               :String!
    var teams_url               :String!
    var created_at              :String!
    var updated_at              :String!
    
    init(){}
    
    required init?(_ map: Map) {}
    
    init( id:Int, name:String, username:String)
    {
        self.id         =   id
        self.name       =   name
        self.username   =   username
    }
    
    func mapping(map: Map)
    {
        
        self.id         <- map["id"]
        self.name       <- map["name"]
        self.username   <- map["username"]
        self.avatar_url <- map["avatar_url"]
        self.bio        <- map["bio"]
      
    }
   
}
