//
//  SearchRadiusView.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//

import UIKit

class SearchRadiusView: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var radiusLbl: UILabel!
    
    @IBOutlet weak var radiusSlider: UISlider!
    @IBOutlet weak var descriptionSlider: UILabel!
    
    
    @IBOutlet weak var searchBtn: UIButton!
    
    
    // MARK: Properties
    var presenter: SearchRadiusPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        DeviceLocation.Share.changeAuthorization = {
            _ = DeviceLocation.validateLocationPermissions(viewController: self)
        }
        DeviceLocation.Share.configure()
    }
    
    func configureView() {
        titleLbl.text = "TITLE_SEARCH".localized()
        titleLbl.font = UIFont.boldSystemFont(ofSize: 32.0)
        
        radiusLbl.text = "1"
        radiusLbl.font = UIFont.boldSystemFont(ofSize: 24.0)
        descriptionSlider.text = "DESCRIPTION_SEARCH".localized()
        searchBtn.setTitle("BUTTON_SEARCH".localized(), for: .normal)
        searchBtn.backgroundColor = .systemBlue
        searchBtn.layer.cornerRadius = 5
        searchBtn.setTitleColor(.white, for: .normal)
    }
    
    @IBAction func radiusChanged(_ sender: Any) {
        if let slider = sender as? UISlider {
            radiusLbl.text = "\(Int(slider.value)) KM"
        }
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        if DeviceLocation.validateLocationPermissions() {
            DeviceLocation.getLocation() { loc in
            let radius = Int(radiusSlider.value)
            presenter?.serchAirport(distance: radius, location: loc)
            }
        } else {
            DeviceLocation.validateLocationPermissions(viewController: self)
        }
    }
    
}

extension SearchRadiusView: SearchRadiusViewProtocol {
    // TODO: implement view output methods
}

