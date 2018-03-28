//
//  ParkSceneTableViewCell.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/24.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class ParkSceneTableViewCell: UITableViewCell {

    @IBOutlet weak var parkSceneImageView: UIImageView!
    @IBOutlet weak var parkNameLabel: UILabel!
    @IBOutlet weak var parkSceneNameLabel: UILabel!
    @IBOutlet weak var parkSceneIntroLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.parkSceneImageView.layer.cornerRadius = 5
        self.parkSceneImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
