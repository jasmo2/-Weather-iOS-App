//
//  ViewController.swift
//  ¿Weather?
//
//  Created by Jaime Molina Orbe on 2/19/15.
//  Copyright (c) 2015 jasmo2. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cityText: UITextField!
    @IBOutlet var resultLabel: UILabel!
    @IBAction func findWeatherButton(sender: AnyObject) {
    }
    func showError(){
        resultLabel.text = "The city: \(cityText.text) you input was not found"

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      var url =  NSURL(string: "http://www.weather-forecast.com/locations/Bogota/forecasts/latest")
        if true{
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data,response,error) in
                
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<p class=\"summary\">")
                    println(urlContentArray[1])
                }
                else{
                    self.showError()
                };

                }
            task.resume()
    
        }
    }
    override func shouldAutorotate() -> Bool {
        return false
    }
    
    override func supportedInterfaceOrientations() -> Int {
        return UIInterfaceOrientation.Portrait.rawValue
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


