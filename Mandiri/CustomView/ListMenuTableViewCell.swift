//
//  ListMenuTableViewCell.swift
//  Mandiri
//
//  Created by Aritio modernland on 15/03/22.
//

import Foundation

class ListMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblTitle.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
