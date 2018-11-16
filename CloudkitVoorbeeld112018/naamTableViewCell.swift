//
//  naamTableViewCell.swift
//  CloudkitVoorbeeld112018
//
//  Created by Toine Schnabel on 13/11/2018.
//  Copyright © 2018 Toine Schnabel. All rights reserved.
//

import UIKit

class naamTableViewCell: UITableViewCell {
    @IBOutlet var voornaam: UITextField!
    @IBOutlet var achternaam: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
