//
//  FeedbacksManager.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class FeedbacksManager: NSObject {
    
    static let sharedManager = FeedbacksManager()
    
    private override init() {}
    
    // MARK: - Public Methods
    func loadData() -> [Feedback] {
        let path = NSBundle.mainBundle().pathForResource("Feedbacks", ofType: "plist")
        if let dataArray = NSArray(contentsOfFile: path!) {
            return constructFeedbackItemsFromArray(dataArray)
        } else {
            return [Feedback]()
        }
    }
    
    // MARK: - Private Methods
    private func constructFeedbackItemsFromArray(array: NSArray) -> [Feedback] {
        var resultItems = [Feedback]()
        
        for object in array {
            let name = object["name"] as! String
            let text = object["text"] as! String
            let numberOfStars = object["numberOfStars"] as! Int
            
            let loadedFeedback = Feedback(name: name, text: text, numberOfStars: numberOfStars)
            resultItems.append(loadedFeedback)
        }
        return resultItems
    }
}
