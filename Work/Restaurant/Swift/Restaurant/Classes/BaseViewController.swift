//
//  BaseViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu_button")!.imageWithRenderingMode(.AlwaysOriginal), style: .Plain, target: self, action: Selector("onMenu:"))
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "background"), forBarMetrics: .Default)
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.layer.shadowOpacity = 1.0
        navigationController?.navigationBar.layer.shadowRadius = 1.0
        navigationController?.navigationBar.layer.shadowOffset = CGSizeMake(1, 1)
        
        automaticallyAdjustsScrollViewInsets = false
    }
    
    // MARK: - Actions
    @IBAction func onMenu(sender: AnyObject) {
        if slidingPanelController.sideDisplayed == MSSPSideDisplayed.Left {
            slidingPanelController.closePanel()
        } else {
            slidingPanelController.openLeftPanel()
        }
    }
}
