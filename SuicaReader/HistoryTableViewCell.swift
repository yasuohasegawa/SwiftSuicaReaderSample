//
//  HistoryTableViewCell.swift
//  SuicaReader
//
//  Created by Yasuo Hasegawa on 2020/05/15.
//  Copyright © 2020 Yasuo Hasegawa. All rights reserved.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var tf: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
