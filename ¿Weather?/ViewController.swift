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
        var errorUrl:Bool = false
        if true{
          let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data,response,error) in
            var weather:String
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
//                        println( "weather = \(_stdlib_getTypeName(weatherArray[0]))")
                        weather = weatherArray[0] as String

                    }else {
                        errorUrl = true
                    }
                }
                else{
                    errorUrl = true
                };

                }
            task.resume()
            dispatch_async(dispatch_get_main_queue()){
                if errorUrl == false{
                 resultLabel.text = weather
                
                }else{
                    self.showError()
                }

            
            }
            
    
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


