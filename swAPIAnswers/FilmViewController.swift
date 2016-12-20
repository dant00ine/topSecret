//
//  FilmViewController.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/19/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import UIKit

class FilmViewController: UITableViewController {
    
    // data array for storing tableView data -- see cellForRowAt function
    var films: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // prepare request information and session
        let url = NSURL(string: "http://swapi.co/api/films")
        let session = URLSession.shared
        
        // retrieve data from url and handle with 'completionHandler' function enclosure
        let task = session.dataTask(with: url! as URL, completionHandler: {
            // anonymous function callback has three arguments
            data, response, error in
            do {
                // is there a result? Continue if we can cast response to dictionary type
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    
                    // cast results key to array for iteration
                    if let results = jsonResult["results"] as? NSArray {
                        for film in results {
                            // cast to dictionary for data extraction
                            let filmDict = film as! NSMutableDictionary
                            self.films.append(filmDict["title"] as! String)
                        }
                    }
                }
                // async -- if we loaded the data outside of the do-catch statement
                // it would attempt to load before we had populated the 'people' array
                self.tableView.reloadData()
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return films.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmCell", for: indexPath)

        cell.textLabel?.text = films[indexPath.row]

        return cell
    }

}
