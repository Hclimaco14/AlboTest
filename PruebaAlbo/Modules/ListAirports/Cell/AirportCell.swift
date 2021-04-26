//
//  AirportCell.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 26/04/21.
//

import UIKit
import CoreLocation

class AirportCell: UITableViewCell {

    public static let identifier = "AirportCell"
    
    //MARK: Outlets
    @IBOutlet weak var airportNameLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    //MARK: Variables
    var airport:Airport = Airport(){
        didSet {
            configuracionCell()
        }
    }
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configuracionCell() {
        DispatchQueue.main.async {
            self.airportNameLbl.text = self.airport.name
            
            var distance = self.airport.getLocation().distance(from: CLLocation(latitude: self.location.latitude, longitude: self.location.longitude))
            distance = distance / 1000
            let km = String(format: "%.02f km", distance)
            self.descriptionLbl.text = "City: \(self.airport.municipalityName ?? ""), distance: \(km)"
            
        }
    }
    
}
