//
//  TableViewCell.swift
//  Server Json File_02
//
//  Created by Derrick on 2021/02/15.
//

import UIKit

class TableViewCell: UITableViewCell {

    
    // ----------
    // Properties
    // ----------
    @IBOutlet weak var lblCode: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDept: UILabel!
    @IBOutlet weak var lblPhone: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
