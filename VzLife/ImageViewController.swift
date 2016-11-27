//
//  ImageViewController.swift
//  VzLife
//
//  Created by FOI on 27/11/16.
//  Copyright © 2016 varazdinevents. All rights reserved.
//

import UIKit

//Those two classes we included so we could use it for layout and as for DataSource for collecetion we are using


class ImageViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    struct eventObject{
        var about: String
        var imageUrl: UIImage
    }
    
    var eventsArray: [eventObject] = []
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        eventsArray.append(eventObject(about: "Sabatoni samo za vas 12.10", imageUrl: UIImage(named: "kod")!))
        eventsArray.append(eventObject(about: "Milica Kruscis kraljica Baza", imageUrl: UIImage(named: "kod")!))
        eventsArray.append(eventObject(about: "Sabatoni samo za vas 12.10", imageUrl: UIImage(named: "kod")!))
        eventsArray.append(eventObject(about: "Sabatoni samo za vas 12.10", imageUrl: UIImage(named: "kod")!))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Implementing methods for classes we included
    //First one is for number of items in collectionView ( how many items will we have )
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 
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
