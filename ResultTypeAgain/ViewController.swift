//
//  ViewController.swift
//  ResultTypeAgain
//
//  Created by buckley johnson on 11/8/19.
//  Copyright © 2019 buckley johnson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    struct Course: Decodable {
        let id: Int
        let name: String
        let imageUrl: String
        let number_of_lessons: Int
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCoursesJSON { (results) in
            switch results {
            case .success(let courses):
                courses.forEach({ (course) in
                    print(course.name)
                })
            case .failure(let err):
                print("failed", err)
            }
            
        }

    }
    
    fileprivate func fetchCoursesJSON(completion: @escaping (Result<[Course], Error>) -> ()){
        let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with:url) {(data, resp, err) in
            if let err = err {
                completion(.failure(err))
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data!)
                print(courses)
                completion(.success(courses))
            }catch let jsonError{
                completion(.failure(jsonError))
            }
         
            
        }.resume()
    }
}

