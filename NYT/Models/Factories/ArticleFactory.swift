//
//  ArticleFactory.swift
//  NYT
//
//  Created by Amber Spadafora on 7/5/18.
//  Copyright © 2018 Amber Spadafora. All rights reserved.
//

import Foundation

class ArticleFactory {
    
    func getApiKeyFromPlist() -> String? {
        if let path = Bundle.main.path(forResource: "ApiKey", ofType: "plist") {
            let apiKeyDict = NSDictionary(contentsOfFile: path)
            guard let apiKey = apiKeyDict?.object(forKey: "ApiKey") as? String else {
                print("\n \n getApiKeyFromPlist() failed when unwrapping apiKeyDict.object(forKey: \"ApiKey\") as? String")
                return nil
            }
            return apiKey
        }
        return nil
    }
    
    func getArticles(section: ArticleSection, callback: @escaping (Root) -> ()) {
        
        let apiKeyHeader = "API_Key"
        let NYTEndPoint = "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/\(section.rawValue)/30.json"
        guard let apiKey = getApiKeyFromPlist() else { return }
        
        NetworkManager.shared.startLoad(endpoint: NYTEndPoint, apiKey: apiKey, apiKeyHeader: apiKeyHeader) { (data) in
            let decoder = JSONDecoder()
            do {
                let root = try decoder.decode(Root.self, from: data)
                callback(root)
            }
            catch {
                print(error)
            }
        }
    }
}

enum ArticleSection: String {
    case Arts
    case Automobiles
    case Blogs
    case Books
    case BusinessDay = "Business%20Day"
    case Education
    case FashionStyle = "Fashion%20&%20Style"
    case Food
    case Health
    case JobMarket = "Job%20Market"
    case Magazine
    case membercenter = "member%20center"
    case Movies
    case Multimedia
    case NYTNow = "NYT%20Now"
    case Obituaries
    case Open
    case Opinion
    case PublicEditor = "Public%20Editor"
    case RealEstate = "Real%20Estate"
    case Science
    case Sports
    case Style
    case SundayReview = "Sunday%20Review"
    case TMagazine = "T%20Magazine"
    case Technology
    case TheUpshot = "The%20Upshot"
    case Theater
    case TimesInsider = "Times%20Insider"
    case TodaysPaper = "Today's%20Paper"
    case Travel
    case US = "U.S."
    case World
    case YourMoney = "Your%20Money"
    
    static var allCases: [ArticleSection] = [ArticleSection.Arts, ArticleSection.Automobiles, ArticleSection.Blogs, ArticleSection.Books, ArticleSection.BusinessDay, ArticleSection.Education, ArticleSection.FashionStyle, ArticleSection.Food, ArticleSection.Health, ArticleSection.JobMarket, ArticleSection.Magazine, ArticleSection.membercenter, ArticleSection.Movies, ArticleSection.Multimedia, ArticleSection.NYTNow, ArticleSection.Obituaries, ArticleSection.Opinion, ArticleSection.PublicEditor, ArticleSection.RealEstate, ArticleSection.Science, ArticleSection.Sports, ArticleSection.Style, ArticleSection.SundayReview, ArticleSection.TMagazine, ArticleSection.Technology, ArticleSection.TheUpshot, ArticleSection.Theater, ArticleSection.TimesInsider, ArticleSection.TodaysPaper, ArticleSection.Travel, ArticleSection.US, ArticleSection.World, ArticleSection.YourMoney]
}
