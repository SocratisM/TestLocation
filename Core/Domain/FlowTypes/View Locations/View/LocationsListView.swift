//
//  LocationsListView.swift
//  Core
//
//  Created by Socratis Michaelides on 07/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

public protocol LocationsListView: BaseView {
  var onLocationSelect: ((Location) -> ())? { get set }
  var onAddLocation: (() -> Void)? { get set }
  func onNewLocationAdded(location: Location)
}


