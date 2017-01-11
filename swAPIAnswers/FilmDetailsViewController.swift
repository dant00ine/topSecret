//
//  FilmDetailsViewController.swift
//  swAPIAnswers
//
//  Created by Daniel Thompson on 12/22/16.
//  Copyright © 2016 Daniel Thompson. All rights reserved.
//

import UIKit

class FilmDetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var openingCrawl: UITextView!
    
    var film: NSDictionary!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(film)
        titleLabel.text = film["title"] as? String
        releaseLabel.text = film["release_date"] as? String
        directorLabel.text = film["director"] as? String
        openingCrawl.text = film["opening_crawl"] as? String

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
