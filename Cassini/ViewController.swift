//
//  ViewController.swift
//  Cassini
//
//  Created by Onder Kalaci on 04/07/16.
//  Copyright © 2016 Onder Kalaci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if let imgViewCtl = segue.destinationViewController as? ImageViewController
        {

            if let identifier = segue.identifier
            {
            switch identifier {
            case "EarthClicked":
                imgViewCtl.imageURL = DemoURL.NASA.Earth
            case "CassiniClicked":
                imgViewCtl.imageURL = DemoURL.NASA.Cassini
            case "SaturnClicked":
                imgViewCtl.imageURL = DemoURL.NASA.Saturn
                
            default:
                imgViewCtl.imageURL = DemoURL.Stanford
            }
        }
        }
    }
}

