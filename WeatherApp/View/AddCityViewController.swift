//
//  AddCityViewController.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class AddCityViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var cityTableView: UITableView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var addCityVM = AddCityViewModel()
    var cities = [City]()
    var filteredCities = [City]()

    typealias completion = (Bool) -> Void
    var searchCompletion: completion!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.cityTableView.accessibilityIdentifier = "table-addCityTableView"
        self.loadData()
    }
    
    // loads the city data from local json file.
    private func loadData() {
        self.activityIndicator.startAnimating()

        self.addCityVM.getCitiesFromJSON{ [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                self?.filteredCities = cities
                self?.cityTableView.reloadData()
                self?.activityIndicator.stopAnimating()

            case .failure(let error):
                print(error.localizedDescription)
                self?.activityIndicator.stopAnimating()
            }
        }
    }

    // search city based on the real time text entered in the searc box.
    func searchCity(searchText: String) {
        self.activityIndicator.startAnimating()

        if searchText.isEmpty {
            self.filteredCities = self.cities
        } else {
            self.filteredCities = self.cities.filter {
                $0.name.range(of: searchText, options: [.caseInsensitive, .anchored]) != nil
            }
        }
        
        self.cityTableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    // dismisses the modal view
    @IBAction func cancelButtonTapped(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddCityViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewCityCell", for: indexPath)
        cell.accessibilityIdentifier = "NewCityCell_\(indexPath.row)"

        let city = self.filteredCities[indexPath.row]
        cell.textLabel?.text = city.place
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let defaults = UserDefaults.standard
        var citiesArray = defaults.object(forKey: Constants.kSavedCityIdArray) as! [Int]
        let selectedCity = self.filteredCities[indexPath.row]
        if !checkArrayHasValue(array: citiesArray, value: selectedCity.id) {
            citiesArray.append(selectedCity.id)
            defaults.set(citiesArray, forKey: Constants.kSavedCityIdArray)
            
            self.searchCompletion(true)
        } else {
            self.searchCompletion(false)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    // checks if the array contains a given value
    func checkArrayHasValue(array: [Int], value: Int) -> Bool {
        if array.contains(where: { $0 == value }) {
            return true
        }
        
        return false
    }
}

extension AddCityViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        self.searchCity(searchText: textField.text!)
    }
}


