//
//  ProductViewCell.swift
//  gaspiTestDev
//
//  Created by Brian Baragar on 20/03/21.
//

import UIKit

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
