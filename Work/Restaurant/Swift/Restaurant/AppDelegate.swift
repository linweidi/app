//
//  AppDelegate.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

let secondsInMinute = 60.0

enum RateApp: Int {
    case Declined = 0
    case Confirmed
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Remove comments to add Flurry Analytics more information here - www.flurry.com
        // let flurrySessionId = ConfigurationManager.sharedManager.flurrySessionId
        // Flurry.startSession(flurrySessionId)
        
        initAppiRater()
        
        //init rate timer
        initRateAppTimer()
        
        ThemeManager.sharedManager.applyNavigationBarTheme()
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: false)
        
        return true
    }
    
    class func sharedDelegate() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    func showAppRate() {
        let didShowAppRate = NSUserDefaults.standardUserDefaults().valueForKey("showedAppRate") as? Bool
        if didShowAppRate != true {
            rateApp()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "showedAppRate")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // MARK: - Actions
    func openOurMenu() {
        openControllerWithIndentifier("ourMenuNavController")
    }
    
    func openReservation() {
        openControllerWithIndentifier("reservationNavController")
    }
    
    func openFindUs() {
        openControllerWithIndentifier("findUsNavController")
    }
    
    func openFeedback() {
        openControllerWithIndentifier("feedbackNavController")
    }
    
    // MARK: - Private Methods
    private func openControllerWithIndentifier(identifier: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewControllerWithIdentifier(identifier)
        let rootController = window?.rootViewController as! MSSlidingPanelController
        
        rootController.centerViewController = controller
        rootController.closePanel()
    }
    
    private func initAppiRater() {
        Appirater.appLaunched(true)
        Appirater.setAppId(ConfigurationManager.sharedManager.appId)
        Appirater.setOpenInAppStore(true)
    }
    
    private func initRateAppTimer() {
        let didShowAppRate = NSUserDefaults.standardUserDefaults().valueForKey("showedAppRate") as? Bool
        if didShowAppRate != true {
            let showRateDelay = NSTimeInterval(Double(ConfigurationManager.sharedManager.rateAppDelay)! * secondsInMinute)
            NSTimer.scheduledTimerWithTimeInterval(showRateDelay, target: self, selector: Selector("showAppRate"), userInfo: nil, repeats: false)
        }
    }
    
    private func rateApp() {
        let alertController = UIAlertController(title: "Rate the App", message: "Do you like this app?", preferredStyle: UIAlertControllerStyle.Alert)
        
        //Create action for "No"
        let noAction: UIAlertAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) { action -> Void in }
        alertController.addAction(noAction)
        
        //Create action for "Yes"
        let yesAction: UIAlertAction = UIAlertAction(title: "Yes", style: .Default) { action -> Void in
            Appirater.rateApp()
        }
        alertController.addAction(yesAction)
        
        window?.rootViewController!.presentViewController(alertController, animated: true, completion: nil)
    }
}

// MARK: - UIAlertViewDelegate
extension AppDelegate: UIAlertViewDelegate {
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        if alertView.title == "Rate the App" {
            switch buttonIndex {
            case RateApp.Declined.rawValue:
                break
            case RateApp.Confirmed.rawValue:
                Appirater.rateApp()
                break
            default:
                break
            }
        }
    }
}

