//
//  UIImageView+URLImage.swift
//  TelstraPOC
//
//  Created by Rohit on 5/6/20.
//  Copyright © 2020 Rohit. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func loadImageFromURL(_ URLString: String, placeHolder: UIImage?) {
        
        if URLString .isEmpty{
            self.image = placeHolder
            return
        }
        
        let imageCache = NSCache<NSString, UIImage>()
        
        self.image = #imageLiteral(resourceName: "NoImage")
        let imageUrl = URLString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        //check if image is presnt in cache or not
        if let cachedImage = imageCache.object(forKey: NSString(string: imageUrl)) {
            self.image = cachedImage
            return
        }
        
        //download imaghe from provided URL
        if let urlImage = URL(string: imageUrl) {
            URLSession.shared.dataTask(with: urlImage, completionHandler: { (data, response, error) in
                
                if error != nil {
                    DispatchQueue.main.async {
                        self.image = placeHolder
                    }
                    return
                }
                DispatchQueue.main.async {
                    if let data = data {
                        if let downloadedImage = UIImage(data: data) {
                            imageCache.setObject(downloadedImage, forKey: NSString(string: imageUrl))
                            self.image = downloadedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
