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
    var currCell: UITableViewCell?
    var alertTitle: String?
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
        
        if(currCell != nil){
            alertData(currCell!)
        }
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
    func okHandler(actionTarget: UIAlertAction){
        print("YES");//operator ! because it's Optional here
        
        
    }
    
    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.Alert)
        
        // Acknowledged the message, remove the data from NSUserDefaults.
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: okHandler))
        
        //Saw the message, but want to keep the information. Do not remove from NSUserDefaults.
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
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
            alertTitle = "Gas Alert"
            alertData(cell)
            cell.imageView?.image = imageResize(UIImage(named: "gasMain.png")!, sizeChange: size)
            cell.backgroundColor = color[0]//gasColor
        
            
        }else if title == "Oil"{
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

    func alertData(cell: UITableViewCell){
        
        currCell = cell
        let gasModel = GasModel.sharedInstance.getGasData()
        
        if(gasModel.getShowAlertData(gasModel.gasAlertKey)){
            let gasModel = GasModel.sharedInstance.getGasData()
       
            cell.accessoryType = .DetailButton
            let gallons = gasModel.getData(gasModel.gasGallonKey)
            let miles = gasModel.getData(gasModel.gasMileageKey)
            let price = gasModel.getData(gasModel.gasPriceKey)
            let gallonsPerPrice = gallons/price
            alertMessage = "Current mileage is " +  "\(miles)" + ". Current gallons/price is: \(gallonsPerPrice)"
            cell.contentView.setNeedsDisplay()
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

