//
//  RequestManager.swift
//  KGI
//
//  Created by mrfour on 3/2/16.
//  Copyright © 2016 mrfour. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD

/// The Singleton that manages all requests
let requestManager = RequestManager.sharedInstance

enum ServerEnvironment {
    case test
    case production

    // Github API v3
    // 获取repo中某文件信息（不包括内容）。https://api.github.com/repos/用户名/gists/contents/文件路径。文件路径是文件的完整路径，区分大小写。只会返回文件基本信息。
    // 获取某文件的原始内容（Raw）。1. 通过上面的文件信息中提取download_url这条链接，就能获取它的原始内容了。2. 或者直接访问：https://raw.githubusercontent.com/用户名/仓库名/分支名/文件路径
    var domainString: String {
        switch self {
        case .test:
            var keys: NSDictionary?
            if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }

            let testApiKeyDomain = keys?["ApiKeyDomainTest"] as? String ?? "https://raw.githubusercontent.com/KayHsiao/Activity0822"
            log.debug("testApiKeyDomain: \(testApiKeyDomain)")

            return testApiKeyDomain

        case .production:
            var keys: NSDictionary?
            if let path = Bundle.main.path(forResource: "Keys", ofType: "plist") {
                keys = NSDictionary(contentsOfFile: path)
            }

            let productionApiKeyDomain = keys?["ApiKeyDomainProduction"] as? String ?? "https://raw.githubusercontent.com/mbywczgxy/0610"
            log.debug("productionApiKeyDomain: \(productionApiKeyDomain)")

            return productionApiKeyDomain
        }
    }
}

struct AppAPI {
    static func stripURL(_ url: String) -> String {
        return requestManager.serverEnviroment.domainString + url
    }

    static let activitys   = stripURL("/master/Activities.json")
    static let brand = stripURL("/master/Brand.json")
    static let coffee = stripURL("/master/Coffee.json")
    static let decentralization = stripURL("/master/Decentralization.json")
    static let eshopping = stripURL("/master/Eshopping.json")
    static let fairness = stripURL("/master/Fairness.json")

    static let events = stripURL("/master/Events.json")
    static let groups = stripURL("/master/Groups.json")
}

class RequestManager {

    static let sharedInstance = RequestManager(.test)

    // MARK: Request Configuraion

    var serverEnviroment: ServerEnvironment

    private init(_ environment: ServerEnvironment) {
        self.serverEnviroment = environment
    }
    
    // MARK: Variables
    
    var currentRequest: Request?

    // MARK: Private Methods
    
    func baseRequest(_ method: Alamofire.HTTPMethod, url: String, parameters: [String: Any]? = nil, needToken: Bool = true, callback: @escaping (_ result :JSON) -> ()) {
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]

        SVProgressHUD.show()

        currentRequest = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response -> Void in

                switch response.result {
                case .success:

                    SVProgressHUD.dismiss(withDelay: 0.5)

                    if let value = response.result.value {
//                        log.info(value)
                        let json = JSON(value)

                        callback(json)
                    }
                case .failure(let error):

                    SVProgressHUD.dismiss()


//                    let currentVC = appDelegate.findCurrentViewController()
//                    let alertVC = AlertViewController.instantiateFromStoryboard()
//                    alertVC.titleSting = ""
//                    alertVC.messageString = error.localizedDescription
//                    alertVC.confirmString = "確定"
//                    currentVC.present(alertVC, animated: true, completion: nil)
                    log.debug(error.localizedDescription)
                    appDelegate.presentAlertView("網路錯誤", message: nil)
                    return
                }
        }
    }

}

// MARK: - Public Methods

extension RequestManager {
    
    // MARK: Fuction
    
    func cancelRequest() {
        guard let currentRequest = currentRequest else { return }

        log.debug("Canceled current request!!")
        currentRequest.cancel()
    }
    
    // MARK: API

    /// UITabBar 顯示畫面數
    func getActivitys(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.activitys, parameters: nil, needToken: false, callback: success)
    }

    /// viewController3
    func getBrand(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.brand, parameters: nil, needToken: false, callback: success)
    }

    /// viewController4
    func getCoffee(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.coffee, parameters: nil, needToken: false, callback: success)
    }

    /// viewController5
    func getDecentralization(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.decentralization, parameters: nil, needToken: false, callback: success)
    }

    /// viewController6
    func getEshopping(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.eshopping, parameters: nil, needToken: false, callback: success)
    }

    ///  viewController7
    func getFairness(success: @escaping (_ data: JSON) -> Void) {
        baseRequest(.get, url: AppAPI.fairness, parameters: nil, needToken: false, callback: success)
    }

    func getEvents(success: @escaping (_ events: [Event]) -> Void) {
        baseRequest(.get, url: AppAPI.events, parameters: nil, needToken: false) { (json) in
            let eventArray = json["events"].arrayValue
            log.info("eventArray count is \(eventArray.count)")

            var events: [Event] = []

            for key in eventArray {
                let event = Event(id: key["id"].stringValue,
                                  name: key["name"].stringValue,
                                  localDate: key["local_date"].stringValue,
                                  localTime: key["local_time"].stringValue,
                                  waitlistCount: key["waitlist_count"].intValue,
                                  yesRsvpCount: key["yes_rsvp_count"].intValue,
                                  venueName: key["venue"]["name"].stringValue,
                                  groupName: key["group"]["name"].stringValue,
                                  link: key["link"].stringValue,
                                  description: key["description"].stringValue,
                                  visibility: key["visibility"].stringValue,
                                  memberPayFee: key["member_pay_fee"].boolValue)
                events.append(event)
            }

            success(events)
        }
    }

    func getGroups(success: @escaping (_ groups: [Group]) -> Void) {
        baseRequest(.get, url: AppAPI.groups, parameters: nil, needToken: false) { (json) in
            let groupsArray = json["groups"].arrayValue
            log.info("groupsArray count is \(groupsArray.count)")

            var groups: [Group] = []

            for key in groupsArray {
                let group = Group(id: key["id"].intValue,
                                  name: key["name"].stringValue,
                                  categoryName: key["categoryName"].stringValue,
                                  attendeesCount: key["attendeesCount"].intValue,
                                  keyPhoto: key["keyPhoto"].stringValue)
                groups.append(group)
            }

            success(groups)
        }
    }

}
