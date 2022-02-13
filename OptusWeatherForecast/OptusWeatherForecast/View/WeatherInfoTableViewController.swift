//
//  WeatherInfoTableViewController.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 12/2/22.
//

import UIKit
import NVActivityIndicatorView

class WeatherInfoTableViewController: UITableViewController, AddCityDelegate {
    var activityIndicator : NVActivityIndicatorView?
    lazy var viewModel = {
        CityViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        //Add initial cities
        addInitialCityValues()
        
        initViewModel()
        
        //Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(initViewModel), userInfo: nil, repeats: true)
    }
    
    @objc func initViewModel() {
        showActivityIndicator()
        // Get city data
        viewModel.getCityInfo()
        
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.activityIndicator?.stopAnimating()
                
            }
        }
    }
    
    func showActivityIndicator() {
//        activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
//        activityIndicator?.center = view.center
//        activityIndicator?.hidesWhenStopped = true
//        activityIndicator?.startAnimating()
//        view.addSubview(activityIndicator!)
        
        let xAxis = self.view.center.x
        let yAxis = self.view.center.y
        let frame = CGRect(x: (xAxis - 20), y: (yAxis - 100), width: 55, height: 55)
        activityIndicator = NVActivityIndicatorView(frame: frame)
        activityIndicator?.type = .circleStrokeSpin
        activityIndicator?.color = .blue
        self.view.addSubview(activityIndicator!)
        activityIndicator?.startAnimating()
    }
    
    func addInitialCityValues() {
        var selectedCities : [Int:String] = [Int:String]()
        selectedCities[4163971] = "Sydney"
        selectedCities[2147714] = "Melbourne"
        selectedCities[2174003] = "Brisbane"
        UserDefaultsManager.setSelectedCities(for: selectedCities)
    }
    
    // MARK: - Add City Delegate
    func addCity(city: CitySearchCellViewModel) {
        var selectedCities = UserDefaultsManager.getSelectedCities()
        selectedCities?[city.id] = city.name
        UserDefaultsManager.setSelectedCities(for: selectedCities!)
        
        initViewModel()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cityCellViewModels.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CityTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.ENTRY_CELL, for: indexPath) as? CityTableViewCell)!
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCitySegue" {
            let destinationViewController = segue.destination as? AddCityViewController
            destinationViewController?.delegate = self
        }
    }
}
