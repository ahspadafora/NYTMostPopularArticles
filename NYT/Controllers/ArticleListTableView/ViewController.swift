//
//  ViewController.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async {
                self.articleTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var articleTableView: UITableView!
    @IBOutlet weak var menuLeadingConstraint: NSLayoutConstraint!
    
    @IBAction func menuPressed(_ sender: UIBarButtonItem) {
        print("menu button has been pressed")
        
        menuLeadingConstraint.constant = (menuLeadingConstraint.constant == 0) ? -240 : 0
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = ArticleSection.Health.rawValue
        ArticleFactory().getArticles(section: .Health) { (root) in
            let root = root
            self.articles = root.results
        }
        
        articleTableView.delegate = self
        articleTableView.dataSource = self
        
        
    }
    
    @objc func presentMenu(){
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? ArticleTableViewCell else { fatalError() }
        
        cell.tag = indexPath.row
        cell.thumbnailImage.image = nil
        cell.article = self.articles[indexPath.row]
        
        if let thumbnailUrl = cell.article?.getThumbnailUrl() {
            UIImageView.getImageFrom(url: thumbnailUrl, indexPath: indexPath, callback: { (indexPathForLoadedImage, imageData) in
                DispatchQueue.main.async {
                    if cell.tag == indexPath.row {
                        cell.thumbnailImage.image = UIImage(data: imageData)
                    }
                }
            })
        } else {
            print("Could not get thumbnailURL")
        }
        
        
        return cell
    }
}

