//
//  BaserServer.swift
//  Swift_BDUI
//
//  Created by Mikhail Kolkov on 1/27/25.
//

import Foundation
import Alamofire
import RxSwift

class BaseRepository {
    func createRequest<T: Codable>(url: String) -> Observable<T> {

        let observable = Observable<T>.create { observer -> Disposable in

            AF.request(url)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            observer.onError(response.error ?? AppError.runtimeError("random message"))
                            return
                        }
                        do {
                            let decoder = try JSONDecoder().decode(T.self, from: data)
                            observer.onNext(decoder)
                        } catch {
                            observer.onError(error)
                        }
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        }
        observable
            .observe(on: MainScheduler.instance)
        
        return observable
    }
}

enum AppError: Error {
    case runtimeError(String)
}

