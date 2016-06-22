//
//  ServiceProtocol.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 27/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit

extension DribbbleServiceResponse:Equatable
{
    
    
}

func ==(lhs: DribbbleServiceResponse, rhs: DribbbleServiceResponse) -> Bool {
    
    switch (lhs,rhs)
    {
    case (let .Success(responseA) , let .Success(responseB)):
    
        return responseA?.dynamicType == responseB?.dynamicType
        
        
    case (let .Error(errorA) , let .Error(errorB)):
        
        return errorA.dynamicType == errorB.dynamicType
        
   
        default:break
    }
    
    return false
        
}

enum DribbbleServiceResponse
{
    case Success( Any? )
    case Error( NSError )
}


typealias DribbbleServiceCompletionBlock = ( response:DribbbleServiceResponse)->(Void)

protocol DribbbleServiceProtocol: class
{
    func authenticateUser( completion :DribbbleServiceCompletionBlock )
    
    func fetchShots(with sorting:ShotSorting, page:Int, perPage:Int, completion:DribbbleServiceCompletionBlock)
    
    func fetchComments( shotID shotID:Int, commentsCount:Int, completion : DribbbleServiceCompletionBlock)
}
