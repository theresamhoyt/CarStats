//
//  DetailViewController.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import UIKit

extension UITableView {
    func indexPathForView (view : UIView) -> NSIndexPath? {
        let location = view.convertPoint(CGPointZero, toView:self)
        return indexPathForRowAtPoint(location)
    }
}
class DetailViewController: UITableViewController {
    

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let color = [UIColor(red: 28/255, green: 173/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 239/255, green: 183/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 255/255, green: 0/255, blue: 4/255, alpha: 1.0),
                 UIColor(red: 252/255, green: 247/255, blue: 143/255, alpha: 1.0)
    ]
    var CarStat: [String] = []
    var CategoryModel: [Double] = []
    
    
    
    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.description
                
                
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        self.view.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)

    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return CarStat.count
        
    }
    
    //    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    class customView: UIView {
//        let viewLabel: UILabel?
//        override init(frame: CGRect) {
//            super.init(frame:frame)
//            
//            viewLabel = UILabel(frame: CGRect(x: 20, y:20, width: 100, height: 250))
//            addSubview(viewLabel!)
//        }
//        required init?(coder aDecoder: NSCoder){
//            super.init(coder: aDecoder)
//        }
//    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let Cell1 = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as? customDetailCell
        Cell1!.textLabel!.font = UIFont(name: "Copperplate-Bold", size: 15)
        
        switch(self.title){
        case "Gas"?:
//            let gasModel = GasModel.sharedInstance.getGasData()
//            let mileage = gasModel.mileage
//            print(mileage)
            Cell1!.backgroundColor = color[0]
            Cell1!.customView.backgroundColor = color[0]

            
        case "Oil"?:
            Cell1!.backgroundColor = color[1]
            Cell1!.customView.backgroundColor = color[1]
            
        case "Tires"?:
            Cell1!.backgroundColor = color[2]
            Cell1!.customView.backgroundColor = color[2]
            
        case "Inspection"?:
            Cell1!.backgroundColor = color[3]
            Cell1!.customView.backgroundColor = color[3]
            
        default:
            print("default")
            break
        }
        
        
        Cell1!.customTitle?.text = CarStat[indexPath.section]
        
        
        //this is adding curent values to the detail item in the cell =========
        if (CategoryModel.count > 1){
            if (indexPath == 0){
                Cell1!.customDetail.text = String(CategoryModel[indexPath.section])
            }
            Cell1!.customDetail.text = String(CategoryModel[indexPath.section])
        } else {
            Cell1!.customDetail.text = String(0.0)
        }
        //=====================================================================
        
        Cell1!.customViewTextField?.keyboardType = .DecimalPad

        return Cell1!
    }
    @IBAction func SaveInput(sender: AnyObject) {

        let value = sender as! UIButton
        let indexPath = self.tableView.indexPathForView(value)!
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? customDetailCell
        cell!.customTitle?.text = CarStat[indexPath.section]
        
        cell!.customDetail.text = ""
        let input = ((cell?.customViewTextField?.text!)! as NSString).doubleValue
        let title = cell!.customTitle?.text
        
        writerHelper(title!, input: input)
       
        cell!.customDetail.text = String(input)
        cell!.customViewTextField?.text! = ""
  
        cell!.customView.setNeedsDisplay()
//        input = ""
    }
    
    @IBAction func CancelInput(sender: AnyObject) {
        let value = sender as! UIButton
        let indexPath = self.tableView.indexPathForView(value)!
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? customDetailCell
        cell!.customViewTextField?.text = ""
        
        
    }
  

    func writerHelper(title: String, input: Double){
        let carModel = CarModel()
        switch(self.title){
        
        case "Gas"?:
           let gasModel = GasModel.sharedInstance.getGasData()
           
           if ifStr1ContainsStr2(title, str2: gasModel.gasMileageKey){
                writeToNSUserDefaults(input, key: gasModel.gasMileageKey)
                carModel.setMileage(input)
            
           }
           if ifStr1ContainsStr2(title, str2: gasModel.gasPriceKey){
                writeToNSUserDefaults(input, key: gasModel.gasPriceKey)
           }
           if ifStr1ContainsStr2(title, str2: gasModel.gasGallonKey){
                writeToNSUserDefaults(input, key: gasModel.gasGallonKey)
           }
            
        case "Oil"?:
           
            let oilModel = OilModel.sharedInstance.getOilData()
            
            if ifStr1ContainsStr2(title, str2: oilModel.oilMileageKey){
                writeToNSUserDefaults(input, key: oilModel.oilMileageKey)
                carModel.setMileage(input)
            }
            else if ifStr1ContainsStr2(title, str2: oilModel.oilPriceKey){
                writeToNSUserDefaults(input, key: oilModel.oilPriceKey)
            }
        
            
        case "Tires"?:

            let tireModel = TireModel.sharedInstance.getTireData()
            
            if ifStr1ContainsStr2(title, str2: tireModel.newTiresPriceKey ){
                writeToNSUserDefaults(input, key: tireModel.newTiresPriceKey)
            }
            if ifStr1ContainsStr2(title, str2: tireModel.tireMileageKey){
                writeToNSUserDefaults(input, key: tireModel.tireMileageKey)
                carModel.setMileage(input)
            }
            if ifStr1ContainsStr2(title, str2: tireModel.tireRotationMileageKey){
                writeToNSUserDefaults(input, key: tireModel.tireRotationMileageKey)
                carModel.setMileage(input)
            }
            
            
        case "Inspection"?:
            
            let inspectionModel = InspectionModel.sharedInstance.getInspectionData()
            
            if ifStr1ContainsStr2(title, str2: inspectionModel.inspectionMileageKey ){
                writeToNSUserDefaults(input, key: inspectionModel.inspectionMileageKey)
                carModel.setMileage(input)
            }
            if ifStr1ContainsStr2(title, str2: inspectionModel.inspectionDateKey){
                writeToNSUserDefaults(input, key: inspectionModel.inspectionDateKey)
            }
            if ifStr1ContainsStr2(title, str2: inspectionModel.inspectionPricekey){
                writeToNSUserDefaults(input, key: inspectionModel.inspectionPricekey)
            }
            
            
        default:
            print("default")
            break
        }

    }
    func ifStr1ContainsStr2(str1: String, str2: String) -> Bool{
        
        if str1.containsString(str2){
            return true
        }
        return false
    }
    
    func writeToNSUserDefaults(input: Double, key: String){
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setObject(input, forKey: key)
    }
}
