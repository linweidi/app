//
//  OurMenuViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class OurMenuViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    private var menuItems: [MenuItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuItems = MenuItemsManager.sharedManager.loadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension OurMenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: MenuItemTableViewCell = tableView.dequeueReusableCellWithIdentifier("menuItemCell") as! MenuItemTableViewCell
        let item = menuItems[indexPath.row]
        
        //display data from MenuItems.plist
        cell.menuItemNameLabel?.text = item.name
        cell.ingredientsItemLabel?.text = item.ingredients
        cell.priceItemLabel?.text = item.price
        cell.menuItemImageView?.image = UIImage(named: item.image)
        
        if let discount = item.discount {
            cell.discountLabel?.text = discount
            cell.discountView?.hidden = false
        } else {
            cell.discountView?.hidden = true
        }
        
        cell.backgroundColor = UIColor.clearColor()
        
        return cell
    }
}
