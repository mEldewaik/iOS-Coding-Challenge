//
//  MediaTypeCell.swift
//  iOSChallenge
//
//  Created by Mohamed Eldewaik on 9/24/19.
//

import UIKit

class MediaTypeCell: UICollectionViewCell {

    fileprivate let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        lbl.textAlignment = .center
        return lbl
    }()
    
    
    var mediaTitle: String? {
        didSet{
            self.titleLbl.text = mediaTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLbl)
        
//        titleLbl.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        titleLbl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//        titleLbl.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        titleLbl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        
        let centerVertically = NSLayoutConstraint(item: titleLbl,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: self.contentView,
                                       attribute: .centerX,
                                      multiplier: 1.0,
                                        constant: 0.0)
        let centerHorizontally = NSLayoutConstraint(item: titleLbl,
                                       attribute: .centerY,
                                       relatedBy: .equal,
                                       toItem: self.contentView,
                                       attribute: .centerY,
                                      multiplier: 1.0,
                                        constant: 0.0)
        NSLayoutConstraint.activate([centerVertically, centerHorizontally])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
