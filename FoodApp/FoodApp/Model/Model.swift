//
//  Model.swift
//  FoodApp
//
//  Created by SnehaAgrawal on 14/01/23.
//

import Foundation

struct FoodDataModel : Identifiable, Codable{
    let id = UUID()
    let status : Int?
    let data : DataModel?
    
}

struct DataModel:Identifiable, Codable{
    let id = UUID()
    let banners : [BannerModel]
    let food_categories : [FoodCategoryModel]
    let number_of_active_vouchers : Int?
    let offer_collections : [OfferCollections]
    let restaurant_collections : [RestaurantCollectionModel]
}

struct BannerModel : Identifiable, Codable, Hashable {
    let id : Int
    let image_url : String?
}

struct RestaurantCollectionModel : Identifiable, Codable, Hashable{
    let id = UUID()
    let name: String?
    let priority: Int?
    let restaurants : [RestaurantsModel]
}

struct RestaurantsModel : Identifiable, Codable, Hashable{
    let id : Int?
    let name : String?
    let display_distance : String?
    let rating : Double?
    let image_url : String?
    var offers : [OffersModel?] = []
    let additional_offer : String?
}

struct FoodCategoryModel : Identifiable, Codable{
    let id : Int?
    let name : String?
    let icon : String?
}

struct OfferCollections : Identifiable, Codable, Hashable{
    let id : Int?
    let name : String?
    let textcolor : String?
    let background : String?
    let image : String?
}



struct OffersModel : Identifiable, Codable, Hashable{
    let id : Int?
    let name : String?
    let background : String?
    let textcolor : String?
}
