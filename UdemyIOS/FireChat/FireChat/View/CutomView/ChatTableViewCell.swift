//
//  ChatTableViewCell.swift
//  FireChat
//
//  Created by gayan perera on 11/28/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    
    @IBOutlet weak var senderName: UILabel!
    @IBOutlet weak var senderMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
