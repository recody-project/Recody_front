//
//  MySearchTableViewCell.swift
//  Recody
//
//  Created by 마경미 on 12.10.22.
//

import UIKit

protocol TableViewCellDelegate {
    func deleteButton(indexPathRow: Int)
}

class MySearchTableViewCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var delegate: TableViewCellDelegate?
    var indexPath = -1

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func setData(data: String, indexPathRow: Int) {
        contentLabel.text = data
        indexPath = indexPathRow
    }

    @IBAction func removeSearch(_ sender: UIButton) {
        delegate?.deleteButton(indexPathRow: indexPath)
    }
}
