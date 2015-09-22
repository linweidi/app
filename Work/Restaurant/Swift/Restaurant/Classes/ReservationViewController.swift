//
//  ReservationViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

enum ReservationCell: Int {
    case Location = 0
    case NumberOfGuests
    case Phone
    case MakeReservation
    case Count
}

class ReservationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension ReservationViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ReservationCell.Count.rawValue
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ReservationCell.Location.rawValue:
            let cell: ReservationLocationTableViewCell = tableView.dequeueReusableCellWithIdentifier("reservationCell") as! ReservationLocationTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        case ReservationCell.NumberOfGuests.rawValue:
            let cell: NumberOfGuestsTableViewCell = tableView.dequeueReusableCellWithIdentifier("numberOfGuestsCell") as! NumberOfGuestsTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        case ReservationCell.Phone.rawValue:
            let cell: PhoneNumberTableViewCell = tableView.dequeueReusableCellWithIdentifier("phoneNumberCell") as! PhoneNumberTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        case ReservationCell.MakeReservation.rawValue:
            let cell: MakeReservationTableViewCell = tableView.dequeueReusableCellWithIdentifier("makeReservationCell") as! MakeReservationTableViewCell
            cell.backgroundColor = UIColor.clearColor()
            return cell
        default:
            return UITableViewCell() //return empty cell
        }
    }
}

// MARK: - UITableViewDelegate
extension ReservationViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == ReservationCell.MakeReservation.rawValue {
            let alert = UIAlertView(title: "Thank You", message: "You have booked table. Thanks for your reservation.", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
        }
    }
}
