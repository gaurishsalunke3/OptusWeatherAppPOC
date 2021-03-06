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
    var activityIndicator: UIActivityIndicatorView!
    
    var timer = Timer()
    var weatherVM = WeatherViewModel()
    var savedCities = [Weather]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "The Weather App"
        
        // setting font color and size for the title
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium)]
                
        self.cityTableView.accessibilityIdentifier = "table-cityTableView"

        self.configureActivityIndicatorView()
        self.scheduleTimerToLoadWeatherData()
        self.loadData()
    }
    
    // configure the activity indicator in place of the right bar button inside the navigation bar.
    func configureActivityIndicatorView() {
        activityIndicator = UIActivityIndicatorView.init(style: .medium)
        activityIndicator.color = .black

        let barButton = UIBarButtonItem.init(customView: activityIndicator)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    // Timer to fetc the Weather data after periodic time interval. Currently set to 10 secs
    private func scheduleTimerToLoadWeatherData() {
        timer = Timer.scheduledTimer(timeInterval: Constants.kTimer, target: self, selector: #selector(self.updateWeatherInfo), userInfo: nil, repeats: true)
    }
    
    // This methods updates the wheather info after periodic time interval.
    @objc func updateWeatherInfo(){
        self.loadData()
    }

    // loads the weather data for all the saved cities from api.
    private func loadData() {
        self.activityIndicator.startAnimating()
        
        self.weatherVM.getCurrentWeatherForMultipleCities { [weak self] result in
            switch result {
            case .success(let cities):
                self?.savedCities = cities
                self?.cityTableView.reloadData()
                self?.activityIndicator.stopAnimating()

            case .failure(let error):
                print(error.localizedDescription)
                self?.activityIndicator.stopAnimating()
            }
        }
    }
    
    // Presents the search city view in a modal view
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

// MARK: UITableView Delegate Methods

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.savedCities.count {
            return 50.0
        }
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.savedCities.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.savedCities.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FooterCell") as! FooterCellView
            cell.delegate = self
            cell.accessibilityIdentifier = "FooterCell_0"
            
            cell.addNewCityButton.addTarget(self, action: #selector(addNewCityButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityWeatherCell") as! CityWeatherCellView
        cell.accessibilityIdentifier = "CityWeatherCell_\(indexPath.row)"

        let cityWeather = self.savedCities[indexPath.row]
        cell.setData(cityWeather, index: indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.savedCities.remove(at: indexPath.row)
            self.cityTableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherDetailViewController =  storyboard.instantiateViewController(withIdentifier: "WeatherDetailViewController") as! WeatherDetailViewController
        weatherDetailViewController.cityWeather = self.savedCities[indexPath.row]
        self.navigationController?.pushViewController(weatherDetailViewController, animated: true)
    }
}

// MARK: TableView Update Delegate Method

extension HomeViewController: TableViewUpdateDelegate {
    
    // Updates the tableview once degree measurement is updated (celsius/farenheit)
    func updateTableView() {
        cityTableView.reloadData()
    }
}

