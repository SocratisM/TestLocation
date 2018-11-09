//
//  AddLocationViewModel.swift
//  TestLocation
//
//  Created by Socratis Michaelides on 08/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Foundation
import Core
import RxCocoa
import RxSwift

class AddLocationViewModelConcrete: AddLocationViewModel {
  
  var place = Variable<String?>(nil)
  var longitude = Variable<String?>(nil)
  var latitude = Variable<String?>(nil)
  
  var error: Driver<String?> { return errorValue.asDriver() }
  var errorVisible: Driver<Bool> { return errorValue.asDriver().map { $0 != nil } }
  var didFinish: Driver<Location> { return didFinishSubject.asDriver().unwrap() }
  
  var validator: LocationValidatorType
  
  private var bag = DisposeBag()
  private var errorValue = BehaviorRelay<String?>(value: nil)
  private var didFinishSubject = BehaviorRelay<Location?>(value: nil)
  
  init(validator: LocationValidatorType) {
    self.validator = validator
  }
  
  func bind(done: Observable<Void>, source: AddLocationView) {
    bag = DisposeBag()
    
    let placeValid = placeValidation(done: done)
    let latitudeValid = latitudeValidation(done: done)
    let longitudeValid = longitudeValidation(done: done)
    
    // Whole form validation
    let allValid = Observable.combineLatest([placeValid, latitudeValid, longitudeValid]).map { !$0.contains(false) }
    
    // Done action
    Observable.combineLatest(allValid, done).sample(done).filter({ $0.0 }).asVoid().bind(onNext: { [weak self] in
      self?.addLocation()
    }) >>> bag
  }
  
  private func addLocation() {
    guard
      let place = place.value,
      let longitude = longitude.value,
      let latitude = latitude.value
      else {
        assertionFailure("Missing location values")
        return
    }
    let longitudeFinalValue = longitude.isEmpty ? nil : longitude
    let latitudeFinalvalue = latitude.isEmpty ? nil : latitude
    let newLocation = Location(place: place, longitude: longitudeFinalValue, latitude: latitudeFinalvalue)
    self.didFinishSubject.accept(newLocation)
  }
}

//MARK: - Validations
fileprivate extension AddLocationViewModelConcrete {
  fileprivate func placeValidation(done: Observable<Void>) -> Observable<Bool> {
    let placeValidation = Observable.combineLatest(place.asObservable(), done).map { return $0.0 }
    let placeValid = placeValidation.map { [unowned self] in
      return self.validator.validate(input: LocationInputType.place($0 ?? ""))
    }
    let placeError = placeValidation.map { [unowned self] str in
      return self.validator.error(input: LocationInputType.place(str ?? ""))
    }
    
    placeError.bind(to: self.errorValue) >>> bag
    
    return placeValid
  }
  
  fileprivate func longitudeValidation(done: Observable<Void>) -> Observable<Bool> {
    let longitudeValidation = Observable.combineLatest(longitude.asObservable(), done).map { return $0.0 }
    let longitudeValid = longitudeValidation.map { [unowned self] in
      return self.validator.validate(input: LocationInputType.longitude($0 ?? ""))
    }
    let longitudeError = longitudeValidation.map { [unowned self] str in
      return self.validator.error(input: LocationInputType.longitude(str ?? ""))
    }
    
    longitudeError.bind(to: self.errorValue) >>> bag
    
    return longitudeValid
  }
  
  fileprivate func latitudeValidation(done: Observable<Void>) -> Observable<Bool> {
    let latitudeValidation = Observable.combineLatest(latitude.asObservable(), done).map { return $0.0 }
    let latitudeValid = latitudeValidation.map { [unowned self] in
      return self.validator.validate(input: LocationInputType.longitude($0 ?? ""))
    }
    let latitudeError = latitudeValidation.map { [unowned self] str in
      return self.validator.error(input: LocationInputType.latitude(str ?? ""))
    }
    
    latitudeError.bind(to: self.errorValue) >>> bag
    
    return latitudeValid
  }
}
