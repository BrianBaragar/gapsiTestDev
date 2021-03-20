//
//  Extensions.swift
//  gaspiTestDev
//
//  Created by Brian Baragar on 20/03/21.
//

import UIKit
//MARK:- Image
extension UIImageView{
    func imageFromServerURL(urlString: String, placeHolderImage: UIImage){
        if self.image == nil {
            self.image = placeHolderImage
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            if error != nil {
                return
            }
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200{
                DispatchQueue.main.async {
                    guard let data = data else{return}
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
            return
        }.resume()
    }
}
