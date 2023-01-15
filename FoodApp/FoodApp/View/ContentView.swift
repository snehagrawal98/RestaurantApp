//
//  ContentView.swift
//  FoodApp
//
//  Created by SnehaAgrawal on 14/01/23.
//

import SwiftUI

struct TabViewPage:View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection:$selectedTab) {
            ContentView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }.tag(1)
            
            ContentView()
                .tabItem {
                    Image(systemName: "case")
                    Text("Order")
                }.tag(2)
            
            ContentView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Account")
                }.tag(3)
        }.onAppear(){
            UIToolbar.appearance().barTintColor = .lightGray
        }
        .accentColor(.red)
    }
}

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Header()
                ScrollView{
                    BannerView()
                    FoodCategories()
                    Voucher().background(Color.orange.opacity(0.2))
                    CollectionData()
                    FoodRecommendations()
                    Spacer()
                }
            }.ignoresSafeArea()
                .padding()
        }
    }
}

struct Header: View {
    @State var text = ""
    var body: some View {
        VStack{
            HStack(alignment:.center){
                VStack{
                    ZStack{
                        
                        Image(systemName: "drop").font(.system(size: 25)).frame(width: 40 , height: 25).foregroundColor(.white).rotationEffect(Angle(degrees: 180))
                        Image(systemName: "drop").font(.system(size: 10)).frame(width: 40 , height: 25).foregroundColor(.white).rotationEffect(Angle(degrees: 180))
                    }
                    Image(systemName: "line.diagonal").font(.title).frame(width: 20 ).foregroundColor(.white).rotationEffect(Angle(degrees: 45)).offset(y:-10)
                    
                }.offset(y:10)
                Text("Home").foregroundColor(.white).font(.system(size: 20, weight: .medium))
                Spacer()
            }
            
            TextField("Search", text: $text).frame(height: 40).foregroundColor(.white).frame(minWidth: 0, maxWidth: .infinity).background(Color.gray.opacity(0.4))
            
        }.padding(20).background(Color.red)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabViewPage()
    }
}

struct BannerView : View {
    
    @State var banner : [BannerModel] = []
    
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(banner) { b in
                    AsyncImage(url: URL(string:   "\(b.image_url!)") ,
                               content: { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 400, maxHeight: 200)
                    },
                               placeholder: {
                        ProgressView()
                    })
                }
                
            }
        }.onAppear(){
            ApiCall().getBannerData { banner in
                self.banner = banner
            }
        }
    }
}

struct FoodCategories:View {
    @State var category : [FoodCategoryModel] = []
    var body: some View {
        ScrollView(.horizontal){
            HStack{
                ForEach(category) { c in
                    VStack{
                        AsyncImage(url: URL(string:   "\(c.icon ?? "")") ,
                                   content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 80, maxHeight: 80).cornerRadius(40)
                        },
                                   placeholder: {
                            ProgressView()
                        })
                        Text("\(c.name ?? "")").foregroundColor(.black).font(.system(size: 15))
                    }
                }
                
            }
        }.onAppear(){
            ApiCall().getCategoryData { category in
                self.category = category
            }
        }
    }
}

struct Voucher : View {
    @State var voucher : DataModel?
    var body : some View {
        HStack{
            Image(systemName: "gift").foregroundColor(.orange).frame(width: 10, height: 10)
            Text("You have \(voucher?.number_of_active_vouchers ?? 0) vouchers here").foregroundColor(.orange).font(.system(size: 18, weight: .medium))
            Spacer()
            Image(systemName: "chevron.forward").foregroundColor(.orange).frame(width: 10, height: 10)
        }.padding(5).onAppear(){
            ApiCall().getVoucherData { voucher in
                self.voucher = voucher
            }
        }
    }
}


struct CollectionData: View{
    @State var collection : [OfferCollections] = []
    var layout = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View{
        VStack(alignment: .leading){
            Text("Collections").foregroundColor(.black).font(.system(size: 22, weight: .bold))
            LazyHGrid(rows: layout) {
                CollectionData1(collection1: collection)
            }
            
        }.onAppear(){
            ApiCall().getCollectionData { collection in
                self.collection = collection
            }
        }
    }
}



