//
//  KeyboardListener.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class KeyboardListener: NSObject {
    
    var scrollView: UIScrollView
    var constraint: NSLayoutConstraint
    
    private var constraintConstant: CGFloat
    
    init(scrollView: UIScrollView, constraint: NSLayoutConstraint) {
        self.scrollView = scrollView
        self.constraint = constraint
        constraintConstant = self.constraint.constant
        
        super.init()
        
        //keyboard notifications to change tableview frame
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillChangeFrameNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: - Keyboard notifications
    func keyboardWillShow(notification: NSNotification) {
        if let info = notification.userInfo, let kbFrame: NSValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue, let animationDuration: NSTimeInterval = info[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
            
            let keyboardFrame = kbFrame.CGRectValue()
            constraint.constant = keyboardFrame.size.height
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                if let superview = self.scrollView.superview {
                    superview.layoutIfNeeded()
                }
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let info = notification.userInfo, let animationDuration: NSTimeInterval = info[UIKeyboardAnimationDurationUserInfoKey] as? NSTimeInterval {
            constraint.constant = constraintConstant
            
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                if let superview = self.scrollView.superview {
                    superview.layoutIfNeeded()
                }
            })
        }
    }
}





