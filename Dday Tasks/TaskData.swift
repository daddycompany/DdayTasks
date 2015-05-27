//
//  TaskData.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 22..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import Foundation
import EventKit

class TaskData{
    init(){
        
    }
    
    var title = ""
    var startDate:NSDate!
    var dday:Int!
    var hour:Int!
    var minute:Int!
    var isReminder = false
    
    var taskItem:EKEvent!
    var reminderItem:EKReminder!
    
    func setReminderData(reminder:EKReminder){
        
    }
    
    func setTaskData(taskItem:EKEvent){
        isReminder = true
    }
}


/* 캘린더 아이템 데이터 샘플
{	 title = 		테이크웨더 서버 이전;
location = 	;
calendar = 	EKCalendar <0x14e69860> {title = ceo@daddycompany.com; type = CalDAV; allowsModify = YES; color = #2952A3FF;};
alarms = 		(
"EKAlarm <0x14d928d0> {triggerInterval = -600.000000}"
);
URL = 			(null);
lastModified = 2015-05-20 01:01:28 +0000;
startTimeZone = 	(null);
startTimeZone = 	(null)
};
location = 	;
structuredLocation = 	EKStructuredLocation <0x14d7bd60> {title = ; address = (null); geo = (null); abID = (null); routing = (null); radius = 0.000000;};
startDate = 	2015-05-19 15:00:00 +0000;
endDate = 		2015-05-22 14:59:59 +0000;
allDay = 		1;
floating = 	1;
recurrence = 	(null);
attendees = 	(null);
travelTime = 	(null);
startLocation = 	(null);
};"
*/


/* 리마인더 아이템 샘플
"Reminder = EKReminder <0x15696520> {title = ㅎㅎㅎ; dueDate = 2015-05-22 13:00:00 +0000; completionDate = (null); priority = 5; calendarItemIdentifier = 58CC09F4-9F45-4128-B5E2-25E1BE968B3E; alarms = (
"EKAlarm <0x155b6740> {triggerDate = 2015-05-22 13:00:00 +0000}"

*/