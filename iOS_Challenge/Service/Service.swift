//
//  Service.swift
//  iOSChallenge
//
//  Created by Mohamed Eldewaik on 9/24/19.
//

import Foundation
import Alamofire
import AlamofireActivityLogger

class Services {
    static let instance = Services()
    
    func getAppleMedia(view: UIView,forMediaType mediaType: String,numberOfResults number: String,_ completion: @escaping(AppleModel?)->()) {
        
        ProgressView.shared.showProgressView(view)
        
        let url = ServerAPIServant.get_Apple_media(mediaType: mediaType, number: number)
        
        Alamofire.request(url).log().responseJSON { (response) in
            switch response.result{
            case .failure( _):
                ProgressView.shared.hideProgressView()
                completion(nil)
            case .success(let value):
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let model = try JSONDecoder().decode(AppleModel.self, from: jsonData)
                    ProgressView.shared.hideProgressView()
                    completion(model)
                }catch let error {
                    ProgressView.shared.hideProgressView()
                    print(error.localizedDescription)
                    completion(nil)
                }
                
            }
        }
        
    }

}
