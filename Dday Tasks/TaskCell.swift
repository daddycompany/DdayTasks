//
//  CollectionViewCell.swift
//  UICollectionView
//
//  Created by Brian Coleman on 2014-09-04.
//  Copyright (c) 2014 Brian Coleman. All rights reserved.
//

import UIKit

class TaskCell: UICollectionViewCell {
    
    @IBOutlet var imgview:UIImageView!
    @IBOutlet var text:UILabel!
    
    var index:Int!
    var isSelectedCheck:Bool = false
    @IBAction func ImageSelectHandle(sender: AnyObject) {
        //원본이미지 로드
        Static._viewControll.handleSelectTask(index)
    }

}



