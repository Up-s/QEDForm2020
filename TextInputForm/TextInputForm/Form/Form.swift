//
//  Form.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/18.
//  Copyright © 2020 Up's. All rights reserved.
//

import UIKit

protocol FormDelegate: class {
  func nextFocus(tag: Int)
}

class Form: UIView {
  
  weak var delegate: FormDelegate?
  
  var targetTextField: UITextField?
  var segmentedControl: UISegmentedControl?
  
  struct Padding {
    static let inset: CGFloat = 0
    static let itemToPadding: CGFloat = 24
    static let topSpace: CGFloat = 32
    static let bottomSpace: CGFloat = 24
  }
}
