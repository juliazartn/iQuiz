//
//  SubjectTableViewCell.swift
//  iQuiz
//
//  Created by Julia Zaratan on 2/8/18.
//  Copyright © 2018 Julia Zaratan. All rights reserved.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

    @IBOutlet weak var subjectImageView: UIImageView!
    @IBOutlet weak var subjectTitle: UILabel!
    @IBOutlet weak var subjectDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
