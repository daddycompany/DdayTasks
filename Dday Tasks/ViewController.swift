//
//  ViewController.swift
//  Dday Tasks
//
//  Created by kimchul on 2015. 5. 20..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import UIKit

struct Static {
    static var _viewControll:ViewController!
}

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var tasksList = ["test","test1","test","test1","test","test1","test","test1","test","test1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Static._viewControll = self
        
        // Do any additional setup after loading the view, typically from a nib.
        
        let shareDefaults = NSUserDefaults(suiteName: "group.neocompany.ddaytasks")
        shareDefaults?.setObject("Message", forKey: "stringKey")
        shareDefaults?.synchronize()
        
        Logger.log("viewDidLoad")

        
        CalendarEvent.getTasks()
        CalendarEvent.getEvents()
        
        setNotification()
    }
    
    
    // MARK: UICollectionViewDataSource
    
    // 섹션 갯수
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //2
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("collectionView justcount \(tasksList.count)");
        return tasksList.count
    }
    
    //3
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //        println("collectionView append \(indexPath.row)");
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("TaskCell", forIndexPath: indexPath) as! TaskCell
        let sizeW = self.view.frame.size.width
        let sizeH = 50
        cell.index = indexPath.row
        cell.text.text = tasksList[indexPath.row]
        
        
        return cell
    }
    
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
    
    
    
    func setNotification(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"drawAShape:", name: "actionOnePressed", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"showAMessage:", name: "actionTwoPressed", object: nil)
        
        var dateComp:NSDateComponents = NSDateComponents()
        dateComp.year = 2014;
        dateComp.month = 06;
        dateComp.day = 09;
        dateComp.hour = 15;
        dateComp.minute = 26;
        dateComp.timeZone = NSTimeZone.systemTimeZone()
        
        
        var notification:UILocalNotification = UILocalNotification()
        notification.category = "FIRST_CATEGORY"
        notification.alertBody = "Hi, I am a notification"
        notification.fireDate = NSDate(timeIntervalSinceNow: 15)
        
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    func drawAShape(notification:NSNotification){
        var view:UIView = UIView(frame:CGRectMake(10, 10, 100, 100))
        view.backgroundColor = UIColor.redColor()
        
        self.view.addSubview(view)
        
    }
    
    func showAMessage(notification:NSNotification){
        var message:UIAlertController = UIAlertController(title: "A Notification Message", message: "Hello there", preferredStyle: UIAlertControllerStyle.Alert)
        message.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(message, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

