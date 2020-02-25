//
//  FormModel.swift
//  QEDForm
//
//  Created by Lee on 2020/02/18.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

struct FormModel {
  let title: String
  let type: FormType
}

enum FormType {
  case text(String, KeyBoardType)
  case birth(String, String, String)
  case phone(String)
  case gender(String)
  case picker(String)
  case date(String)
}

enum KeyBoardType {
  case nomarl
  case email
  case number
  case password
}
