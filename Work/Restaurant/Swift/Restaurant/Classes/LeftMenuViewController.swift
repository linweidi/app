//
//  LeftMenuViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

enum MenuItemType: Int {
    case OurItem = 0
    case Reservation
    case FindUs
    case Feedback
}

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var menuTableView: UITableView?
    
    private var menuItems: [String] = []
    private var menuItemsImages: [String] = []
    private var selectedMenuItemIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        menuItems = ["OUR MENU","RESERVATION","FIND US","FEEDBACK"]
        menuItemsImages = ["our_menu","reservation","find_us","feedback"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension LeftMenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MenuTableViewCell = tableView.dequeueReusableCellWithIdentifier("menuCell") as! MenuTableViewCell
        
        cell.selectedMenuImageView?.hidden = selectedMenuItemIndex != indexPath.row
        cell.itemNameLabel?.text = menuItems[indexPath.row]
        cell.itemImageView?.image = UIImage(named: menuItemsImages[indexPath.row])
        
        cell.backgroundColor = UIColor.clearColor()
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LeftMenuViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selectedMenuItemIndex = indexPath.row
        
        switch selectedMenuItemIndex {
        case MenuItemType.OurItem.rawValue:
            AppDelegate.sharedDelegate().openOurMenu()
            break
        case MenuItemType.Reservation.rawValue:
            AppDelegate.sharedDelegate().openReservation()
            break
        case MenuItemType.FindUs.rawValue:
            AppDelegate.sharedDelegate().openFindUs()
            break
        case MenuItemType.Feedback.rawValue:
            AppDelegate.sharedDelegate().openFeedback()
            break
        default:
            break
        }
        
        menuTableView?.reloadData()
    }
}
