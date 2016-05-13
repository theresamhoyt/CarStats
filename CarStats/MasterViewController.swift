//
//  MasterViewController.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController{
    

    let color = [UIColor(red: 28/255, green: 173/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 239/255, green: 183/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 255/255, green: 0/255, blue: 4/255, alpha: 1.0),
                 UIColor(red: 252/255, green: 247/255, blue: 143/255, alpha: 1.0)
    ]
    var alertTitle: String?
    var indexPath: NSIndexPath?
    var alertMessage: String?
    var detailViewController: DetailViewController? = nil
    var CellObjects: [[String]] = [[]]
    var counter = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        CellObjects = CarModel.sharedInstance.LoadArray()
        
        self.tableView.reloadData()
        self.view.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
      
        
    }

    override func viewWillAppear(animated: Bool) {
       self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }



    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     
     let indexPath = self.tableView.indexPathForSelectedRow
        var Location = CellObjects[(indexPath?.section)!]
   
print(Location[0])
        if let controller = (segue.destinationViewController as? UINavigationController)!.topViewController as? DetailViewController{
            controller.title = Location[0]

            if let indetify = segue.identifier{
                
                switch indetify{
                case "NextTable":

                    var model = []
                    switch Location[0]{
                        case "Gas": model = GasModel.sharedInstance.getGasData().getGasParameters()
                        case "Oil": model = OilModel.sharedInstance.getOilData().getOilParameters()
                        case "Tires": model = TireModel.sharedInstance.getTireData().getTireParameters()
                        case "Inspection": model = InspectionModel.sharedInstance.getInspectionData().getInspectionParameters()
                        default: break
                    }
                    Location.removeFirst() //remove first string from array object, sends on carStat object parameters
                    controller.CarStat = Location
                    controller.CategoryModel = model as! [Double]
                    
                default: break
                }
        
            }
        
        }
 
    }
    func clearHandler(actionTarget: UIAlertAction){
        
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // Acknowledged the message, remove the data from NSUserDefaults.
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        
        //Saw the message, but want to keep the information. Do not remove from NSUserDefaults.
        alert.addAction(UIAlertAction(title: "Clear", style: UIAlertActionStyle.Default, handler: clearHandler))
        presentViewController(alert, animated: true, completion: nil)
        
    }
    

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return CellObjects.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let stat = CellObjects[indexPath.section]
        let title  = stat[0]
        cell.textLabel!.font = UIFont(name: "Copperplate-Bold", size: 30)
        cell.textLabel!.text = stat[0]
        let size = CGSizeMake(100, 100)
        if title == "Gas"{
            
            getGasAlertData(cell)
            cell.imageView?.image = imageResize(UIImage(named: "gasMain.png")!, sizeChange: size)
            cell.backgroundColor = color[0]//gasColor
        
            
        }else if title == "Oil"{
            getOilAlertData(cell)
            cell.imageView?.image = imageResize(UIImage(named: "oilMain.png")!, sizeChange: size)
            cell.backgroundColor = color[1]//oilColor
            
        }else if title == "Tires"{

            cell.imageView?.image?.scale
            cell.imageView?.image = imageResize(UIImage(named: "tireMain.png")!, sizeChange: size)
            cell.backgroundColor = color[2]//tireColor

            
        }else if title == "Inspection"{
            let inspectionModel = InspectionModel.sharedInstance.getInspectionData()
            
            if(inspectionModel.getShowAlertData(inspectionModel.inspectionAlertKey)){
                cell.accessoryType = .DetailButton
                
            }
            cell.imageView?.image?.scale
            cell.imageView?.image = imageResize(UIImage(named: "inspectionMain.jpeg")!, sizeChange: size)
            cell.backgroundColor = color[3]//inspectionColor

            
        }

        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {

        return true
    }

    func getGasAlertData(cell: UITableViewCell){
        
        alertTitle = "Gas Alert"
        let gasModel = GasModel.sharedInstance.getGasData()
        
        if(gasModel.getShowAlertData(gasModel.gasAlertKey)){
            let gasModel = GasModel.sharedInstance.getGasData()
            cell.accessoryType = .DetailButton
            let gallons = gasModel.getData(gasModel.gasGallonKey)
            let miles = gasModel.getData(gasModel.gasMileageKey)
            let price = gasModel.getData(gasModel.gasPriceKey)
            let gallonsPerPrice = gallons/price
            alertMessage = "Current mileage is \(miles). The Current gallons/price is: \(gallonsPerPrice)"
            self.view.setNeedsDisplay()
            }
    }
    func getOilAlertData(cell: UITableViewCell){
            alertTitle = "Oil Alert"
            let oilModel = OilModel.sharedInstance.getOilData()
            
            if(oilModel.getShowAlertData(oilModel.oilAlertKey)){
                cell.accessoryType = .DetailButton
                let oilData = OilModel.sharedInstance.getOilData()
                let miles = oilData.oilMileage
                let price = oilData.oilPrice
                
                alertMessage = "Oil Change is needed. Your current mileage is \(miles). The last price paid was \(price)"
                self.view.setNeedsDisplay()
            }

    }
    func getTireAlertData(cell: UITableViewCell){
        alertTitle = "Tire Alert"
        let tirelModel = TireModel.sharedInstance.getTireData()
        
        if(tirelModel.getShowAlertData(tirelModel.tireAlertKey)){
            cell.accessoryType = .DetailButton
            let tireData = TireModel.sharedInstance.getTireData()
            let miles = tireData.tireMileage
            let newTirePrice = tireData.newTiresPrice
            let tireRotation = tireData.tireRotationMileage
            
            alertMessage = "New Tirees or Tire Rotation is needed. Your current mileage is \(miles). The last price paid for tires was \(newTirePrice) and the last mileage the tires were rotated was  \(tireRotation)"
            self.view.setNeedsDisplay()
        }
    }
    func getInspectionAlertData(cell: UITableViewCell){
        alertTitle = "Insepction Alert"
        let inspectionModel = InspectionModel.sharedInstance.getInspectionData()
            
        if(inspectionModel.getShowAlertData(inspectionModel.inspectionAlertKey)){
            cell.accessoryType = .DetailButton
            let inspectionData = InspectionModel.sharedInstance.getInspectionData()
            let inspectionDate = inspectionData.inspectionDateKey
            let miles = inspectionData.inspectionMileage
            let inspectionPrice = inspectionData.inspectionPrice
                
            alertMessage = "Inspection is needed. Your current mileage is \(miles). The last price paid for an inspection was \(inspectionPrice) and the next inspection is due on  \(inspectionDate)"
            self.view.setNeedsDisplay()
            }
        
    
    }
    func imageResize(image: UIImage, sizeChange:CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha,scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
            
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
            
    }
}



