//
//  LocationValidatorConcrete.swift
//  Core
//
//  Created by Socratis Michaelides on 08/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Foundation

public enum LocationError: String {
  case placeCharactersTooShort = "Place should be at least 3 characters long"
  case placeIsNumber = "Place should not be a number"
  case placeIsEmpty = "Place should not be empty"
  case longitudeWrong = "Longitude should be a coordinate"
  case latitudeWrong = "Latitude should be a coordinate"
}

public enum LocationInputType {
  case place(String)
  case longitude(String)
  case latitude(String)
}

public protocol LocationValidatorType {
  func validate(input: LocationInputType) -> Bool
  func error(input: LocationInputType) -> LocationError?
  init()
}

public class LocationValidatorConcrete: LocationValidatorType {
  
  required public init() { }
  
  public func validate(input: LocationInputType) -> Bool {
    return error(input: input) == nil
  }
  
  public func error(input: LocationInputType) -> LocationError? {
    switch input {
    case .place(let placeValue):
      // Basic place validation
      guard placeValue.isEmpty else {
        guard !placeValue.isNumber else {
          return LocationError.placeIsNumber
        }
        return placeValue.count >= 3 ? nil : LocationError.placeCharactersTooShort
      }
      return placeValue.isEmpty ? LocationError.placeIsEmpty : nil
    case .longitude(let longitudeValue):
      // Proper longitude validations later - This is a test
      if !longitudeValue.isEmpty {
        guard longitudeValue.isCoordinate else {
          return LocationError.longitudeWrong
        }
      }
    case .latitude(let latitudeValue):
      // Proper latitude validations later - This is a test
      if !latitudeValue.isEmpty {
        guard latitudeValue.isCoordinate else {
          return LocationError.latitudeWrong
        }
      }
    }
    return nil
  }
}

extension String  {
  var isNumber: Bool {
    return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
  var isCoordinate: Bool {
    return !isEmpty && (first == "-" || isNumber) && dropFirst().rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
  }
}
