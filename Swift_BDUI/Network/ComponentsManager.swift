//
//  ComponentsManager.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import Foundation
import RxSwift

class HomePageController: ObservableObject {
    
    @Published
    var uiComponents: [UIComponent] = []
    
    let disposableBag = DisposeBag()
    
    let repository: TmdbRepository = TmDbRepositoryImpl()
    
    func loadPage() {
        uiComponents = []
        Observable
            .zip(repository.getCountryBreakingNews(), repository.getNewsBySource(source: "wired"), repository.getNewsByKeyword(keyword: "soccer"),
                 resultSelector: { (countryNews, categoryNews, sectorNews) in
                var components: [UIComponent] = []
                
                components.append(HeadScrollNewsComponent(result: NewsResult(articles: countryNews.articles, title: "U.S Business World")))
                components.append(TopicHeadlinesNewsComponent(result: NewsResult(articles: categoryNews.articles, title: "Wired")))
                components.append(SectorNewsComponent(result: NewsResult(articles: sectorNews.articles, title: "Soccer")))

                return components
            })
            .subscribe(
                onNext: { [weak self] components in
                    self?.uiComponents = components
                },
                onError: { error in
                    debugPrint(error)
                }
            )
            .disposed(by: disposableBag)
    }
    
    
    // Removes the subscriptin component
    func removeComponent(id: String) {
        uiComponents = uiComponents.filter() { component in
            component.uniqueId != id
        }
    }
}
