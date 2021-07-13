//
//  ViewController.swift
//  room
//
//  Created by Vamsi Ravula on 24/2/21.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    @IBOutlet weak var currenttime: UILabel!
    @IBOutlet weak var tempe: UILabel!
    @IBOutlet weak var humid: UILabel!
    @IBOutlet weak var currentdate: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Rasp()
        // Do any additional setup after loading the view.
    }
    
    func Rasp() {
        // Create URL
        let url = URL(string: "Your backend API Server IP: Port/atmos")
        guard let requestUrl = url else { fatalError() }

        // Create URL Request
        var request = URLRequest(url: requestUrl)

        // Specify HTTP Method to use
        request.httpMethod = "GET"

        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
                
                
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data {
                //self.temp.text = dataString
                let decoder = JSONDecoder()
                do {
                    let studyroom = try decoder.decode(HomeMonitorJSON.self, from: data)
                    //print(studyroom.humidity)
                    
                    DispatchQueue.main.async(execute: {
                                //print("dispatch")
                        self.tempe.text = String (studyroom.temperature)
                        self.humid.text = String (studyroom.humidity)
                        self.currenttime.text = studyroom.ctime
                        self.currentdate.text=studyroom.date
                        
                            })
                }
                //print(type(of: datas))
                catch {
                    print (" JSON Error Found")
                }
                
                }

            
        }
        task.resume()
    }

    
}

