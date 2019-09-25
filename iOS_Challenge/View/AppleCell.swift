//
//  AppleCell.swift
//  iOSChallenge
//
//  Created by Mohamed Eldewaik on 9/24/19.
//

import UIKit

class AppleCell: UITableViewCell {

    lazy var itunesImg: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 10, y: 6, width: 100, height: 100))
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var itunesName: UILabel = {
        let view = UILabel(frame: CGRect(x: 115, y: (self.contentView.frame.height / 2) + 15, width: self.contentView.frame.width - 80, height: self.contentView.frame.height))
        view.textColor = .black
        view.numberOfLines = 0
        view.backgroundColor = .clear
        return view
    }()
    
    
    func configureCellData(_ result: Result) {
        self.itunesName.text = result.name
        Helper.configureImage(result.artworkUrl100 ?? "", self.itunesImg, "")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.itunesImg.layer.cornerRadius = 5
        self.itunesImg.clipsToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(itunesImg)
        addSubview(itunesName)
    }

}
