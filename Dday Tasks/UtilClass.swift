//
//  UtilClass.swift
//  InstaRoll
//
//  Created by kimchul on 2015. 4. 21..
//  Copyright (c) 2015년 thomas. All rights reserved.
//

import Foundation
import CoreGraphics
import UIKit
import AVFoundation

//알림 처리
func showDefaultAlert(parent:UIViewController,title:String,message:String){
    let controller = UIAlertController(title: title,message: message, preferredStyle: .Alert)
    
    let action_ok = UIAlertAction(title: "OK",
        style: UIAlertActionStyle.Default,
        handler: {[weak parent] (paramAction:UIAlertAction!) in
            
        })
    
    parent.presentViewController(controller, animated: true, completion: nil)
    controller.addAction(action_ok)
}

//알림 처리
func showConfirmAlert(parent:UIViewController,title:String,message:String,callback:() -> Void,nocallback:() -> Void){
    let controller = UIAlertController(title: title,message: message, preferredStyle: .Alert)
    
    let action_cancel = UIAlertAction(title: "NO",
        style: UIAlertActionStyle.Default,
        handler: {[weak parent] (paramAction:UIAlertAction!) in
            nocallback()
        })
    
    
    let action_ok = UIAlertAction(title: "YES",
        style: UIAlertActionStyle.Default,
        handler: {[weak parent] (paramAction:UIAlertAction!) in
            
            callback()
            
        })
    
    parent.presentViewController(controller, animated: true, completion: nil)
    controller.addAction(action_cancel)
    controller.addAction(action_ok)
}

//알림 처리
func showJustConfirmAlert(parent:UIViewController,title:String,message:String,callback:() -> Void){
    let controller = UIAlertController(title: title,message: message, preferredStyle: .Alert)
    
    let action_cancel = UIAlertAction(title: "NO",
        style: UIAlertActionStyle.Default,
        handler: {[weak parent] (paramAction:UIAlertAction!) in
            
        })
    
    
    let action_ok = UIAlertAction(title: "YES",
        style: UIAlertActionStyle.Default,
        handler: {[weak parent] (paramAction:UIAlertAction!) in
            
            callback()
            
        })
    
    parent.presentViewController(controller, animated: true, completion: nil)
    controller.addAction(action_cancel)
    controller.addAction(action_ok)
}

//
func toRoundButton(button:UIButton){
    button.layer.cornerRadius = 0.5 * button.bounds.size.width
    button.clipsToBounds=true
}
func toRoundButtonValue(button:UIButton,value:Int){
    button.layer.cornerRadius = CGFloat(value)
    button.clipsToBounds=true
}

func toRoundView(view:UIView){
    view.layer.cornerRadius = 0.5 * view.bounds.size.width
    view.clipsToBounds=true
}
func toRoundImageView(view:UIImageView){
    view.layer.cornerRadius = 0.5 * view.bounds.size.width
    view.clipsToBounds=true
}

func shadowToView(view:UIView){
    view.layer.shadowOffset = CGSizeMake(1, 1);
    view.layer.shadowColor = UIColor.blackColor().CGColor
    view.layer.shadowOpacity = 0.4;
    view.layer.shadowRadius = 2
}

//로딩 아이콘

func setLodingLayer(_view:UIView){
    let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    // Create CAShapeLayerS
    let rectShape = CAShapeLayer()
    rectShape.bounds = bounds
    rectShape.position = CGPoint(x:100,y:100)
    rectShape.cornerRadius = bounds.width / 2
    
    // Apply effects here
    // 1
    rectShape.path = UIBezierPath(ovalInRect: rectShape.bounds).CGPath
    
    rectShape.lineWidth = 4.0
    rectShape.strokeColor = UIColor.lightGrayColor().CGColor
    rectShape.fillColor = UIColor.clearColor().CGColor
    
    // 2
    rectShape.strokeStart = 0
    rectShape.strokeEnd = 0.5
    
    // 3
    let start = CABasicAnimation(keyPath: "strokeStart")
    start.toValue = 0.7
    let end = CABasicAnimation(keyPath: "strokeEnd")
    end.toValue = 1
    
    // 4
    let group = CAAnimationGroup()
    group.animations = [start, end]
    group.duration = 1.5
    group.autoreverses = true
    group.repeatCount = HUGE // repeat forver
    rectShape.addAnimation(group, forKey: nil)
    
    _view.layer.addSublayer(rectShape)
}


//딜레이 함수
func delay(delay:Double, closure:()->()) {
    dispatch_after(
        dispatch_time(
            DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))
        ),
        dispatch_get_main_queue(), closure)
}

//배열요소중 랜덤하게 가져오기
/*ex
let array = [1, 2, 3, 4]
array.sample() // 2
*/
extension Array {
    func sample() -> T {
        let randomIndex = Int(rand()) % count
        return self[randomIndex]
    }
}

/*
var color = UIColor(red: 0xFF, blue: 0xFF, green: 0xFF)
var color2 = UIColor(netHex:0xFFFFFF)
*/
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

func printFonts() {
    let fontFamilyNames = UIFont.familyNames()
    for familyName in fontFamilyNames {
        println("------------------------------")
        println("Font Family Name = [\(familyName)]")
        let names = UIFont.fontNamesForFamilyName(familyName as! String)
        println("Font Names = [\(names)]")
    }
}

func imageWithColor(img:UIImage, color:UIColor)->UIImage{
    UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale);
    var context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    var rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextClipToMask(context, rect, img.CGImage)
    color.setFill();
    CGContextFillRect(context, rect);
    var newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


public extension Int {
    /**
    Returns a random integer between 0 and n-1.
    */
    public static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    /**
    Create a random num Int
    :param: lower number Int
    :param: upper number Int
    :return: random number Int
    By DaRkDOG
    */
    public static func random(#min: Int, max: Int) -> Int {
        return Int(arc4random_uniform(UInt32(max - min + 1))) + min
    }
}
public extension Double {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Double {
        return Double(arc4random()) / 0xFFFFFFFF
    }
    
    /**
    Create a random num Double
    :param: lower number Double
    :param: upper number Double
    :return: random number Double
    By DaRkDOG
    */
    public static func random(#min: Double, max: Double) -> Double {
        return Double.random() * (max - min) + min
    }
}
public extension Float {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> Float {
        return Float(arc4random()) / 0xFFFFFFFF
    }
    /**
    Create a random num Float
    :param: lower number Float
    :param: upper number Float
    :return: random number Float
    By DaRkDOG
    */
    public static func random(#min: Float, max: Float) -> Float {
        return Float.random() * (max - min) + min
    }
}
public extension CGFloat {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    /**
    Create a random num CGFloat
    :param: lower number CGFloat
    :param: upper number CGFloat
    :return: random number CGFloat
    By DaRkDOG
    */
    public static func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}


