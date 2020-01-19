//
//  FormModel.swift
//  TextInputForm
//
//  Created by Lee on 2020/01/17.
//  Copyright © 2020 Up's. All rights reserved.
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
}

enum KeyBoardType {
  case nomarl
  case email
  case number
  case password
}

var formData: [FormModel] = [
  FormModel(
    title: "이메일을 입력해주세요",
    type: FormType.text("Email", KeyBoardType.email)
  ),
  FormModel(
    title: "이름을 입력해주세요",
    type: FormType.text("Name", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "전화번호를 입력해주세요",
    type: FormType.phone("Phone")
  ),
  FormModel(
    title: "닉네임을 입력해주세요",
    type: FormType.text("Nick Name", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "취미를 적어주세요",
    type: FormType.text("Hobby", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "생년월일을 입력해주세요",
    type: FormType.birth("Year", "Month", "Day")
  ),
  FormModel(
    title: "성별을 입력해주세요",
    type: FormType.gender("Gender")
  ),
  FormModel(
    title: "소속을 입력해주세요",
    type: FormType.text("Team", KeyBoardType.nomarl)
  ),
  FormModel(
    title: "비밀번호를 입력해주세요",
    type: FormType.text("Password", KeyBoardType.password)
  ),
  FormModel(
    title: "비밀번호를 재입력해주세요",
    type: FormType.text("Password", KeyBoardType.password)
  )
]
