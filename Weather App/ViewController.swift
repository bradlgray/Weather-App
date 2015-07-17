//
//  ViewController.swift
//  Weather App
//
//  Created by Brad Gray on 7/15/15.
//  Copyright (c) 2015 Brad Gray. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var enterCity: UITextField!
    
    @IBOutlet weak var weatherResult: UILabel!
    
    
    @IBAction func getWeather(sender: UIButton) {
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + enterCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlErrorMessage = false
                var weather = ""
                
                if error == nil {
                    
                    var urlContent = NSString(data: data, encoding: NSUTF8StringEncoding) as NSString!
                    
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0] as! String
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    } else {
                        urlErrorMessage = true
                    }
                    
                    
                } else {
                    
                    urlErrorMessage = true
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    
                    
                    
                    if urlErrorMessage == true {
                        self.showError()
                    } else {
                        self.weatherResult.text = weather
                    }
                    
                }
            })
            
            task.resume()
        } else {
            showError()
            
        }
    

        
    }
    
    func showError() {
        weatherResult.text = "Was Not Able to Find \( enterCity.text) please try again."

        
    }
    

    
   

}

