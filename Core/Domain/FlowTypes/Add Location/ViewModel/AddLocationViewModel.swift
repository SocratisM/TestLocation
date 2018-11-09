//
//  AddLocationViewModel.swift
//  Core
//
//  Created by Socratis Michaelides on 08/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol AddLocationViewModel {
  var validator: LocationValidatorType { get }

  var place: Variable<String?> { get }
  var longitude: Variable<String?> { get }
  var latitude: Variable<String?> { get }
  
  var error: Driver<String?> { get }
  var errorVisible: Driver<Bool> { get }
  var didFinish: Driver<Location> { get }
  
  func bind(done: Observable<Void>, source: AddLocationView)
}
