//
//  ArticlesRouter.swift
//  CareerAppUIKit
//
//  Created by Amaryllis Baldrez on 04/04/25.
//

import Foundation
import SwiftUI

protocol ArticlesRoutingLogic {
    func routeToArticleDetail(id: Int)
    func goToSwiftUIView()
}

// MARK: - Router

class ArticlesRouter: NSObject, ArticlesRoutingLogic {
    weak var viewController: ArticlesViewController?
    
    func routeToArticleDetail(id: Int) {
        let articleDetailViewController = ArticleDetailFactory.build(id: id)
        viewController?.navigationController?.pushViewController(articleDetailViewController, animated: true)
    }
    
    func goToSwiftUIView() {
        let swiftUIView = SwiftUIExampleView()
        let hostingController = PBUIHostingController(view: swiftUIView)
        viewController?.navigationController?.pushViewController(hostingController, animated: true)
    }
}
