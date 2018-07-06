//
//  MenuViewController.swift
//  NYT
//
//  Created by Amber Spadafora on 7/6/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var sectionSelectorTableView: UITableView!
    
    var sectionTitles: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionSelectorTableView.delegate = self
        sectionSelectorTableView.dataSource = self
        let articleSections = ArticleSection.allCases
        let secTitles = articleSections.flatMap {
            var sectionTitle = $0.rawValue.replacingOccurrences(of: "%20", with: " ")
            return sectionTitle
        }
        sectionTitles = secTitles.map{String($0)}
        print(sectionTitles.count)
        
    }

}
extension MenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath) as? MenuItemTableViewCell else { return UITableViewCell() }
        cell.sectionTitleLabel.text = self.sectionTitles[indexPath.row]
        return cell
    }
    
    
    
}
