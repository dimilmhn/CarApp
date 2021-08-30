//
//  CarsTableViewCell.swift
//  Cars
//
//  Created by Dimil T Mohan on 2021/08/14.
//

import UIKit
import SDWebImage

class CarsTableViewCell: UITableViewCell {

    static let identifier = "CarsTableViewCell"

    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var decsriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        itemImage.addGradient(for: itemImage.bounds.size.height - 52, height: 52)
    }
    
    func populate(viewModel: CarsCellViewModel) {
        if let imageUrl = viewModel.url, let url = URL(string: imageUrl) {
            itemImage.sd_setImage(with: url)
        }
        self.titleLabel.text = viewModel.title
        self.dateTimeLabel.text = viewModel.dateTime?.format()
        self.decsriptionLabel.text = viewModel.description
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
