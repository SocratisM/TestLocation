//
//  Location.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public struct Location {
	public let city: String?
  public let longitude: String
  public let latitude: String
	
	public init(city: String, longitude: String, latitude: String) {
		self.city = city
		self.longitude = longitude
		self.latitude = latitude
	}
}
