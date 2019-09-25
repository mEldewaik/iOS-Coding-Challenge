//
//  Service.swift
//  iOSChallenge
//
//  Created by Mohamed Eldewaik on 9/24/19.
//

import UIKit

class ServerAPIServant {

    func domainUrl() -> String{
        return "https://rss.itunes.apple.com/api/v1/us/"
    }

    class func get_Apple_media(mediaType: String, number: String)->String{
        let serviceURI = "\(ServerAPIServant().domainUrl())\(mediaType)/all/10/explicit.json"
        return serviceURI
    }
}

