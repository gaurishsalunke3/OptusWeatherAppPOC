//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class FooterCellView: UITableViewCell {

    @IBOutlet var celsiusButton: UIButton!
    @IBOutlet var farenheitButton: UIButton!
    @IBOutlet var addNewCityButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
