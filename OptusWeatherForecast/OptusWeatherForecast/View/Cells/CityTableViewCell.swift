//
//  CityTableViewCell.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    
    var cellViewModel: CityCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
            temperatureLabel.text = cellViewModel?.temperature
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

class CitySearchTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    
    var cellViewModel: CitySearchCellViewModel? {
        didSet {
            nameLabel.text = cellViewModel?.name
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
