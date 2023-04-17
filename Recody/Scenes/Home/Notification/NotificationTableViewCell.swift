//
//  NtoficationTableViewCell.swift
//  Recody
//
//  Created by 마경미 on 21.03.23.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    let message: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#222222")
        label.font = UIFont(name: "AppleSDGothicNeo-Medium", size: 14)
        return label
    }()
    
    let time: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(hexString: "#999999")
        label.font = UIFont(name: "AppleSDGothicNeo-Light", size: 10)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        setInit()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setInit() {
        addSubview(message)
        addSubview(time)
    }

    func setData(data: Notification) {
        
        message.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        message.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        message.topAnchor.constraint(equalTo: self.topAnchor, constant: 17.5).isActive = true
        message.heightAnchor.constraint(equalToConstant: 17).isActive = true
        
        time.topAnchor.constraint(equalTo: message.bottomAnchor, constant: 4).isActive = true
        time.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        time.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        time.heightAnchor.constraint(equalToConstant: 12).isActive = true
    
        message.text = data.message
        time.text = data.time
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
