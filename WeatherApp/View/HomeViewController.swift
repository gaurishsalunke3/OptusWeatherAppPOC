//
//  HomeViewController.swift
//  WeatherApp
//
//  Created by Gaurish Salunke on 6/17/20.
//  Copyright © 2020 Gaurish Salunke. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var cityTableView: UITableView!
    
    var weatherVM = WeatherViewModel()
    var cities = [Weather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The Weather App"
        
        self.loadData()
    }
    
    private func loadData() {
        self.weatherVM.getCurrentWeatherForMultipleCities { [weak self] result in
            switch result {
            case .success(let cities):
                self?.cities = cities
                self?.cityTableView.reloadData()
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc func addNewCityButtonTapped(_ sender: UIButton){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let addCityViewController =  storyboard.instantiateViewController(withIdentifier: "AddCityViewController") as! AddCityViewController
        // check if new city is selected in the modal view, if yes then reload the data and tableview.
        addCityViewController.searchCompletion = { flag in
            if (flag) {
                self.loadData()
            }
        }
        self.present(addCityViewController, animated:true, completion:nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.cities.count {
            return 50.0
        }
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.cities.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCityCell") as! AddCityView
            cell.addNewCityButton.addTarget(self, action: #selector(addNewCityButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as! CityCellView
        
        let cityWeather = self.cities[indexPath.row]
        cell.setData(cityWeather)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.cities.remove(at: indexPath.row)
            self.cityTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherDetailViewController =  storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        weatherDetailViewController.cityWeather = self.cities[indexPath.row]
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
}

