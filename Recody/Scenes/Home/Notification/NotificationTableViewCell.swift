//
//  NtoficationTableViewCell.swift
//  Recody
//
//  Created by 마경미 on 21.03.23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(data: Notification) {
        message.text = data.message
        time.text = data.time
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
