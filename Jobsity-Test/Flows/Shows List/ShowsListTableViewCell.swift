//
//  ShowsListTableViewCell.swift
//  Jobsity-Test
//
//  Created by Pedro Gomes Rubbo Pacheco on 25/01/22.
//

import UIKit
import Kingfisher

protocol ShowsListTableViewCellDelegate: AnyObject {
    func showsListTableViewCell(detail cell: UITableViewCell)
    func showsListTableViewCell(favorite cell: UITableViewCell)
}

class ShowsListTableViewCell: UITableViewCell {

    @IBOutlet weak var serieImageView: UIImageView!
    @IBOutlet weak var serieNameLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    weak var delegate: ShowsListTableViewCellDelegate?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        serieImageView.image = nil
        serieNameLabel.text = nil
        genresLabel.text = nil
    }
    
    func configure(name: String, genres: String, imageURL: URL?, isFavorite: Bool) {
        serieImageView.kf.setImage(with: imageURL)
        serieNameLabel.text = name
        genresLabel.text = genres
        if isFavorite {
            heartButton.tintColor = .red
            heartButton.imageView?.image = UIImage(systemName: "heart.fill")
        } else {
            heartButton.tintColor = .label
            heartButton.imageView?.image = UIImage(systemName: "heart")
        }
    }
    
    @IBAction func didTapDetails(_ sender: Any) {
        self.delegate?.showsListTableViewCell(detail: self)
    }
    
    @IBAction func didTapFavorite(_ sender: Any) {
        heartButton.imageView?.image = UIImage(systemName: "heart.fill")
        heartButton.imageView?.tintColor = .red
        self.delegate?.showsListTableViewCell(favorite: self)
    }
    
}
