//
//  CalendarEvent.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 21..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import Foundation
import EventKit

class CalendarEvent{
    
    static var eventList = [TaskData]()
    
    static func getTasks(){
        let eventStore:EKEventStore = EKEventStore()
        //접근권한 요청
        eventStore.requestAccessToEntityType(EKEntityTypeEvent, completion: {
            granted, error in
            
            let endDate = NSDate(timeIntervalSinceNow: 604800*10);   //This is 10 weeks in seconds
            let predicate = eventStore.predicateForEventsWithStartDate(NSDate(), endDate: endDate, calendars: nil)
            let events = NSMutableArray(array: eventStore.eventsMatchingPredicate(predicate))
        
            Logger.log("events Count > \(events.count)")

            for eventItem in events{
                //모든캘린더에 등록된 이벤트 로드 파싱
                let _event:EKEvent = eventItem as! EKEvent
                if(_event.calendar.title == "Birthdays"){
                     //생일 이벤트는 제외
                }else{
                    let eventData:TaskData = self.parseEvent(_event)
                    Logger.log("eventData title \(eventData.title)")
                    self.eventList += [eventData]
                }
            }
            
            
            /*
            //캘린더 목록 가져오기
            let calendars = eventStore.calendarsForEntityType(EKEntityTypeEvent)
            for calendar in calendars as! [EKCalendar] {
                Logger.log("Calendar = \(calendar)")
                Logger.log("Calendar = \(calendar)")
            }
            */
           
        })
    }
    
    static func getEvents(){
        let eventStore:EKEventStore = EKEventStore()
        //접근권한 요청
        eventStore.requestAccessToEntityType(EKEntityTypeReminder, completion: {
            granted, error in
            
            let endDate = NSDate(timeIntervalSinceNow: 604800*10);   //This is 10 weeks in seconds
            //let predicate = eventStore.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
            let predicate = eventStore.predicateForIncompleteRemindersWithDueDateStarting(NSDate(), ending: endDate, calendars: nil)
            
            //let events = NSMutableArray(array: eventStore.eventsMatchingPredicate(predicate))
            eventStore.fetchRemindersMatchingPredicate(predicate, completion: {(reminders: [AnyObject]!) -> Void in
                for reminder in reminders {
                    Logger.log("Reminder = \(reminder)")
                    
                    /*

                    "Reminder = EKReminder <0x15696520> {title = ㅎㅎㅎ; dueDate = 2015-05-22 13:00:00 +0000; completionDate = (null); priority = 5; calendarItemIdentifier = 58CC09F4-9F45-4128-B5E2-25E1BE968B3E; alarms = (
                    "EKAlarm <0x155b6740> {triggerDate = 2015-05-22 13:00:00 +0000}"
                    
                    */
                }
            })

            /*
            //이벤트 목록 가져오기
            let rcalendars = eventStore.calendarsForEntityType(EKEntityTypeReminder)
            for calendar in rcalendars as! [EKCalendar] {
                Logger.log("Reminder = \(calendar.title)")
            }
            */
        })
    }

    
    static func parseEvent(_event:EKEvent) -> TaskData{
        /*
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
        
        //Logger.log("event > \(_event)")
        var returnTaskData = TaskData()
        
        if(_event.calendar.title == "Birthdays"){
            //생일 이벤트는 제외
        }else{
            
            returnTaskData.originEvent = _event
            returnTaskData.title = _event.title
            returnTaskData.startDate = _event.startDate
            
            var formatter = NSDateFormatter();
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ";
            let defaultTimeZoneStr = formatter.stringFromDate(_event.startDate);
            formatter.timeZone = NSTimeZone.localTimeZone()
            returnTaskData.startDateStr = formatter.stringFromDate(_event.startDate)
            
            let now = NSDate()
            let seventies = NSDate(timeIntervalSince1970: 0)
            let days = NSCalendar.currentCalendar().components(.CalendarUnitDay,
                fromDate: now, toDate: _event.startDate, options: nil).day
            
            //Logger.log("days > \(days)")
            returnTaskData.dday = days
            
            let hours = NSCalendar.currentCalendar().components(.CalendarUnitHour,
                fromDate: now, toDate: _event.startDate, options: nil).hour
            
            //Logger.log("hours > \(hours)")
            returnTaskData.hour = hours
            
            let minute = NSCalendar.currentCalendar().components(.CalendarUnitMinute,
                fromDate: now, toDate: _event.startDate, options: nil).minute
            
            //Logger.log("minute > \(minute)")
            returnTaskData.minute = minute
     
        }
        
        return returnTaskData
    }
    
    
    /*
    func fetchEvents(completed: (NSMutableArray) -> ()) {
        eventStore.requestAccessToEntityType(EKEntityType()) completion: { [weak weakEventStore = self.eventStore]
            granted, error in
            if let eventStore = weakEventStore {
                let endDate = NSDate(timeIntervalSinceNow: 604800*10);   //This is 10 weeks in seconds
                let predicate = eventStore.predicateForEventsWithStartDate(NSDate(), endDate: NSDate(), calendars: nil)
                let events = NSMutableArray(array: eventStore.eventsMatchingPredicate(predicate))
                completed(events)
            }
        })
    }
    */
}



