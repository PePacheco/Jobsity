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
    @IBOutlet weak var genresLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serieImageView.image = nil
        serieNameLabel.text = nil
        genresLabel.text = nil
    }
    
    func configure(name: String, genres: String, imageURL: URL?) {
        serieImageView.kf.setImage(with: imageURL)
        serieNameLabel.text = name
        genresLabel.text = genres
    }

}