struct CollectionData1:View {
    var collection1 : [OfferCollections]
    var body: some View {
        ForEach(collection1, id:\.self){ c in
            
            HStack(alignment: .center){
                AsyncImage(url: URL(string:   "\(c.image ?? "")") ,
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxHeight: 80)
                },
                           placeholder: {
                    ProgressView()
                })
                Text("\(c.name?.uppercased() ?? "")").foregroundColor(.black).font(.system(size: 18, weight: .bold))
            }.frame(width: 200, height: 200)
        }
        
    }
}




struct FoodRecommendations:View {
    @State var restaurant1 : [RestaurantCollectionModel] = []
    @State var recommend : [RestaurantsModel] = []
    var body: some View {
        VStack{
            ForEach(restaurant1.reversed(), id: \.self) { restaurant in
                
                HStack{
                    Text("\(restaurant.name ?? "")").foregroundColor(.black).font(.system(size: 22, weight: .bold))
                    Spacer()
                    Text("View All").foregroundColor(.gray).font(.system(size: 18, weight: .regular))
                }
                if restaurant.name == "Sale up to 50%"{
                    RestaurantData(index:0 ,image: restaurant1[0].restaurants[0].image_url ?? "", restaurant:restaurant1 ,recommend: restaurant1[0].restaurants)
                } else if restaurant.name == "Recommended for you" {
                    RestaurantData(index:1 ,image: restaurant1[1].restaurants[0].image_url ?? "", restaurant:restaurant1 ,recommend: restaurant1[0].restaurants)
                }
            }
        }.onAppear(){
            ApiCall().getRecommendedData { restaurant in
                self.recommend = restaurant
            }
            ApiCall().getRestaurantCollectionData { restaurant in
                self.restaurant1 = restaurant
                
            }
            
        }
        
    }
}


struct RestaurantData : View {
    var index : Int
    var image : String
    var restaurant : [RestaurantCollectionModel]
    var recommend : [RestaurantsModel]
    @State var offer : [OffersModel?] = []
    var body : some View {
        ScrollView(.horizontal){
            HStack(alignment: .top, spacing: 10){
                ForEach(restaurant[index].restaurants, id: \.self) { r in
                    VStack(alignment: .leading, spacing: 3){
                        ZStack{
                            AsyncImage(url: URL(string:   "\(r.image_url ?? "")") ,
                                       content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: 200, maxHeight: 150)
                            },
                                       placeholder: {
                                Image("download").resizable().aspectRatio(contentMode: .fit).frame(width: 150, height: 150)
                            }).overlay {
                                ZStack{
                                    Rectangle().fill(r.additional_offer != nil ?  Color.green: Color.clear).frame(width: 80, height: 25).cornerRadius(radius: 20, corners: [.topRight, .bottomRight])
                                    Text("\(r.additional_offer ?? "")").padding(.horizontal, 30).foregroundColor(.white).font(.system(size: 17)).padding(.vertical,3)
                                }.frame(width: 300, height: 100).offset(x:-35, y: -50)
                            }
                        }
                        
                        Text("\(r.name ?? "")").foregroundColor(.black).font(.system(size: 15))
                        
                        HStack(spacing: 10){
                            Text("\(r.display_distance ?? "")").foregroundColor(.gray).font(.system(size: 15))
                            Image(systemName: "star.fill").frame(width: 10, height: 10).foregroundColor(.yellow)
                            Text("\(String(r.rating ?? 0))").foregroundColor(.gray).font(.system(size: 15))
                        }
                        HStack(alignment: .top){
                            ForEach(r.offers, id: \.self){ o in
                                Text("\(o?.name ?? "")").font(.system(size: 12, weight: .bold)).foregroundColor(Color(hex: o?.textcolor ?? "" ) ?? .black).padding(.horizontal,6).padding(.vertical,4).background(Color(hex: o?.background ?? "" )?.opacity(0.3) ?? .white).cornerRadius(5)
                            }
                            
                        }
                    }
                }
                
            }
        }
    }
}

