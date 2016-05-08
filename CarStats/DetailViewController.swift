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
    
    
    var text: String = ""
    var fileName: String = ""
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let color = [UIColor(red: 28/255, green: 173/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 239/255, green: 183/255, blue: 0/255, alpha: 1.0),
                 UIColor(red: 255/255, green: 0/255, blue: 4/255, alpha: 1.0),
                 UIColor(red: 252/255, green: 247/255, blue: 143/255, alpha: 1.0)
    ]
    
    var CarStat: [String] = []
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
        
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return CarStat.count
        
    }
    
    
    //    override func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let Cell1 = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath) as? customDetailCell
        Cell1!.textLabel!.font = UIFont(name: "Copperplate-Bold", size: 15)
        
        
        switch(self.title){
        case "Gas"?:
            Cell1!.backgroundColor = color[0]
            Cell1!.customView.backgroundColor = color[0]
            fileName = "Gas.rtf"
            
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
        Cell1!.customViewTextField?.keyboardType = .DecimalPad
        
        if(Cell1!.customViewTextField.window != "nil"){
            
        }
        
        return Cell1!
    }

    @IBAction func SaveInput(sender: AnyObject) {

        let value = sender as! UIButton
        let indexPath = self.tableView.indexPathForView(value)!
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as? customDetailCell
        
        print(cell?.customTitle?.text!)
        var input = cell?.customViewTextField?.text!
        print(input)
        
        if(fileName.containsString("Gas")){
            if(cell!.customTitle?.text! == "Insert Mileage"){
                text = "mileage " + input!
            }
            else if(cell!.customTitle?.text! == "Insert Mileage"){
                text = "price"  + input!
            }
            
        }
        print(text)
        writeToFile(fileName, text: text)
        cell!.customDetail.text = input
        cell!.customViewTextField?.text! = ""
  
        cell!.customView.setNeedsDisplay()
        input = ""
    }
    

    
    @IBAction func CancelInput(sender: AnyObject) {
        text = ""
    }
    
    func writeToFile(fileName: String, text: String){

        let findFile = getDirectory().stringByAppendingPathComponent(fileName)
        
        do {
            try text.writeToFile(findFile, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            // failed to write file – bad permissions, bad filename, missing permissions, or more likely it can't be converted to the encoding
        }
        
        
    }
    func getDirectory() -> NSString{
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = documentsPath[0]
        return documentsDirectory
    }
    
}



