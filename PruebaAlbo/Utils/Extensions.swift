//
//  Extensions.swift
//  PruebaAlbo
//
//  Created by Hector Climaco on 23/04/21.
//

import Foundation
//MARK: Strings
public extension String{
  func localized() -> String{
      let localized = self
      let message = NSLocalizedString(localized, tableName: "AlboStrings", bundle: Bundle.main , value: "", comment: "")
      if !message.isEmpty && message != localized{
          return message
      }else{
          return localized
      }
  }
  
}
