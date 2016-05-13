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
    
    func getMileage() -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        return prefs.doubleForKey("mileage")
    }
    
    func setMileage(input: Double){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(input, forKey: "mileage")
    }
}


class GasModel{
    
    var mileage = 0.0
    var price = 0.0
    var gallons = 0.0
    var alert = false
    
    let gasMileageKey = "Gas-Mileage"
    let gasPriceKey = "Gas-Price"
    let gasGallonKey =  "Gallons"
    let gasAlertKey = "gasAlert"
    let carModel = CarModel()
    var gasArr = [Double]()
    
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
        
        alert = getShowAlertData(gasAlertKey)
        gasModel.alert = alert
        
        return gasModel
        
    }
    
    func getGasParameters() -> [Double]{
        gasArr.append(carModel.getMileage())
        gasArr.append(price)
        gasArr.append(gallons)
        return gasArr
    }
    
    func getData(object: String) -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        return prefs.doubleForKey(object)
    }
    func getShowAlertData(object: String) -> Bool{
        let boolPrefs = NSUserDefaults.standardUserDefaults()
        
        return boolPrefs.boolForKey(object)
        
    }
    
    
}

class OilModel{
    
    var oilMileage = 0.0
    var oilPrice = 0.0
    
    let oilMileageKey = "Oil-Mileage"
    let oilPriceKey = "Oil-Price"
    
    let carModel = CarModel()
    var oilArr = [Double]()
    
    
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
        oilArr.append(oilPrice)
        
        return oilModel
    }
    
    func getOilParameters() -> [Double]{
        oilArr.append(carModel.getMileage())
        oilArr.append(oilPrice)
        return oilArr
    }
    
    func getData(object: String) -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        return prefs.doubleForKey(object)

    }
}


class TireModel{
    
    var tireMileage = 0.0
    var newTiresPrice = 0.0
    var tireRotationMileage = 0.0
    
    let tireMileageKey = "Tires-Mileage"
    var newTiresPriceKey = "Tires-Price:"
    var tireRotationMileageKey = "Tire-Rotation-Mileage"
    
    let carModel = CarModel()
    var tireArr = [Double]()
    
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
        
        tireRotationMileage = getData(tireRotationMileageKey)
        tireModel.tireRotationMileage = tireRotationMileage
        
        return tireModel
        
    }
    
    func getTireParameters() -> [Double]{
        tireArr.append(carModel.getMileage())
        tireArr.append(newTiresPrice)
        tireArr.append(tireRotationMileage)
        return tireArr
    }
    
    func getData(object: String) -> Double{
        let prefs = NSUserDefaults.standardUserDefaults()
        print(prefs.doubleForKey(object))
        return prefs.doubleForKey(object)
    }
}


class InspectionModel{
    
    var inspectionMileage = 0.0
    var inspsectionDate = 0.0
    var inspectionPrice = 0.0
    
    var inspectionAlert = false
    let inspectionMileageKey = "Inpection-Mileage"
    var inspectionDateKey = "Inspection-Date"
    var inspectionPricekey = "Inspection-Price:"
    var inspectionAlertKey = "InspectionAlert"
    
    let carModel = CarModel()
    var inspectionArr = [Double]()
    
    class var sharedInstance: InspectionModel {
        struct Singleton {
            static let instance = InspectionModel()
        }
        
        return Singleton.instance
    }
    
    func getInspectionData() -> InspectionModel{
        
        let inspectionModel = InspectionModel()
        
        inspectionMileage = getData(inspectionMileageKey)!
        inspectionModel.inspectionMileage = inspectionMileage
        
        inspsectionDate = getData(inspectionDateKey)!
        inspectionModel.inspsectionDate = inspsectionDate
        
        inspectionPrice = getData(inspectionPricekey)!
        inspectionModel.inspectionPrice = inspectionPrice
        
        inspectionAlert = getShowAlertData(inspectionAlertKey)
        inspectionModel.inspectionAlert = inspectionAlert
        
       return inspectionModel
    }
    
    func getInspectionParameters() -> [Double]{
        inspectionArr.append(carModel.getMileage())
        inspectionArr.append(inspsectionDate)
        inspectionArr.append(inspectionPrice)
        
        return inspectionArr
    }
    
    func getData(object: String) -> Double?{
        let prefs = NSUserDefaults.standardUserDefaults()

        return prefs.doubleForKey(object)
    }
    func getShowAlertData(object: String) -> Bool{
    let boolPrefs = NSUserDefaults.standardUserDefaults()
    
        return boolPrefs.boolForKey(object)
    
    }
}

