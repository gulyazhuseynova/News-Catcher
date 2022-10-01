//
//  TableViewCell.swift
//  News
//
//  Created by Gulyaz Huseynova on 12.09.22.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var newsInDetailVC: Articles?

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var topicView: UIView!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        topicView.layer.cornerRadius = topicView.frame.height / 3
        
        newsImage.layer.cornerRadius = newsImage.frame.height / 5
        
        

        // Configure the view for the selected state
    }
    
}
