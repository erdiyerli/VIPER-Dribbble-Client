//
//  Extensions.swift
//  DribbbleClient
//
//  Created by Erdi Yerli on 25/05/2016.
//  Copyright © 2016 Erdi Yerli. All rights reserved.
//

import UIKit
import Fuzi


extension UICollectionViewCell
{
    
    static var classNameReuseIdentifier:String{
        return "\(self)"
    }
    
    
    class func registerCollectionView(collectionView collectionView:UICollectionView, reuseIdentifier:String)
    {
        let nib =   UINib(nibName: classNameReuseIdentifier , bundle: NSBundle.mainBundle())
        
        collectionView.registerNib(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}



extension UITableViewCell
{
    static var classNameReuseIdentifier:String{
        return "\(self)"
    }
    
    
    class func registerTableViewView(tableView tableView:UITableView, reuseIdentifier:String)
    {
        let nib =   UINib(nibName: classNameReuseIdentifier , bundle: NSBundle.mainBundle())
        
        tableView.registerNib(nib, forCellReuseIdentifier: reuseIdentifier)
    }
}


extension UIViewController
{
    
    class func createFromStoryboard(storyboardName name:String)-> UIViewController
    {
        let storyboard  =   UIStoryboard(name: name, bundle: NSBundle.mainBundle())
        
        return storyboard.instantiateViewControllerWithIdentifier("\(self)")
    }
    
}


