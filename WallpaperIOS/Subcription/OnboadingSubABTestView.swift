//
//  OnboadingSubABTestView.swift
//  WallpaperIOS
//
//  Created by Duc on 09/05/2024.
//

import SwiftUI
import AVKit

//struct UserFeedback {
//    let title : String
//    let by : String
//    let content : String
//}
//
//struct ScreenUserFeedbackView: View {
//    let listFeedback : [UserFeedback] = [
//        UserFeedback(title: "Best Wallpaper App 👍", by: "by The Goat – February 23, 2024", content: "This app truly stands out. It’s the best AI art app I’ve come across. The premium features are worth every penny!!! 👍👍"),
//        UserFeedback(title: "A Hidden Gem!", by: "by Iren06r – March 2, 2024", content: "I’ve used PLENTY of different AI-generated photo apps, and this one is by far the best I’ve used. I even purchased the yearly bundle, which I never do for apps. Keep up the great work!"),
//        UserFeedback(title: "Masterpiece Maker", by: "by himjimjoe – March 8, 2024", content: "Worth every penny of subscription. It has great AI models and a lot of styles to go with. I needed an app to create inspiration for my graphic design work and this is amazing!"),
//        UserFeedback(title: "Amazing App!", by: "by grimtatted – March 11, 2024", content: "This app is the most talented one I have found. I got premium."),
//        UserFeedback(title: "My Favorite App", by: "by Ezanoime – February 7, 2024", content: "I’m blown away by the quality of art generated by this app. The attention to detail and the seamless blending of styles make it a true masterpiece creator. Kudos to the developers!"),
//        UserFeedback(title: "Totally Love It!", by: "by DapperMongoose – February 14, 2024", content: "This app is a revolutionary playground for art enthusiasts!"),
//        UserFeedback(title: "Best AI Generator There", by: "by Mysuni – February 14, 2024", content: "This app truly stands out. It’s the best AI art app I’ve come across. The premium features are worth every penny!!! 👍👍"),
//    ]
//    
//    
//    
//    var body: some View {
//        ScrollView(.vertical, showsIndicators: false){
//            LazyVStack(spacing : 10){
//                
//                ForEach(listFeedback, id: \.title){
//                    feedback in
//                    VStack(spacing : 0){
//                        HStack(spacing : 0){
//                            Text(feedback.title)
//                                .mfont(17, .bold)
//                                .foregroundColor(.white)
//                            Spacer()
//                            
//                            Image("star_for_userrate")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 80, height: 12, alignment: .center)
//                        }
//                        Text("by The Goat – February 23, 2024")
//                            .mfont(13, .regular)
//                            .foregroundColor(.white)
//                            .opacity(0.7)
//                            .frame(maxWidth: .infinity, alignment : .leading)
//                        Text("This app truly stands out. It’s the best AI art app I’ve come across. The premium features are worth every penny!!! 👍👍")
//                            .mfont(13, .regular, line : 5)
//                            .foregroundColor(.white)
//                            .frame(maxWidth: .infinity , alignment: .topLeading)
//                            .padding(.top, 8)
//                    }.frame(maxWidth: .infinity)
//                        .padding(EdgeInsets(top: 12, leading: 16, bottom: 16, trailing: 16))
//                        .background(Color.white.opacity(0.2))
//                        .cornerRadius(16)
//                        .padding(.horizontal, 8)
//                    
//                }
//            }.padding(EdgeInsets(top: 16, leading: 0, bottom: 200, trailing: 0))
//        }.frame(maxWidth: .infinity, maxHeight: .infinity)
//            .background(
//                ZStack{
//                    Image("BGIMG")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                        .ignoresSafeArea()
//                    
//                    VisualEffectView(effect: UIBlurEffect(style: .dark))
//                    
//                }
//            )
//    }
//}


struct ScreenUserFeedbackView : View {
    var body: some View {
        ZStack(alignment: .top){
            VisualEffectView(effect: UIBlurEffect(style: .dark))
          
                ResizableLottieView(filename: "userrate_hori")
                    .padding(.horizontal, 8)
       

        }
        .frame(maxWidth: .infinity, maxHeight : .infinity)
        .ignoresSafeArea()
        .addBackground()
    }
}

