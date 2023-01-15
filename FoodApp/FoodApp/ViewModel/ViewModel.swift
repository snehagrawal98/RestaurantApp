//
//  ViewModel.swift
//  FoodApp
//
//  Created by SnehaAgrawal on 14/01/23.
//

import Foundation

class ApiCall {
    
    let url = URL(string: "https://mocki.io/v1/0c5d380f-972a-44c9-bd11-ca5a2f154019")
    
    //Api call function to fetch the json response
    func getBannerData(completion:@escaping ([BannerModel]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let banner = data?.data?.banners
            print(banner!)
            DispatchQueue.main.async {
                completion(banner!)
            }
        }
        .resume()
    }
    
    
    func getCategoryData(completion:@escaping ([FoodCategoryModel]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let category = data?.data?.food_categories
            print(category!)
            DispatchQueue.main.async {
                completion(category!)
            }
        }
        .resume()
    }
    
    func getCollectionData(completion:@escaping ([OfferCollections]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let collection = data?.data?.offer_collections
            print(collection!)
            DispatchQueue.main.async {
                completion(collection!)
            }
        }.resume()
    }
    
    func getVoucherData(completion:@escaping (DataModel?) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let collection = data?.data
            print(collection!)
            DispatchQueue.main.async {
                completion(collection!)
            }
        }.resume()
    }
    
    func getRestaurantCollectionData(completion:@escaping ([RestaurantCollectionModel]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let collection = data?.data?.restaurant_collections
            print(collection!)
            DispatchQueue.main.async {
                completion(collection!)
            }
        }.resume()
    }
    
    func getRecommendedData(completion:@escaping ([RestaurantsModel]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let collection = data?.data?.restaurant_collections[0].restaurants
            print(collection!)
            DispatchQueue.main.async {
                completion(collection!)
            }
        }.resume()
    }
    
    func getOfferData(completion:@escaping ([OffersModel?]) -> ()) {
        URLSession.shared.dataTask(with: url!) { (data, _, _) in
            let data = try? JSONDecoder().decode(FoodDataModel.self, from: data!)
            let offer = data?.data?.restaurant_collections[0].restaurants[0].offers
            print(offer ?? [])
            DispatchQueue.main.async {
                completion(offer ?? [])
            }
        }.resume()
    }
    
}

    

