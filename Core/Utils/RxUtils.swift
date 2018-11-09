//
//  RxUtils.swift
//  Core
//
//  Created by Socratis Michaelides on 08/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

infix operator >>>: AdditionPrecedence
public func >>> (lhs: Disposable?, rhs: DisposeBag) {
  lhs?.disposed(by: rhs)
}

infix operator <->: AdditionPrecedence
public func <-> <T> (property: ControlProperty<T>, variable: Variable<T>) -> Disposable {
  let bindToUIDisposable = variable.asObservable().debug("Variable values in bind")
    .bind(to: property)
  
  let bindToVariable = property
    .debug("Property values in bind")
    .subscribe(onNext: { n in
      variable.value = n
    }, onCompleted: {
      bindToUIDisposable.dispose()
    })
  
  return Disposables.create(bindToUIDisposable, bindToVariable)
}

public protocol Optionable {
  associatedtype WrappedType
  
  func unwrap() -> WrappedType
  func isEmpty() -> Bool
}

extension Optional : Optionable {
  public typealias WrappedType = Wrapped
  public func unwrap() -> WrappedType {
    return self!
  }
  public func isEmpty() -> Bool {
    return self == nil
  }
}

extension ObservableType where E : Optionable {
  public func unwrap() -> Observable<E.WrappedType> {
    return self.filter({ !$0.isEmpty() }).map({ $0.unwrap() })
  }
  
  public func onNil() -> Observable<Void> {
    return self.filter({ $0.isEmpty() }).map({ _ -> Void in })
  }
}

extension SharedSequence where S == DriverSharingStrategy, E : Optionable {
  public func unwrap() -> SharedSequence<S, E.WrappedType> {
    return self.filter({ !$0.isEmpty() }).map({ $0.unwrap() })
  }
  
  public func onNil() -> SharedSequence<S, Void> {
    return self.filter({ $0.isEmpty() }).map({ _ -> Void in })
  }
}

extension ObservableType {
  public func asVoid() -> Observable<Void> {
    return self.map { _ in }
  }
}