struct OnboadingSubFreeTrialView : View {
    
    @State var player : AVPlayer?
    
    let list_2 : [String] = [
        "Unlimited Premium Wallpapers",
        "Unlimited Premium Widgets",
        "Unlimited AI-Generate",
        "Ad-free experience"
    ]
    
    @Binding var isBuyYear : Bool
    @Binding var enableFreeTrial : Bool
    @EnvironmentObject var storeVM : MyStore
 
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            
       
            VStack(spacing : 0){
             
                ResizableLottieView(filename: "star")
                    .frame(width: 64, height: 64)
                    .padding(.top, 114)
                   
                
                Text("Wallive Premium")
                    .mfont(24, .bold)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 1, green: 0.87, blue: 0.19))
                
                Text("Give your Phone A Cool Makeover")
                    .mfont(17, .bold)
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .padding(.top, 4)
                
                OptForProUser()
                    .padding(.top, 24)
                
                
                HStack(spacing : 0){
                    Text("Free Trial Enable")
                      .font(
                        Font.custom("SVN-Avo", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(.white.opacity(enableFreeTrial ? 1.0 : 0.7))
                      .padding(.leading, 20)
                    Spacer()
                    Image(enableFreeTrial ? "on" : "uncheck")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 44, height: 24, alignment: .center)
                        .opacity( enableFreeTrial ? 1.0 : 0.7)
                        .contentShape(Rectangle())
                        .onTapGesture{
                            if enableFreeTrial {
                                enableFreeTrial = false
                            }else {
                                enableFreeTrial = true
                                isBuyYear = false
                            }
                          
                        }
                        .padding(.trailing, 16)
                    
                    
                }.frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background{
                        LinearGradient(
                        stops: [
                        Gradient.Stop(color: Color(red: 0.15, green: 0.7, blue: 1).opacity(0.2), location: 0.00),
                        Gradient.Stop(color: Color(red: 0.82, green: 0.23, blue: 0.89).opacity(0.2), location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0, y: 1),
                        endPoint: UnitPoint(x: 1, y: 0)
                        )
                    }
                    .cornerRadius(12)
                    .padding(.top, 32)
                    .padding(.horizontal, 16)
                
                if let yearProduct = storeVM.getYearOriginUsingProduct(),
                   let weekProduct = storeVM.weekProductNotSale{
                    
                    
                    
                    HStack(spacing : 0){
                        Image(!isBuyYear ? "sub_check" : "sub_uncheck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 20)
                        
                        VStack( spacing: 2){
                            if !enableFreeTrial{
                                Text("Weekly")
                                    .mfont(16, .bold)
                                    .frame(maxWidth: .infinity, alignment : .leading)
                                Text("\(weekProduct.displayPrice)/week")
                                    .mfont(12, .regular)
                                    .frame(maxWidth: .infinity, alignment : .leading)
                            }else{
                                Text("3-Day Free Trial")
                                  .font(
                                    Font.custom("SVN-Avo", size: 16)
                                      .weight(.bold)
                                  )
                                  
                            }
                        }.padding(.leading, 16)
                        
                        Spacer()
                        
                        if enableFreeTrial{
                            Text("then \(weekProduct.displayPrice)\nper week")
                                .mfont(15, .regular, line : 2)
                                .padding(.trailing, 16)
                                .multilineTextAlignment(.trailing)
                                
                        }else{
                            Text("\(weekProduct.displayPrice)/week")
                                .mfont(15, .regular)
                                .padding(.trailing, 16)
                        }
                       
                         
                        
                    }.frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .foregroundColor(.white.opacity(!isBuyYear ? 1.0 : 0.7))
                        .background{
                            LinearGradient(
                            stops: [
                            Gradient.Stop(color: Color(red: 0.15, green: 0.7, blue: 1).opacity(0.2), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.82, green: 0.23, blue: 0.89).opacity(0.2), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 1),
                            endPoint: UnitPoint(x: 1, y: 0)
                            )
                        }
                        .cornerRadius(12)
                        .overlay{
                            if !isBuyYear{
                                RoundedRectangle(cornerRadius: 12)
                                .inset(by: 1)
                                .stroke(Color(red: 1, green: 0.87, blue: 0.19), lineWidth: 2)
                            }

                        }
                        .contentShape(Rectangle())
                        .onTapGesture(perform: {
                            self.isBuyYear = false
                        })
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                    
                    
                    HStack(spacing : 0){
                        Image(isBuyYear ? "sub_check" : "sub_uncheck")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                            .padding(.leading, 20)
                        
                        VStack( spacing: 2){
                            Text("Annuaally")
                                .mfont(16, .bold)
                                .frame(maxWidth: .infinity, alignment : .leading)
                            Text("\(yearProduct.displayPrice)/year")
                                .mfont(12, .regular)
                                .frame(maxWidth: .infinity, alignment : .leading)
                            
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        Text("\(getDisplayPrice(price: yearProduct.price , chia: 51 , displayPrice: yearProduct.displayPrice ))/week")
                            .mfont(15, .regular)
                            .padding(.trailing, 16)
                         
                        
                    }.frame(maxWidth: .infinity)
                        .frame(height: 64)
                        .foregroundColor(.white.opacity(isBuyYear ? 1.0 : 0.7))
                        .background{
                            LinearGradient(
                            stops: [
                            Gradient.Stop(color: Color(red: 0.15, green: 0.7, blue: 1).opacity(0.2), location: 0.00),
                            Gradient.Stop(color: Color(red: 0.82, green: 0.23, blue: 0.89).opacity(0.2), location: 1.00),
                            ],
                            startPoint: UnitPoint(x: 0, y: 1),
                            endPoint: UnitPoint(x: 1, y: 0)
                            )
                        }
                        .cornerRadius(12)
                        .overlay{
                            if isBuyYear{
                                RoundedRectangle(cornerRadius: 12)
                                .inset(by: 1)
                                .stroke(Color(red: 1, green: 0.87, blue: 0.19), lineWidth: 2)
                            }

                        }
                        .overlay(alignment: .topTrailing, content: {
                            Text("Special offer")
                                .mfont(10, .bold)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                              .frame(width: 87, height: 22)
                              .background(Color(red: 1, green: 0.87, blue: 0.19))
                              .cornerRadius(20)
                              .offset(x: -16, y: -11)
                            
                        })
                        .contentShape(Rectangle())
                        .onTapGesture(perform: {
                            self.isBuyYear = true
                        })
                        .padding(.top, 20)
                        .padding(.horizontal, 16)
                    
                    ZStack{
                        if isBuyYear {
                            Text("Cancel any time.")
                                .mfont(12, .regular, line: 1)
                              .multilineTextAlignment(.center)
                              .foregroundColor(.white)
                        }else{
                            if enableFreeTrial{
                                Text("No payment now.")
                                    .mfont(15, .bold, line: 1)
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(.white)
                            }else{
                                Text("Auto-renewable, cancel anytime.")
                                    .mfont(12, .regular, line: 1)
                                  .multilineTextAlignment(.center)
                                  .foregroundColor(.white)
                            }
                        }
                    }.padding(.top, (!isBuyYear && enableFreeTrial) ? 12 : 16  )
                        .padding(.bottom, 20)
                    
                    
                    
                }
                    
                
               
            
            }
        }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background{
                VisualEffectView(effect: UIBlurEffect(style: .dark))
            }
    }
    
    
    @ViewBuilder
    func OptForProUser() -> some View{
        VStack(spacing : 12){
            
            ForEach(list_2, id: \.self){
                opt in
                ChidOpt(text: opt)
            }
            
            
            
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 45)
    }
    
    @ViewBuilder
    func ChidOpt(text : String) -> some View{
        HStack(spacing : 16){
            Image("star_2")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 12, height: 12)
            
            Text(text)
                .mfont(17, .bold)
                .foregroundColor(.white)
                .padding(.leading,  16)
                .lineLimit(1)
                .fixedSize()
        }.frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 24)
        
    }
}

#Preview {
    ScreenUserFeedbackView()
}
