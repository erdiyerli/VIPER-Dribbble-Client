//
//  Constants.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 15/06/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit



let DRIBBBLE_APP_KEY        =   <#T##String#>
let DRIBBBLE_APP_SECRET     =   <#T##String#>



enum ViewControllerState {
    case Loaded
    case Loading
    case Error
}


enum CommentCellColor {
    case Light
    case Dark
    case TextColor
    case LinkColor
    
    var color:UIColor{
        
        switch self {
        case .Dark      : return UIColor(red:0.953, green:0.953, blue:0.953, alpha:1.00)
            
        case .Light     : return UIColor(red:0.984, green:0.984, blue:0.984, alpha:1.00)
            
        case .TextColor : return UIColor.darkTextColor()
            
        case .LinkColor : return UIColor.redColor()
        }
    }
}


struct ShotSorting:Equatable
{
    let sort        :Sort?
    let list        :List?
    let timeframe   :Timeframe?
    
    init( sort:Sort)
    {
        self.sort       =   sort
        self.list       =   nil
        self.timeframe  =   nil
    }
    
    init( sort:Sort?, list:List, timeframe:Timeframe?)
    {
        self.sort       =   sort
        self.list       =   list
        self.timeframe  =   timeframe
    }
    
    enum Sort:String {
        
        case Popular    =   "popular"
        case Recent     =   "recent"
        case Views      =   "views"
        case Comments   =   "comments"
    }
    
    enum List:String {
        
        case Animated    =   "animated"
        case Attachments =   "attachments"
        case Debuts      =   "debuts"
        case Playoffs    =   "playoffs"
        case Rebounds    =   "rebounds"
        case Teams       =   "teams"
    }
    
    enum Timeframe:String {
        
        case Week       =   "week"
        case Month      =   "month"
        case Year       =   "year"
        case Ever       =   "ever"
    }
    
    
}

func == (lhs:ShotSorting, rhs:ShotSorting)-> Bool
{
    return (lhs.sort == rhs.sort && lhs.list == rhs.list && lhs.timeframe == rhs.timeframe)
}




protocol AttributedContentProtocol {
    var attributedContent  :NSAttributedString? {get}
}