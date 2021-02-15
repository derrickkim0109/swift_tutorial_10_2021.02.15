//
//  TableViewCell.swift
//  Server Json File_03
//
//  Created by Derrick on 2021/02/15.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    // ----------
    // Properties
    // ----------
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
