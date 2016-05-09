//
//  CarModel.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import Foundation


var carStatArray = ["CarStats", "Gas","Oil","Tires","Inspection"]
var gasArray = ["Gas","Gas-Mileage:","Gas-Price:","Gallons"]
var oilArray = ["Oil", "Oil-Mileage:", "Oil-Price"]
var tireArray = ["Tires", "New Tires-Mileage:","New Tires-Price:", "Tire-Rotation-Mileage: "]
var inspectionArray = ["Inspection", "Inpection-Mileage:","Inspection-Date:","Inspection-Price:"]


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
 
    let gasMileageKey = "Gas-Mileage"
    let gasPriceKey = "Gas-Price"
    let gasGallonKey =  "Gallons"
    
    class var sharedInstance: GasModel {
        struct Singleton {
            static let instance = GasModel()
        }
        
        return Singleton.instance
    }
    
    func getGasData() -> GasModel{
        
        let gasModel = GasModel()
        
        mileage = getData(gasMileageKey)
        gasModel.mileage = mileage
        
        price = getData(gasPriceKey)
        gasModel.price = price
        
        gallons = getData(gasGallonKey)
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

class OilModel{
    
    var oilMileage: String?
    var oilPrice: String?
    
    let oilMileageKey = "Oil-Mileage"
    var oilPriceKey = "Oil-Price"
   
    
    class var sharedInstance: OilModel {
        struct Singleton {
            static let instance = OilModel()
        }
        
        return Singleton.instance
    }
    
    func getOilData() -> OilModel{
        
        let oilModel = OilModel()
        
        oilMileage = getData(oilMileageKey)
        oilModel.oilMileage = oilMileage
        
        oilPrice = getData(oilPriceKey)
        oilModel.oilPrice = oilPrice
        
        return oilModel
        
    }
    
    func getData(object: String) -> String?{
        let prefs = NSUserDefaults.standardUserDefaults()
        if let  data = prefs.objectForKey(object){
            return data as? String
        }
        return nil
    }
    
    
}

class TireModel{
    
    var tireMileage: String?
    var newTiresPrice: String?
    var tireRotation : String?
    
    let tireMileageKey = "Tires-Mileage"
    var newTiresPriceKey = "Tires-Price:"
    var tireRotationKey = "Tire-Rotation-Mileage"
    
    class var sharedInstance: TireModel {
        struct Singleton {
            static let instance = TireModel()
        }
        
        return Singleton.instance
    }
    
    func getTireData() -> TireModel{
        
        let tireModel = TireModel()
        
        tireMileage = getData(tireMileageKey)
        tireModel.tireMileage = tireMileage
        
        newTiresPrice = getData(newTiresPriceKey)
        tireModel.newTiresPrice = newTiresPrice
        
        tireRotation = getData(newTiresPriceKey)
        tireModel.tireRotation = tireRotation
        
        return tireModel
        
    }
    
    func getData(object: String) -> String?{
        let prefs = NSUserDefaults.standardUserDefaults()
        if let  data = prefs.objectForKey(object){
            return data as? String
        }
        return nil
    }
    
    
}
class InspectionModel{
    
    var inspectionMileage: String?
    var inspsectionDate: String?
    var inspectionPrice : String?
    
    let inspectionMileageKey = "Inpection-Mileage"
    var inspectionDateKey = "Inspection-Date"
    var inspectionPricekey = "Inspection-Price:"
    
    class var sharedInstance: InspectionModel {
        struct Singleton {
            static let instance = InspectionModel()
        }
        
        return Singleton.instance
    }
    
    func getInspectionData() -> InspectionModel{
        
        let inspectionModel = InspectionModel()
        
        inspectionMileage = getData(inspectionMileageKey)
        inspectionModel.inspectionMileage = inspectionMileage
        
        inspsectionDate = getData(inspectionDateKey)
        inspectionModel.inspsectionDate = inspsectionDate
        
        inspectionPrice = getData(inspectionPricekey)
        inspectionModel.inspectionPrice = inspectionPrice
        
        return inspectionModel
        
    }
    
    func getData(object: String) -> String?{
        let prefs = NSUserDefaults.standardUserDefaults()
        if let  data = prefs.objectForKey(object){
            return data as? String
        }
        return nil
    }
    
    
}

