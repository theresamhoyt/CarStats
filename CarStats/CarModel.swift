//
//  CarModel.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import Foundation

var carStatArray = ["CarStats", "Gas","Oil","Tires","Inspection"]
var gasArray = ["Gas","Mielage","Price","Gallons"]
var oilArray = ["Oil", "Mileage", "Price"]
var tireArray = ["Tires", "Mileage of Tires","Price", "Tire Rotation Mileage"]
var inspectionArray = ["Inspection", "Mileage","Date of Inspection","Cost of Inspection"]


//class CarStats: NSObject{
//    
//    var carStatStringArray: [String] = []
//    
//    func getTitle() -> String{
//        return carStatStringArray[0]
//    }
//    func getOne() -> String{
//        return carStatStringArray[1]
//    }
//    func getTwo() -> String{
//        return carStatStringArray[2]
//    }
//    func getThree() -> String{
//        return carStatStringArray[3]
//    }
//    func getFour() -> String{
//        return carStatStringArray[4]
//    }
//}
//
class CarModel{
   
    
    var CarStatsArray: [[String]] = [[]]
   
    class var sharedInstance: CarModel {
        struct Singleton {
            static let instance = CarModel()
        }
        
        return Singleton.instance
    }
    
    func LoadArray() -> [[String]]{
        
      let tempArray: [[String]] = [gasArray,oilArray,tireArray,inspectionArray]
    
    return tempArray
   
    }
 
//    func loadCarStat() {
//       CarStatsArray.carStatStringArray = carStatArray
//    }
//    
//    func loadGas() {
//         CarStatsArray.carStatStringArray = gasArray
//    }
//    
//    func loadOil() {
//        CarStatsArray.carStatStringArray = oilArray
//    }
//    
//    func loadTire() {
//         CarStatsArray.carStatStringArray = tireArray
//    }
//    
//    func loadInspection() {
//        stringArray.carStatStringArray = inspectionArray
//    }
//    
//    func getCarStat() -> [String] {
//
//        return stringArray.carStatStringArray
//    }
    
}

/*
var gas = {
    let title: String = "Gas"
    let mileage: String = "Mielage"
    let price: String = "Price"
    let gallons: String = "Gallons"
    let milesPerGallon = ""
    
}


var oil = {
    let mileage: String = "Mileage"
    let price: String = "Price"
    
}
var tireInfo = {
    let mileageOfCurrTires: String = "Mileage of Tires"
    let price: String = "Price"
    let rotation: String = "Tire Rotation Mileage"
    
    
}


var inspect = {
    
    let mileage: String = "Mileage"
    let date: String = "Date of Inspection"
    let price: String = "Cost of Inspection"
    
    
}
*/


