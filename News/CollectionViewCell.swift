//
//  CollectionViewCell.swift
//  News
//
//  Created by Gulyaz Huseynova on 12.09.22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var collectionBackView: UIView!
    @IBOutlet weak var titleBack: UIView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var topic: UILabel!
    @IBOutlet weak var topicBack: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topicBack.layer.cornerRadius = topicBack.frame.height / 3
        collectionBackView.layer.cornerRadius = collectionBackView.frame.height / 10
        titleBack.layer.cornerRadius = titleBack.frame.height / 3
    }

}
