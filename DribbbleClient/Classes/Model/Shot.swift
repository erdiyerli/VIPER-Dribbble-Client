//
//  Shot.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 28/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//



import UIKit
import ObjectMapper



class ShotImages:Mappable
{
    var hidpi   :String?
    var normal   :String!
    var teaser   :String!
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map)
    {
        self.hidpi  <- map["hidpi"]
        self.normal  <- map["normal"]
        self.teaser  <- map["teaser"]
    }
}

class Shot:Mappable
{
    var id                  :Int!
    var title               :String!
    var description         :String!
    var width               :String!
    var height              :String!
    var images              :ShotImages!
    var views_count         :Int!
    var likes_count         :Int!
    var comments_count      :Int!
    var attachments_count   :Int!
    var rebounds_count      :Int!
    var buckets_count       :Int!
    var created_at          :String!
    var updated_at          :String!
    var html_url            :String!
    var attachments_url     :String!
    var buckets_url         :String!
    var comments_url        :String!
    var likes_url           :String!
    var projects_url        :String!
    var rebounds_url        :String!
    var animated            :Bool!
    var tags                :[String]!
    var user                :User!
    
    
    required init?(_ map: Map) {}
    
    func mapping(map: Map)
    {
        self.id             <- map["id"]
        self.title          <- map["title"]
        self.description    <- map["description"]
        self.width          <- map["width"]
        self.height         <- map["height"]
        self.images         <- map["images"]
        self.views_count    <- map["views_count"]
        self.likes_count    <- map["likes_count"]
        self.comments_count <- map["comments_count"]
        self.user           <- map["user"]
        self.animated       <- map["animated"]
       
    }
    
    init()
    {
        self.id             =   0
        self.title          =   ""
        self.description    =   ""
        self.views_count    =   0
        self.likes_count    =   0
        self.comments_count =   0
        self.user           =   User(id: 0, name: "", username: "")
    }
}