//
//  EztDynamicIsland.swift
//  WallpaperIOS
//
//  Created by Duc on 16/10/2023.
//

import SwiftUI
import SDWebImageSwiftUI

struct EztDynamicIsland: View {
    @StateObject var newestVM : DynamicIslandViewModel = .init(sort : .NEW, sortByTop: .TOP_MONTH)
    @StateObject var popularVM : DynamicIslandViewModel = .init(sort : .POPULAR, sortByTop: .TOP_MONTH)
    
    @EnvironmentObject var wallpaperCatelogVM : WallpaperCatalogViewModel
    @EnvironmentObject var rewardAd : RewardAd
    @EnvironmentObject var interAd : InterstitialAdLoader
    @EnvironmentObject var store : MyStore
    
    @Environment(\.presentationMode) var presentationMode
    @State var adStatus : AdStatus = .loading
    var body: some View {
        VStack(spacing : 0){
            HStack(spacing : 0){
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image("back")
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .foregroundColor(.white)
                        .frame(width: 24, height: 24)
                        .containerShape(Rectangle())
                })
                Text("Dynamic Island")
                    .foregroundColor(.white)
                    .mfont(22, .bold)
                    .frame(maxWidth: .infinity).padding(.trailing, 18)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
                .frame(height: 44)
                .padding(.horizontal, 20)
            
            ScrollView(.vertical, showsIndicators: false){
                LazyVStack(spacing : 0){
                    
                    NavigationLink(destination: {
                        EztDynamicIslslandCateView()
                            .environmentObject(wallpaperCatelogVM)
                            .environmentObject(rewardAd)
                            .environmentObject(interAd)
                            .environmentObject(store)
                    }, label: {
                        
                        HStack(spacing : 0){
                            Text("Dynamic Island Category")
                                .mfont(20, .bold)
                              .foregroundColor(.white)
                              .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 1)
                              .padding(.leading, 16)
                            
                            Spacer()
                            
                            Image("a.r")
                                .resizable()
                                .renderingMode(.template)
                                .foregroundColor(.white)
                                .scaledToFit()
                                .shadow(color: .black.opacity(0.7), radius: 2, x: 0, y: 1)
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 16)
                            
                        }.frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(
                                Image("dynamic_category")
                                    .resizable()
                            )
                        
                    })
                    .cornerRadius(16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 24)
                    .padding(.top, 8)
                    
                    
                    Newset().padding(.bottom, 16)
                    Popular().padding(.bottom, 16)
                    
                  
                    
                    Spacer()
                        .frame(height: 152)
                    
                }
                
               
                
            }
            .refreshable {
            
             
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .addBackground()
            .edgesIgnoringSafeArea(.bottom)
            .overlay(
                ZStack{
                    if store.allowShowBanner(){
                        BannerAdViewMain( adStatus: $adStatus)
                            
                    }
                }
                
                , alignment: .bottom
            )
            .onAppear{
                if !store.isPro(){
                    interAd.showAd(onCommit: {})
                }
            }
        
        
        

    }
}

