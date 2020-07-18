//
//  TableViewCell.swift
//  ADLogger_v2
//
//  Created by 助川友理 on 2020/07/18.
//  Copyright © 2020 助川友理. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func cellnumber(cell: IndexPath){
      self.label.text = String((cell.row)+1)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
