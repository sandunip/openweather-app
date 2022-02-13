//
//  AddCityViewController.swift
//  OptusWeatherForecast
//
//  Created by Sanduni Perera on 13/2/22.
//

import UIKit

protocol AddCityDelegate {
    func addCity(city:CitySearchCellViewModel)
}

class AddCityViewController: UIViewController {
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var citySearchbar: UISearchBar!
    
    var delegate : AddCityDelegate?

    lazy var viewModel = {
        CitySearchViewModel()
    }()
    
    var initialCityValues: [CitySearchCellViewModel]?

    override func viewDidLoad() {
        super.viewDidLoad()
        initViewModel()
        initialCityValues = viewModel.citySearchCellViewModels
    }
    
    func initViewModel() {
        // Get city results
        viewModel.getCityInfo()
        
        reloadTableView()
    }
    
    func reloadTableView() {
        // Reload TableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.citiesTableView.reloadData()
            }
        }
    }
}

extension AddCityViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.citySearchCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : CitySearchTableViewCell = (tableView.dequeueReusableCell(withIdentifier: UIConstants.Cell.ENTRY_CELL, for: indexPath) as? CitySearchTableViewCell)!
        let cellVM = viewModel.citySearchCellViewModels[indexPath.row]
        cell.cellViewModel = cellVM
        return cell
    }
}

extension AddCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = viewModel.citySearchCellViewModels[indexPath.row]
        self.dismiss(animated: true, completion: {
            self.delegate?.addCity(city: selectedCity)
        })
    }
}

extension AddCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            viewModel.citySearchCellViewModels = (initialCityValues?.filter{$0.name.contains(searchText)})!
        }
        else {
            viewModel.citySearchCellViewModels = initialCityValues!
        }
        reloadTableView()
    }
}


