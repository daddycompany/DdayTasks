//
//  AddTaskController.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 22..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class EditTaskController: UIViewController{
    
    var taskData:TaskData!
    
    @IBOutlet weak var titleTextInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taskData = CalendarEvent.eventList[Static._viewControll.selectedTaskIndex]
        titleTextInput.text = taskData.title
    }
    
    //뒤로가기, 팝업 닫기 처리
    @IBAction func closePopup(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //수정 버튼 클릭 처리
    @IBAction func handle_editButtonClick(sender: AnyObject) {
        taskData.originEvent.title = titleTextInput.text
        CalendarEvent.editEvent(taskData.originEvent,_eventid: taskData.id)
    }
    
}