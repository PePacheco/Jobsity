//
//  ShowsListTableViewCell.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit
import Kingfisher

class ShowsListTableViewCell: UITableViewCell {

    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var serieNameLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serieImageView.image = nil
        serieNameLabel.text = nil
    }
    
    func configure(name: String, imageURL: URL?) {
        serieImageView.kf.setImage(with: imageURL)
        serieNameLabel.text = name
    }

}
