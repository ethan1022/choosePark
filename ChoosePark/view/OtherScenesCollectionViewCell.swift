//
//  OtherScenesCollectionViewCell.swift
//  ChoosePark
//
//  Created by Ethan on 2018/3/25.
//  Copyright © 2018年 EthanLab. All rights reserved.
//

import UIKit

class OtherScenesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var parkSceneImageView: UIImageView!
    @IBOutlet weak var parkSceneNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.parkSceneImageView.layer.cornerRadius = 5
        self.parkSceneImageView.clipsToBounds = true
    }
    
}
