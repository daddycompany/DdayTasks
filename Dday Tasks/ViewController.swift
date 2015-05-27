//
//  ViewController.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 20..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import UIKit

//전역적으로 사용할 싱글턴 객체
struct Static {
    static var _viewControll:ViewController!
}

class ViewController: UIViewController {
    
    //xib의 컬렉션뷰 아울렛
    @IBOutlet var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Static._viewControll = self
        
        //위젯과 공유할 데이터 객체 생성,사용,동기화 예제
        let shareDefaults = NSUserDefaults(suiteName: "group.neocompany.ddaytasks")
        shareDefaults?.setObject("Message", forKey: "stringKey")
        shareDefaults?.synchronize()
        
        //리스트 갱신 처리
        self.listReload()
        
        //알람 설정
        setNotification()
    }
    
    //컬렉션뷰 갱신처리 
    func listReload(){
        //캘린더나, 리마인더에 등록된 일정 데이터 로드 호출
        CalendarEvent.getTasks()
        CalendarEvent.getEvents()
        
        //캘린더 데이터 로딩 되는 시간 대기 후 갱신
        delay(0.5){
            self.collectionView.reloadData()
        }
    }
    
    //기기의 메모리 워닝 발생시 호출 되는 함수, 통상적으로 메모리 사용을 줄이는 처리를 해주면 됨 (동작중인 작업 정지 등..)
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: UICollectionViewDataSource
    // 섹션 갯수 : 아이템이 반복되는 횟수 1로 두면 됨 , 2일때는 아이템이 2개씩 배치됨
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    //2 콜렉션 뷰의 아이템 갯수 반환
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Logger.log("CalendarEvent.eventList.count > \(CalendarEvent.eventList.count)")
        return CalendarEvent.eventList.count
    }
    //3 컬렉션 뷰의 셀을 생성 해주는 함수
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //        println("collectionView append \(indexPath.row)");
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell
    
        let taskData:TaskData = CalendarEvent.eventList[indexPath.row]
        cell.index = indexPath.row
        cell.text.text = taskData.title
        return cell
    }
    //컬렉션뷰의 셀 사이즈를 반환
    func collectionView(collectionView: UICollectionView!,
        layout collectionViewLayout: UICollectionViewLayout!,
        sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
            let sizeW = self.view.frame.size.width
            let sizeH:CGFloat = 50
            return CGSize(width: sizeW, height: sizeH)
    }

    
    //태스크 클릭 처리
    func handleSelectTask(taskIndex:Int){
        
    }
    
    //로컬 푸쉬 및 알람 노출시 액션 처리 예제
    func setNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handle_actionOne:", name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"handle_actionTwo:", name: "actionTwoPressed", object: nil)
        
        //로컬 푸쉬 시간값 생성 예제 
        /*
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2014;
        dateComp.month = 06;
        dateComp.day = 09;
        dateComp.hour = 15;
        dateComp.minute = 26;
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        */
        
        //15초 후에 로컬알림, 앱 실행 중일때는 나타나지 않음
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification"
        notification.fireDate = NSDate(timeIntervalSinceNow: 15)
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func handle_actionOne(notification:NSNotification){
        Logger.log("handle_actionOne")
    }
    
    func handle_actionTwo(notification:NSNotification){
        Logger.log("handle_actionTwo")
    }

}

