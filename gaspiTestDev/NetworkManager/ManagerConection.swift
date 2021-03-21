//
//  ManagerConection.swift
//  gaspiTestDev
//
//  Created by Brian Baragar on 20/03/21.
//

import Foundation
import RxSwift
class ManagerConection {
    
    func searchProduct(product: String) -> Observable<[Product]>{
        Observable.create { observer  in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: API.endPoint.search+product)!)
            request.httpMethod = "GET"
            request.addValue(API.apikey, forHTTPHeaderField: "X-IBM-Client-Id")
            session.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil, let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200{
                    do {
                        let decoder = JSONDecoder()
                        let searchResult = try decoder.decode(ResponseEccomerce.self, from: data)
                        observer.onNext(searchResult.items)
                    } catch let error{
                        observer.onError(error)
                        print(error.localizedDescription)
                    }
                }
                else if response.statusCode == 401 {
                    print("Error 401")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
}
