//
//  ListAirportsView.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 24/04/21.
//

import UIKit
import CoreLocation

class ListAirportsView: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var airportTableView: UITableView!
    
    // MARK: Properties
    var presenter: ListAirportsPresenterProtocol?

    //MARK: Properties
    var airports:[Airport] = []
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D()
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func configureView() {
        airportTableView.register(UINib(nibName: AirportCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: AirportCell.identifier)
        airportTableView.dataSource = self
    }
}

extension ListAirportsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AirportCell.identifier, for: indexPath) as! AirportCell
        cell.airport = airports[indexPath.row]
        cell.location = location
        return cell
        
    }
    
    
}

extension ListAirportsView: ListAirportsViewProtocol {
    // TODO: implement view output methods
}

