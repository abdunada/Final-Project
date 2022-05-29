//
//  CommentTVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 21/04/2022.
//

import UIKit

class CommentTVCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var userImageViewOutlet: UIImageView!
    @IBOutlet weak var usernameLabelOutlet: UILabel!
    @IBOutlet weak var commentLabelOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
       
        super.setSelected(selected, animated: animated)
    }

}
