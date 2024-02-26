//
//  MeatModel.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 05.01.2024.
//

import Foundation

//MARK: - Meat
enum Meat {
    case cow, pig
    case sheep, chicken
    case vegetables, turkey
}

//MARK: - Lavel
enum Lavel {
    case easy
    case normal
    case hard
}

struct MeatModel {
    var person: Int
    var meat: Meat
    var hunger: Lavel
    var time: Lavel
}
