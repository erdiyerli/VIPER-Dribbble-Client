//
//  Comment.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 14/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import ObjectMapper
import Fuzi

class Comment:Mappable,AttributedContentProtocol
{
    var id   :Int!
    var body :String!
    var user :User!
    
    lazy var attributedContent: NSAttributedString? =
    {
     
        guard self.body != nil else {return nil}
        
        let attributedBody      =   NSMutableAttributedString()
        
        let doc:HTMLDocument    =   try! HTMLDocument(string: self.body, encoding: NSUTF8StringEncoding)
        
        let xpath               =   doc.xpath("//p")
        
        for (index,element) in xpath.enumerate()
        {
            let attributed:NSMutableAttributedString  =   NSMutableAttributedString(string: element.stringValue)
            
            attributed.addAttribute(NSForegroundColorAttributeName, value: CommentCellColor.TextColor.color, range: NSMakeRange(0, element.stringValue.characters.count))
            
            
            for link in element.xpath("//a")
            {
                if let range = element.stringValue.rangeOfString(link.stringValue)
                {
                    
                    let range   =   (element.stringValue as NSString).rangeOfString(link.stringValue)
                    
                    attributed.addAttribute(NSForegroundColorAttributeName, value: CommentCellColor.LinkColor.color, range: range)
                    
                }

            }
            
            
            for newLine in element.xpath("//br")
            {
                attributed.appendAttributedString(NSAttributedString(string: "\n"))
            }
         
            attributedBody.appendAttributedString(attributed)
            
            
            if xpath.count > 0 && index < xpath.count - 1 && !element.stringValue.isEmpty
            {
                attributedBody.appendAttributedString(NSAttributedString(string: "\n"))
            }
            
        }
        
        return attributedBody
    }()
    
    init(){}
    required init?(_ map: Map) {}
    
    func mapping(map: Map)
    {
        self.id <- map["id"]
        self.body <- map["body"]
        self.user <- map["user"]
    }
} 