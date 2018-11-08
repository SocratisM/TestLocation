//
//  Location.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public struct Location {
  public let place: String
  public let longitude: String?
  public let latitude: String?
	
	public init(place: String, longitude: String? = nil, latitude: String? = nil) {
		self.place = place
		self.longitude = longitude
		self.latitude = latitude
	}
}

public struct LocationURL {
    public static let scheme = "wikipedia"
    public static let host = "places"
    public static let longitude = "longitude"
    public static let latitude = "latitude"
    public static let place = "place"
}
