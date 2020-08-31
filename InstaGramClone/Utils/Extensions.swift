//
//  Extensions.swift
//  InstaGramClone
//
//  Created by MANINDER SINGH on 11/08/20.
//  Copyright © 2020 MANINDER SINGH. All rights reserved.
//

import UIKit
extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let right = right {
            self.rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
var imageCache = [String:UIImage]()
extension UIImageView{
    func loadImage(with urlString:String){
        if let cacheImage = imageCache[urlString]{
            self.image = cacheImage
            return
        }
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print("failed to laod Image \(String(describing: error?.localizedDescription))")
            }
            guard let imageData  = data else{return}
            let photoImage = UIImage(data: imageData)
            imageCache[url.absoluteString]=photoImage
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
