//
//  FeedbackViewController.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/28/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

enum Rating: Int {
    case OneStar = 0
    case TwoStars
    case ThreeStars
    case FourStars
    case FiveStars
}

class FeedbackViewController: BaseViewController {
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var feedbacksTableView: UITableView?
    @IBOutlet weak var nameField: UITextField?
    @IBOutlet weak var feedbackField: UITextField?
    @IBOutlet weak var addFeedbackBtn: UIButton?
    
    @IBOutlet weak var bottomView: UIView?
    @IBOutlet weak var nameView: UIView?
    @IBOutlet weak var feedbackView: UIView?
    @IBOutlet weak var addBtnView: UIView?
    
    @IBOutlet weak var oneStarBtn: UIButton?
    @IBOutlet weak var twoStarsBtn: UIButton?
    @IBOutlet weak var threeStarsBtn: UIButton?
    @IBOutlet weak var fourStarsBtn: UIButton?
    @IBOutlet weak var fiveStarsBtn: UIButton?
    
    private var feedbacks: [Feedback] = []
    private var keyboardListener: KeyboardListener?
    private var currentFeedbackRating: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedbacks = [Feedback](FeedbacksManager.sharedManager.loadData())
        
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        bottomView?.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        keyboardListener = KeyboardListener(scrollView: feedbacksTableView!, constraint: bottomConstraint!)
        
        initBottomViewShadow()
        initTextFieldsUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Customize UI
    private func initBottomViewShadow() {
        bottomView?.layer.shadowOpacity = 1.0
        bottomView?.layer.shadowRadius = 1.0
        bottomView?.layer.shadowOffset = CGSizeMake(0, -1)
    }
    
    private func initTextFieldsUI() {
        let color = UIColor(red: 130.0/255.0, green: 123.0/255.0, blue: 120.0/255.0, alpha: 1.0)
        
        if let nameField = self.nameField, let namePlaceholder = nameField.placeholder {
            nameField.attributedPlaceholder = NSAttributedString(string: namePlaceholder, attributes: [NSForegroundColorAttributeName: color])
        }
        
        if let feedbackField = self.feedbackField, let feedbackPlaceholder = feedbackField.placeholder {
            feedbackField.attributedPlaceholder = NSAttributedString(string: feedbackPlaceholder, attributes: [NSForegroundColorAttributeName: color])
        }
    }
    
    // MARK: - Private Methods
    private func changeRatingFor(newRating: Int) {
        currentFeedbackRating = newRating
        
        let starImage = UIImage(named: "star_chosen")
        let greyStarImage = UIImage(named: "star_unchosen")
        
        let arrayOfButtons: [UIButton?] = [oneStarBtn, twoStarsBtn, threeStarsBtn, fourStarsBtn, fiveStarsBtn]
        
        for var i = 0; i < newRating; i++ {
            if let btn = arrayOfButtons[i]! as UIButton! {
                btn.setImage(starImage, forState: .Normal)
            }
        }
        
        for var i = newRating; i < arrayOfButtons.count; i++ {
            if let btn = arrayOfButtons[i]! as UIButton! {
                btn.setImage(greyStarImage, forState: .Normal)
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func sendFeedback(sender: AnyObject) {
        let newFeedback = Feedback()
        
        if let name = nameField?.text {
            newFeedback.name = name
        }
        
        if let text = feedbackField?.text {
            newFeedback.text = text
        }

        newFeedback.numberOfStars = currentFeedbackRating
        feedbacks.append(newFeedback)
        
        feedbacksTableView?.reloadData()
        
        nameField?.text = ""
        feedbackField?.text = ""
        nameField?.resignFirstResponder()
        feedbackField?.resignFirstResponder()
    }
    
    @IBAction func onOneStar(sender: AnyObject) {
        changeRatingFor(Rating.OneStar.rawValue)
    }
    
    @IBAction func onTwoStars(sender: AnyObject) {
        changeRatingFor(Rating.TwoStars.rawValue)
    }
    
    @IBAction func onThreeStars(sender: AnyObject) {
        changeRatingFor(Rating.ThreeStars.rawValue)
    }
    
    @IBAction func onFourStars(sender: AnyObject) {
        changeRatingFor(Rating.FourStars.rawValue)
    }
    
    @IBAction func onFiveStars(sender: AnyObject) {
        changeRatingFor(Rating.FiveStars.rawValue)
    }
}

// MARK: - UITableViewDataSource
extension FeedbackViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: FeedbackTableViewCell = tableView.dequeueReusableCellWithIdentifier("feedBackCell") as! FeedbackTableViewCell
        cell.backgroundColor = UIColor.clearColor()
        
        let feedback = feedbacks[indexPath.row]
        
        cell.feedbackNameLabel?.text = feedback.name
        cell.feedbackTextLabel?.text = feedback.text
        cell.updateViewForRating(feedback.numberOfStars)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FeedbackViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell: FeedbackTableViewCell = tableView.dequeueReusableCellWithIdentifier("feedBackCell") as! FeedbackTableViewCell
        
        let feedback = feedbacks[indexPath.row]
        
        cell.feedbackNameLabel?.text = feedback.name
        cell.feedbackTextLabel?.text = feedback.text
        
        let height = cell.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        return height
    }
}


