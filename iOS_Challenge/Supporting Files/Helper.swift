//
//  Helper.swift
//  iOSChallenge
//
//  Created by Mohamed Eldewaik on 9/24/19.
//

import Foundation
import Kingfisher

class Helper {
    
    class func configureImage(_ imageString: String,_ image: UIImageView,_ placeholder: String) {
        let imageView = image
        let url = URL(string: imageString)
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: url,
            placeholder: nil,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ],
            progressBlock: nil) { (img, error, cash, url) in
                
        }
    }
}
