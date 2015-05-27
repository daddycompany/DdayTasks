//
//  TodayViewController.swift
//  Widjet
//
//  Created by kimchul on 2015. 5. 20..
//  Copyright (c) 2015년 neosoft. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    let viewHeight = 300
    @IBOutlet weak var scroller: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        Logger.log("start widjet")
        scroller.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 2, 600)
        
        delay(3){
            self.scroller.contentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 2, 600)
            self.preferredContentSize = CGSizeMake(UIScreen.mainScreen().bounds.width * 2, 600);
            //self.updateScrollViewContent()
            self.updateViewConstraints()
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdateWithCompletionHandler(completionHandler: ((NCUpdateResult) -> Void)!) {
        // Perform any setup necessary in order to update the view.
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        let shareDefaults = NSUserDefaults(suiteName: "group.neocompany.ddaytasks")
        //self.widgetLabel.text =  shareDefaults?.objectForKey("stringKey") as? String

        completionHandler(NCUpdateResult.NewData)
    }
    
    func widgetMarginInsetsForProposedMarginInsets
        (defaultMarginInsets: UIEdgeInsets) -> (UIEdgeInsets) {
            return UIEdgeInsetsZero
    }
    
    override func viewWillAppear(animated: Bool)
    {
//        self.preferredContentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, self.view.bounds.height);
        self.preferredContentSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 300);
        Logger.log("viewWillAppear > \(self.preferredContentSize)")
    }

}
