//
//  DetailViewController.swift
//  CarStats
//
//  Created by Theresa Hoyt on 4/29/16.
//  Copyright © 2016 Theresa Hoyt. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    
    
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
        print(CarStat.count)
    }
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return CarStat.count
        
    }
    
   override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell1 = tableView.dequeueReusableCellWithIdentifier("Cell1", forIndexPath: indexPath)
    
    switch(self.title){
    case "Gas"?:
        Cell1.backgroundColor = color[0]
        
    case "Oil"?:
        Cell1.backgroundColor = color[1]
    case "Tires"?:
        Cell1.backgroundColor = color[2]
    case "Inspection"?:
        Cell1.backgroundColor = color[3]
    default:
        print("default")
        break
    }
    
            Cell1.textLabel?.text = CarStat[indexPath.section]
        
        return Cell1
    }

}

