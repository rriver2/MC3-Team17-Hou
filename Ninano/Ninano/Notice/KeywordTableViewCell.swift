//
//  KeywordTableViewCell.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/15.
//

import UIKit

class KeywordTableViewCell: UITableViewCell {

    @IBOutlet private weak var keywordDate: UILabel!
    @IBOutlet private weak var keywordAlarmTitle: UILabel!
    @IBOutlet private weak var keywordTitle: UILabel!
    @IBOutlet private weak var keywordImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
