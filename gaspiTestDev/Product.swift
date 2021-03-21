//
//  Product.swift
//  gaspiTestDev
//{"id":"7GBJ0W2K0RVP","rating":4.29999999999999982236431605997495353221893310546875,"price":748,"image":"https:\/\/i5.walmartimages.com\/asr\/34892510-daac-48d6-b715-7e27988acbc8.d534e57907197211a2787c9372598e25.jpeg?odnHeight=200&odnWidth=200&odnBg=ffffff","title":"Sony
// 65\" Class KD65X750H 4K UHD LED Android Smart TV HDR BRAVIA 750H
//Series"},
//  Created by Brian Baragar on 20/03/21.
//

import Foundation
struct Product: Codable {
    var id: String
    var rating: Double
    var price: Double
    var image: String
    var title: String
    
    
    enum CodingKeys: String, CodingKey {
       case id
       case rating
       case price
       case image
       case title
    }
    
    func getURLStringImage() -> String{
        let newStringImageClean = image.components(separatedBy: "?")[0]
        return newStringImageClean
    }
}
