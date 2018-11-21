//
//  CustomError.swift
//  Core
//
//  Created by Socratis Michaelides on 21/11/2018.
//  Copyright © 2018 Socratis Michaelides. All rights reserved.
//

import Foundation

public enum CustomError: Error {
  case missingWikiURLScheme
}

extension CustomError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .missingWikiURLScheme:
      return NSLocalizedString("cant_open_wiki_url", comment: "")
    }
  }
  
  public var localizedDescription: String {
    switch self {
    case .missingWikiURLScheme:
      return NSLocalizedString("cant_open_wiki_url", comment: "")
    }
  }
}
