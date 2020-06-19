//
//  AddCityView.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

protocol TableViewUpdateDelegate: class {
    func updateTableView()
}

class FooterCellView: UITableViewCell {

    @IBOutlet var celsiusButton: UIButton!
    @IBOutlet var fahrenheitButton: UIButton!
    @IBOutlet var addNewCityButton: UIButton!
    
    weak var delegate: TableViewUpdateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func celsiusButtonTapped(_ sender: UIButton) {
        celsiusButton.isSelected = true
        fahrenheitButton.isSelected = false

        self.setDegreeMeasurement(true)
    }

    @IBAction func fahrenheitButtonTapped(_ sender: UIButton) {
        celsiusButton.isSelected = false
        fahrenheitButton.isSelected = true

        self.setDegreeMeasurement(false)
    }
    
    func setDegreeMeasurement(_ flag: Bool) {
        let defaults = UserDefaults.standard
        defaults.set(flag, forKey: Constants.kIsCelsius)
        
        delegate?.updateTableView()
    }
}
