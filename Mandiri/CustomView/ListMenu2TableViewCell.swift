//
//  ListMenu2TableViewCell.swift
//  Mandiri
//
//  Created by Aritio modernland on 15/03/22.
//


import UIKit

class ListMenu2TableViewCell: UITableViewCell {

    @IBOutlet weak var vStatus: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblNomor: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vStatus.layer.cornerRadius = 6
        lblTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblTitle.numberOfLines = 0
        lblSubTitle.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblSubTitle.numberOfLines = 0
        lblStatus.lineBreakMode = NSLineBreakMode.byWordWrapping
        lblStatus.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

