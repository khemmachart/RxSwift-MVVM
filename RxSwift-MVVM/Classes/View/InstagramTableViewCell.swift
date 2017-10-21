//
//  InstagramTableViewCell.swift
//  RxSwift-MVVM
//
//  Created by Khemmachart Chutapetch on 10/11/2560 BE.
//  Copyright © 2560 Khemmachart Chutapetch. All rights reserved.
//

import UIKit
import SDWebImage

class InstagramTableViewCell: UITableViewCell {
    @IBOutlet private weak var coverImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    func setContent(_ content: InstagramMediaItemModel) {
        nameLabel.text = content.user?.username ?? ""
        if let urlString = content.images?.lowResolution?.url,
            let url = URL(string: urlString) {
            coverImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
