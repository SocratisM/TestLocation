//
//  LocationsListController.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Core

final class LocationsListController: UIViewController, LocationsListView {
	
	//MARK: - Controller handlers
  var onLocationSelect: ((Location) -> ())?
  var onAddLocation: (() -> Void)?
  var onNewLocationAdded: ((Location) -> ())?
  
  @IBAction func addItemButtonClicked(_ sender: UIBarButtonItem) { onAddLocation?() }
  
  @IBOutlet weak var tableView: UITableView!
	
	//mock locations datasource
  var locations = [
		Location(place: "New York", longitude: "-74.0059413", latitude: "40.7127837"),
		Location(place: "Los Angeles", longitude: "-118.2436849", latitude: "34.0522342"),
		Location(place: "Tokyo", longitude: "139.7514", latitude: "35.6850"),
		Location(place: "São Paulo", longitude: "-46.6250", latitude: "-23.5587"),
    Location(place: "Rijksmuseum"),
    Location(place: "Anne Frank House"),
    Location(place: "Berlin Wall"),
    Location(place: "White House"),
    Location(place: "Nasa Headquarters"),
    Location(place: "Apple Headquarters")
    ]
	
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Select a location"
		tableView.tableFooterView = UIView()
		navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(LocationsListController.addItemButtonClicked(_:))
    )
  }
  
  func onNewLocationAdded(location: Location) {
    locations.append(location)
    tableView.reloadData()
  }
}

extension LocationsListController: UITableViewDelegate, UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return locations.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    let location = locations[(indexPath as NSIndexPath).row]
    cell.textLabel?.text = location.place
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    onLocationSelect?(locations[(indexPath as NSIndexPath).row])
    tableView.deselectRow(at: indexPath, animated: true)
  }
}