extension EztDynamicIsland {
    func Newset() -> some View{
        VStack(spacing : 0){
            HStack(spacing : 0){
                Text("Newest".toLocalize())
                    .mfont(20, .bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                   

                Spacer()
               NavigationLink(destination: {
                   DynamicView()
                       .environmentObject(newestVM)
                       .environmentObject(store)
                       .environmentObject(rewardAd)
                       .environmentObject(interAd)
                }, label: {
                    HStack(spacing : 0){
                        Text("See All".toLocalize())
                            .mfont(11, .regular)
                            .foregroundColor(.white)
                        Image("arrow.right")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 18, height: 18, alignment: .center)
                    }
                })
                
                
            }.frame(height: 36)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            
            
            
            ZStack{
                if newestVM.wallpapers.isEmpty{
                    PlaceHolderListLoad()
                }else{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing : 8){
                            NavigationLink(destination: {
                                SpWLDetailView(index: 0)
                                    .environmentObject(newestVM as SpViewModel)
                                    .environmentObject(store)
                                    .environmentObject(rewardAd)
                                    .environmentObject(interAd)
                            }, label: {
                                WebImage(url: URL(string: newestVM.wallpapers.first?.path.first?.path.small ?? ""))
                                    .resizable()
                                    .placeholder {
                                        placeHolderImage()
                                    }
                                    .scaledToFill()
                                    .frame(width: 160, height: 320)
                                    .clipped()
                                    .overlay(
                                        Image("dynamic")
                                            .resizable()
                                            .frame(width: 160, height: 320)
                                    )
                                    .cornerRadius(8)
                                    .showCrownIfNeeded(!store.isPro() && newestVM.wallpapers.first?.contentType == 1)
                            })
                            
                            
                            
                            LazyHGrid(rows: [GridItem.init(spacing : 8), GridItem.init()], spacing: 8, content: {
                                ForEach(1..<15, content: {
                                    i in
                                    let wallpaper = newestVM.wallpapers[i]
                                    
                                    let string = wallpaper.path.first?.path.small ?? ""
                                    
                                    NavigationLink(destination: {
                                        SpWLDetailView(index: i)
                                            .environmentObject(newestVM as SpViewModel)
                                            .environmentObject(store)
                                            .environmentObject(rewardAd)
                                            .environmentObject(interAd)
                                    }, label: {
                                        WebImage(url: URL(string: string))
                                            .resizable()
                                            .placeholder {
                                                placeHolderImage()
                                            }
                                            .scaledToFill()
                                            .frame(width: 78, height: 156)
                                            .clipped()
                                            .overlay(
                                                Image("dynamic")
                                                    .resizable()
                                                    .frame(width: 78, height: 156)
                                            )
                                            .cornerRadius(8)
                                            .showCrownIfNeeded(!store.isPro() && wallpaper.contentType == 1)
                                    })
                                    
                                    
                                    
                                    
                                    
                                })
                            })
                        }
                        
                        
                    }
                    .frame(height: 320)
                    .padding(.horizontal, 16)
                }

            }.frame(height : 320)
            
            
            
        }
       
    }
    
    
    func Popular() -> some View{
        VStack(spacing : 0){
            HStack(spacing : 0){
                Image("sparkle")
                    .resizable()
                    .frame(width: 20, height: 20)
                
                Text("Popular".toLocalize())
                    .mfont(20, .bold)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading, 8)
                   
                Spacer()
                
                
            }.frame(height: 36)
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
            
            
            
            LazyVGrid(columns: [GridItem.init(spacing: 8),GridItem.init()], spacing: 8 ){
                
                if !popularVM.wallpapers.isEmpty {
                    ForEach(0..<popularVM.wallpapers.count, id: \.self){
                        i in
                        let  wallpaper = popularVM.wallpapers[i]
                        let string : String = wallpaper.path.first?.path.small ?? ""
                        
                        NavigationLink(destination: {
                            SpWLDetailView(index: i)
                                .environmentObject(popularVM as SpViewModel)
                                .environmentObject(store)
                                .environmentObject(interAd)
                               
                                .environmentObject(rewardAd)
                        }, label: {
                            WebImage(url: URL(string: string))
                                .onSuccess { image, data, cacheType in
                                }
                                .resizable()
                                .placeholder {
                                    placeHolderImage()
                                        .frame(width: AppConfig.width_1, height: AppConfig.height_1)
                                }
                                .scaledToFill()
                                .frame(width: AppConfig.width_1, height: AppConfig.height_1)
                                .cornerRadius(8)
                                .overlay(
                                    Image("dynamic")
                                        .resizable()
                                        .cornerRadius(8)
                                )
                                .showCrownIfNeeded(!store.isPro() && wallpaper.contentType == 1)

                        })
                        .onAppear(perform: {
                            if i == ( popularVM.wallpapers.count - 6 ){
                                popularVM.getWallpapers()
                            }
                        })
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 100, trailing: 0))
            .padding(.horizontal, 16)
              
            
            
        }
       
    }
    
}

#Preview {
    EztMainView()
}
