//
//  CarModel.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import Foundation


var carStatArray = ["CarStats", "Gas","Oil","Tires","Inspection"]
var gasArray = ["Gas","Insert Mileage","Insert Price","Insert Gallons"]
var oilArray = ["Oil", "Insert Mileage", "Insert Price"]
var tireArray = ["Tires", "Insert Mileage @ New Tires","Insert New Tires Price", "Insert Mileage @ Tire Rotation "]
var inspectionArray = ["Inspection", "Insert Mileage","Date of Inspection","Insert Total Cost"]


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
    

    
}
class GasModel{
    
    var mileage: String?
    var price: String?
    var gallons: String?
 
    let mileageKey = "gasMileage"
    let priceKey = "gasPrice"
    let gallonKey =  "gasGallons"
    
    class var sharedInstance: GasModel {
        struct Singleton {
            static let instance = GasModel()
        }
        
        return Singleton.instance
    }
    
    func getGasData() -> GasModel{
        
        let gasModel = GasModel()
        
        mileage = getData(mileageKey)
        gasModel.mileage = mileage
        
        price = getData(priceKey)
        gasModel.price = price
        
        gallons = getData(gallonKey)
        gasModel.gallons = gallons
        
       return gasModel
        
    }
    
    func getData(object: String) -> String?{
        let prefs = NSUserDefaults.standardUserDefaults()
        if let  data = prefs.objectForKey(object){
            return data as? String
        }
        return nil
    }
    
    
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


