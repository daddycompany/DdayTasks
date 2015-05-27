//
//  AddTaskController.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 22..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import Foundation
import UIKit

class AddTaskController: UIViewController{
    
    
    //뒤로가기, 팝업 닫기 처리 
    @IBAction func closePopup(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}