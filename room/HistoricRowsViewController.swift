//
//  HistoricRowsViewController.swift
//  room
//
//  Created by Vamsi Ravula on 12/3/21.
//

import UIKit

class HistoricRowsViewController: UIViewController {
    var atmosrows: [HistoricJSON] = []
    var chosendate: String = ""
    var l = 99
    @IBOutlet weak var tableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //atmosrows =
        HistRaspi() { [self] detailhistoricstudyroom in
            atmosrows = detailhistoricstudyroom
            
            
            
        }
        
        print("jaa")
        tableview.delegate = self
        tableview.dataSource = self
        //self.tableview.reloadData()

        // Do any additional setup after loading the view.
    }
    
    func HistRaspi(completion: @escaping (([HistoricJSON]) -> Void)) {
    let HBaseURL = "Your Backend API Server Ip:Port/historic?Date="
    let Historicendargs = HBaseURL + chosendate
    let url = URL(string: Historicendargs)
    guard let requestUrl = url else { fatalError() }

    // Create URL Request
    var request = URLRequest(url: requestUrl)

    // Specify HTTP Method to use
    request.httpMethod = "GET"

    // Send HTTP Request
    let task = URLSession.shared.dataTask(with: request) { [self] (data, response, error) in
        //var f: Int
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
                let detailhistoricstudyroom = try decoder.decode([HistoricJSON].self, from: data)
                
                
                completion(detailhistoricstudyroom)
                DispatchQueue.main.async(execute: {
                            self.tableview.reloadData()
                            //print("dispatch")
                    
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




   extension HistoricRowsViewController: UITableViewDataSource, UITableViewDelegate {
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("table \(atmosrows.count) ")
           return atmosrows.count
       }
       
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let Vatmosrow = atmosrows[indexPath.row]
           let cell = tableView.dequeueReusableCell(withIdentifier: "HistoricTableViewCell") as! HistoricTableViewCell
           cell.setatmos(atmosrow: Vatmosrow)
           
           return cell
       }
   

}
