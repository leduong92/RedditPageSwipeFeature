//
//  MainCell.swift
//  SwipingPage
//
//  Created by Mai Le Duong on 7/30/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    let newsItemsController = NewsItemsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let newsItemsView = newsItemsController.view!
        addSubview(newsItemsView)
        newsItemsView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

