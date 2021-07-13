//
//  HistoricViewController.swift
//  room
//
//  Created by Vamsi Ravula on 7/3/21.
//

import UIKit


class HistoricViewController: UIViewController {

    var d :String = ""
    @IBOutlet weak var choosedate: UIDatePicker!
    @IBOutlet weak var Historictemp: UILabel!
    @IBOutlet weak var Historichumi: UILabel!
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var Historictime: UILabel!
    @IBOutlet weak var DetailsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }
   
     func HistRasp() {
        // Create URL
        let HBaseURL = "Your Backend API ServerIp:Port/historic?Date="
        let Historicendargs = HBaseURL + d
        let url = URL(string: Historicendargs)
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
                    let avghistoricstudyroom = try decoder.decode([HistoricJSON].self, from: data)
                    var Totaltemp:Float = 0
                    var Totalhumi:Float = 0
                    var Averagetemp:Float = 0
                    var Averagehumi:Float = 0
                    for (index, avghistoric) in avghistoricstudyroom.enumerated() {
                        Totaltemp += Float(avghistoric.Historictemperature)
                        Totalhumi += Float(avghistoric.Historichumidity)
                        
                    }
                    Averagetemp = Totaltemp/Float(avghistoricstudyroom.count)
                    Averagehumi = Totalhumi/Float(avghistoricstudyroom.count)
                    print(Averagetemp)
                    print(Averagehumi)
                   
                    DispatchQueue.main.async(execute: {
                                //print("dispatch")
                        self.Historictemp.text = String (Averagetemp)
                        self.Historichumi.text = String (Averagehumi)
                        
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
    //
    @IBAction func DatePickerChange(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        d = dateFormatter.string(from: (sender as AnyObject).date)
        //print(d)
    }
    
    @IBAction func SubmitButtonAction(_ sender: Any) {
        
        HistRasp()
    }
    
    @IBAction func DetailsButtonAction(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsegue" {
        var vc = segue.destination as! HistoricRowsViewController
        vc.chosendate = self.d
    }
    }
}
