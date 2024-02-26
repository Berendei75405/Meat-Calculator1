//
//  MainViewModel.swift
//  Meat Calculator
//
//  Created by Novgorodcev on 24.11.2023.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var meatArray: [String] { get }
    var meatModel: MeatModel { get set }
    func getTime(index: Int) -> String
    func resultMeat() -> String
}

final class MainViewModel: MainViewModelProtocol {
    var coordinator: MainCoordinatorProtocol?
    let meatArray = ["Cow", "Pig", "Sheep",
                     "Chicken", "Turkey", "Vegetables"]
    let timeArray = ["Мы быстро покушаем и по домам",
                     "Нормально посидим",
                     "Пока мангал не развалится"]

    var meatModel = MeatModel(person: 1, meat: .cow, hunger: .easy, time: .easy)
    
    //MARK: - getTime
    func getTime(index: Int) -> String {
        if timeArray.indices.contains(index) {
            return timeArray[index]
        }
        
        return ""
    }
    
    //MARK: - resultMeat
    func resultMeat() -> String  {
        let person = Float(meatModel.person)
        var hunger: Float = 0
        var meat: Float = 0
        var meatString = ""
        var time: Float = 0
        
        //hunger
        switch meatModel.hunger {
        case .easy:
            hunger = 0
        case .normal:
            hunger = 0.1
        case .hard:
            hunger = 0.2
        }
        
        //meat
        switch meatModel.meat {
        case .cow:
            meat = 0.3
            meatString = "говядины"
        case .pig:
            meat = 0.3
            meatString = "свинины"
        case .sheep:
            meat = 0.3
            meatString = "баранины"
        case .chicken:
            meat = 0.4
            meatString = "курицы"
        case .vegetables:
            meat = 0.4
            meatString = "растительного мяса"
        case .turkey:
            meat = 0.4
            meatString = "индейки"
        }
        
        //time
        switch meatModel.time {
        case .easy:
            time = 0
        case .normal:
            time = 0.1
        case .hard:
            time = 0.2
        }
        
        let sum = (person * meat) + (person * hunger) + (person * time)
        if sum.truncatingRemainder(dividingBy: 1) == 0 {
            return "\(Int(sum)) кг \(meatString)"
        } else {
            return "\(NSString(format:"%.1f", sum)) кг \(meatString)"
        }
        
    }
    
}
