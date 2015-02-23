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
       cityText.text = cityText.text.stringByReplacingOccurrencesOfString(" ", withString: "-")
        var url =  NSURL(string: "http://www.weather-forecast.com/locations/\(cityText.text)/forecasts/latest")

        var errorUrl:Bool = false
        if true{
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!){
                (data,response,error) in
                var weather:String = ""
                if error == nil{
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 1 {
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        //                        println( "weather = \(_stdlib_getTypeName(weatherArray[0]))")
                        weather = weatherArray[0] as String
                        weather =  weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    }else {
                        errorUrl = true
                    }
                }
                else{
                    errorUrl = true
                };
                dispatch_async(dispatch_get_main_queue()){
                    if errorUrl == false{
                        self.resultLabel.text = weather
                        
                    }else{
                        self.showError()
                    }
                    
                    
                }
            }
            task.resume()
        }
    }
    func showError(){
        resultLabel.text = "The city: \(cityText.text) you input was not found"

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
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
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(cityText: UITextField!)-> Bool{
        cityText.resignFirstResponder()
        return true
    }

   }


