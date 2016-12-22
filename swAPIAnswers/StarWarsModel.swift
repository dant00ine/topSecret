//
//  StarWarsModel.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/21/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import Foundation
class StarWarsModel {
    // our get all people function accepts a completionHandler that we will define in the controller
    static func getAllPeople(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        // Specify the url for our GET request
        let url = URL(string: "http://swapi.co/api/people/")
        // Create a URLSession to handle the request tasks
        let session = URLSession.shared
        // Create a "data task" which will request some data from a URL and then run the completion handler
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        // execute the task.
        task.resume()
    }
    static func getAllFilms(completionHandler:@escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://swapi.co/api/people/")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        
        task.resume()
    }
}
