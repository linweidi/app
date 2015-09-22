//
//  FeedbackTableViewCell.swift
//  Restaurant
//
//  Created by AppsFoundation on 8/27/15.
//  Copyright © 2015 AppsFoundation. All rights reserved.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var feedbackNameLabel: UILabel?
    @IBOutlet weak var feedbackTextLabel: UILabel?
    
    @IBOutlet weak var oneStarImgView: UIImageView?
    @IBOutlet weak var twoStarsImgView: UIImageView?
    @IBOutlet weak var threeStarImgView: UIImageView?
    @IBOutlet weak var fourStarsImgView: UIImageView?
    @IBOutlet weak var fiveStarImgView: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Public Methods
    func updateViewForRating(rating: Int) {
        let arrayOfImages: [UIImageView?] = [oneStarImgView, twoStarsImgView, threeStarImgView, fourStarsImgView, fiveStarImgView]
        
        for var i = 0; i < rating; i++ {
            let imgView = arrayOfImages[i]!
            imgView.hidden = false
        }
        
        for var i = rating; i < arrayOfImages.count; i++ {
            let imgView = arrayOfImages[i]!
            imgView.hidden = true
        }
    }
}
