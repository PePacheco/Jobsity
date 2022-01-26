//
//  ShowDetailsTableViewCell.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 26/01/22.
//

import UIKit

class ShowDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        episodeNameLabel.text = nil
        episodeCountLabel.text = nil
    }
    
    func configure(name: String, episodeCount: String) {
        episodeNameLabel.text = name
        episodeCountLabel.text = episodeCount
    }

}
