//
//  OnboardingVerTwoSubView.swift
//  WallpaperIOS
//
//  Created by Duc on 21/09/2023.
//

import SwiftUI
import AVKit
import StoreKit
#Preview {
    SplashView()
    
    //    OnboardingVerTwoSubView()
    //        .environmentObject(MyStore())
}


struct OnboardingVerTwoSubView: View {
    @State var currentPage : Int =  1
    @EnvironmentObject var store : MyStore
    @State var currentProduct : Int = 2
    
    @State var showXmark : Bool =  false
    @State var navigateToHome : Bool = false
    
    @EnvironmentObject var homeVM : HomeViewModel
    @EnvironmentObject var interAd : InterstitialAdLoader
    @EnvironmentObject var rewardAd : RewardAd
    
    let list_1 : [String] = [
        "100% free during the trial.",
        "Easily cancel anytime.",
        "Get full access to all features and content. Why not try?",
        "One-time-only offer for new user. The first 3-day is on us."
    ]
    
    
    
    
    
    
    var body: some View {
        ZStack{
            NavigationLink(destination:
                            EztMainView()
                           
                .environmentObject(homeVM)
                .environmentObject(store)
                .environmentObject(interAd)
                .environmentObject(rewardAd)
                           , isActive: $navigateToHome, label: {
                EmptyView()
            })
            
            TabView(selection: $currentPage )  {
                Screen_1()
                    .tag(1)
                Screen_2()
                    .tag(2)
                Screen_3()
                    .tag(3)
                Screen_4()
                    .tag(4)
                Screen_5()
                    .tag(5)
                Screen_6()
                    .tag(6)
                Screen_7()
                    .tag(7)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .ignoresSafeArea()
                .background(Color.black)
                .onChange(of: currentPage, perform: { page in
                    if page >= 6 {
                        withAnimation(.easeIn){
                            showXmark = false
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
                            withAnimation(.easeInOut){
                                showXmark = true
                            }
                        })
                    }
                })
                .overlay(
                    content()
                )
                .overlay(
                    ZStack{
                        if currentPage >= 6  && showXmark {
                            Button(action: {
                                
                                UserDefaults.standard.set(true, forKey: "firstTimeLauncher")
                                
                                if currentPage == 6{
                                    withAnimation(.linear){
                                        currentPage = 7
                                    }
                                    //                                    showXmark = false
                                    //                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                                    //                                        withAnimation(.easeInOut){
                                    //                                            showXmark = true
                                    //                                        }
                                    //
                                    //                                    })
                                    
                                    
                                }else{
                                    withAnimation{
                                        navigateToHome.toggle()
                                    }
                                }
                            }, label: {
                                Image("close.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .frame(width: 56, height: 40, alignment: .center)
                                    .opacity(0.5)
                            })
                        }
                        
                    }
                    
                    , alignment: .topTrailing
                )
            
                .overlay(
                    ZStack{
                        if store.isPurchasing {
                            ProgressBuySubView()
                        }
                    }
                )
            
        }
        
        
        
    }
}

extension OnboardingVerTwoSubView{
    
    
    func content() -> some View{
        VStack(spacing : 0){
            
            ZStack{
                if currentPage < 6 {
                    
                    VStack(spacing : 0){
                        
                        Text(getTextTitle(page:currentPage).toLocalize())
                            .mfont(32, .bold)
                            .foregroundColor(.main)
                        
                            .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay( 0.2 ) , value: currentPage)
                            .padding(.horizontal, 48)
                        Text(getTextSubTitle(page:currentPage).toLocalize())
                            .mfont(24, .regular, line: 2)
                            .lineLimit(2)
                        //      .fixedSize()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                        
                        
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 32)
                        
                        //                        .animation(.interactiveSpring(response: 0.9, dampingFraction: 0.8, blendDuration: 0.5).delay( 0.2 ) , value: currentPage)
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight : .infinity, alignment : .bottom)
                    .padding(.bottom, 24)
                    
                    
                }else if currentPage == 6 {
                    Page_6(currentProduct: $currentProduct)
                        .environmentObject(store)
                    
                    
                }else{
                    Page_7()
                    
                }
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                
                if currentPage < 6 {
                    withAnimation(.linear){
                        currentPage += 1
                    }
                }else if currentPage == 6 {
                    UserDefaults.standard.set(true, forKey: "firstTimeLauncher")
                    Firebase_log("Click_Buy_Sub_In_Onb")
                    
                    
                    
                    if currentProduct == 1 {
                        if let weekPro = store.weekProductNotSale {
                            Firebase_log("Click_Buy_Sub_In_Onb_Week")
                            purchasesss(product: weekPro, string: "Onb_Week")
                        }
                    }else if  currentProduct == 2 {
                        if let yearPro = store.yearlyFreeTrialProduct {
                            Firebase_log("Click_Buy_Sub_In_Onb_Year_FreeTrial")
                            purchasesss(product: yearPro, string: "Onb_Year_FreeTrial")
                        }
                    }else if  currentProduct == 3 {
                        if let month24Pro = store.monthProduct {
                            Firebase_log("Click_Buy_Sub_In_Onb_Month")
                            purchasesss(product: month24Pro, string: "Onb_Month")
                        }
                    }
                    
                    
                }else if currentPage == 7 {
                    UserDefaults.standard.set(true, forKey: "firstTimeLauncher")
                    if let yearPro = store.yearlyFreeTrialProduct {
                        Firebase_log("Click_Buy_Sub_In_Consider_Year_FT")
                        purchasesss(product: yearPro, string: "Consider_Year_FT")
                    }
                }
                
                
                
            }, label: {
                HStack{
                    
                    
                    Text( currentPage == 7 ? "Start 3-DAY Free Trial".toLocalize() : "Continue".toLocalize())
                        .mfont(16, .bold, line: 2)
                        .foregroundColor(.black)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height : 56)
                .contentShape(Rectangle())
                .overlay(
                    ZStack{
                        ResizableLottieView(filename: "arrow")
                            .frame(width: 32, height: 32 )
                            .padding(.trailing , 24)
                    }
                    
                    
                    , alignment: .trailing
                )
            })
            .background(
                Capsule().fill(Color.main)
            )
            .padding(.horizontal, 24)
            .padding(.bottom, 64)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
            .background(
                VStack(spacing : 0){
                    Spacer()
                    LinearGradient(colors: [Color("black_bg").opacity(0), Color("black_bg")], startPoint: .top, endPoint: .bottom)
                        .frame(height : 120)
                    Color("black_bg")
                        .frame(height : 180)
                }.ignoresSafeArea()
            )
            .overlay(
                ZStack{
                    if currentPage >= 6 {
                        HStack(spacing : 4){
                            Button(action: {
                                if let url = URL(string: "https://docs.google.com/document/d/1SmR-gcwA_QaOTCEOTRcSacZGkPPbxZQO1Ze_1nVro_M") {
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                Text("Privacy Policy".toLocalize()).mfont(10, .regular).foregroundColor(.white.opacity(0.7))
                            })
                            
                            Text("|").mfont(10, .regular).foregroundColor(.white.opacity(0.7))
                            
                            Button(action: {
                                Task{
                                    let b = await store.restore()
                                    if b {
                                        store.fetchProducts()
                                        showToastWithContent(image: "checkmark", color: .green, mess: "Restore Successful")
                                    }else{
                                        showToastWithContent(image: "xmark", color: .red, mess: "Cannot restore purchase")
                                    }
                                }
                                
                            }, label: {
                                Text("Restore".toLocalize()).mfont(10, .regular).foregroundColor(.white.opacity(0.7))
                            })
                            
                            Text("|").mfont(10, .regular).foregroundColor(.white.opacity(0.7))
                            
                            Button(action: {
                                if let url = URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/") {
                                    UIApplication.shared.open(url)
                                }
                            }, label: {
                                Text("Term of use".toLocalize()).mfont(10, .regular).foregroundColor(.white.opacity(0.7))
                            })
                            
                            
                            
                        }.edgesIgnoringSafeArea(.bottom)
                    }
                }
                
                
                
                
                , alignment: .bottom
            )
    }
    
    
    func purchasesss(product : Product, string : String) {
        store.isPurchasing = true
        
        store.purchase(product: product, onBuySuccess: { b in
            if b {
                
                DispatchQueue.main.async{
                    store.isPurchasing = false
                    Firebase_log("Buy_Sub_Success_In_\(string)")
                    
                    showToastWithContent(image: "checkmark", color: .green, mess: "Purchase successful!")
                    withAnimation{
                        navigateToHome.toggle()
                    }
                }
            }else{
                DispatchQueue.main.async{
                    store.isPurchasing = false
                }
            }
            }
        )
    }
    
    
    func getTextTitle(page : Int) -> String{
        if page == 1 {
            return "100000+"
        }else if page == 2 {
            return "Live Wallpapers"
        }else if page == 3 {
            return "Depth Effect"
        }else if page == 4 {
            return "Shuffle Packs"
        }else if page == 5 {
            return "Widgets"
        }else{
            return ""
        }
    }
    
    func getTextSubTitle(page : Int) -> String{
        if page == 1 {
            return "4K Wallpapers"
        }else if page == 2 {
            return "Vivid every detail"
        }else if page == 3 {
            return "Amazing 3D effects"
        }else if page == 4 {
            return "Automatically change exciting wallpapers"
        }else if page == 5 {
            return "An exclusive experience like never before"
        }else{
            return ""
        }
    }
    
    
    
    func Screen_1() -> some View{
        VideoOnboarding(video_name: "video1")
    }
    
    func Screen_2() -> some View{
        VideoOnboarding(video_name: "live")
    }
    func Screen_3() -> some View{
        VideoOnboarding(video_name: "depth_effect")
    }
    func Screen_4() -> some View{
        VideoOnboarding(video_name: "shuffle_packs")
    }
    
    func Screen_5() -> some View{
        VideoOnboarding(video_name: "video5")
        
    }
    
    func Screen_6() -> some View{
        
        VideoOnboarding(video_name: "video4v2")
        
        
    }
    
    
    
    func Screen_7() -> some View{
        Image("considerr")
            .resizable()
            .scaledToFit()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .gesture(DragGesture())
    }
    
    func Page_7() -> some View{
        VStack(spacing : 0){
            Text("Wait a Moment".toLocalize())
                .mfont(24, .bold)
                .foregroundColor(.main)
                .padding(.top, 100  )
                .frame(maxWidth: .infinity, alignment : .leading)
                .padding(.horizontal, 40)
            Text("Consider the following before you".toLocalize())
                .mfont(17, .regular)
                .foregroundColor(.white)
            
                .frame(maxWidth: .infinity, alignment : .leading)
                .padding(.horizontal, 40)
            Text("make the final decistion".toLocalize())
                .mfont(17, .regular)
                .foregroundColor(.white)
            
                .frame(maxWidth: .infinity, alignment : .leading)
                .padding(.horizontal, 40)
            
            Spacer()
            
            
            VStack(spacing : 16){
                ForEach(list_1, id: \.self){ opt in
                    HStack(spacing : 16){
                        Image("check")
                            .resizable()
                            .frame(width: 24, height: 24)
                        
                        //
                        //TextTypingAnimView(text: opt, color: .white, fontSize: 17, weight: .bold)
                        
                        Text(opt.toLocalize())
                            .mfont(17, .bold, line : 3)
                            .foregroundColor(.white)
                        
                        
                    }.frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                        .padding(.horizontal, 40)
                }
            }
            
            if let yearlyFreeTrialProduct = store.yearlyFreeTrialProduct {
                Text("Try 3 days for free".toLocalize())
                    .mfont(17, .bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding(.top, 56)
                
              //  Text("Then \(yearlyFreeTrialProduct.displayPrice)/year. No Payment Now")
              Text(  String(format: NSLocalizedString("Then %@/year. No Payment Now", comment: ""), "\(yearlyFreeTrialProduct.displayPrice)"))
                    .mfont(13, .regular)
                    .foregroundColor(.white)
            }
            
            
            
            
            
            
            
            
            
            
        }
        .frame(maxWidth: .infinity, maxHeight : .infinity, alignment : .top)
        .background(
            LinearGradient(colors: [Color("black_bg").opacity(0.2),
                                    Color("black_bg").opacity(0.6),
                                    Color("black_bg").opacity(0.8),
                                    Color("black_bg"),
                                    Color("black_bg")], startPoint: .top, endPoint: .bottom)
        ).padding(.bottom, 24)
        
    }
    
}

struct VideoOnboarding : View{
    
    @State var avPlayer : AVPlayer?
    let video_name : String
    
    
    var body: some View{
        ZStack{
            if  avPlayer != nil{
                MyVideoPlayer(player: avPlayer!)
                    .ignoresSafeArea()
                    .gesture(DragGesture())
            }
        }
        
        .onAppear(perform: {
            avPlayer = AVPlayer(url:  Bundle.main.url(forResource: video_name, withExtension: "mp4")!)
            avPlayer!.play()
        })
        .onDisappear(perform: {
            if avPlayer != nil{
                avPlayer!.pause()
            }
            avPlayer = nil
        })
        
        
    }
}


struct VideoOnboardingForSC5 : View{
    
    @State var avPlayer : AVPlayer?
    let video_name : String
    
    
    var body: some View{
        ZStack(alignment: .top) {
            
            if let avPlayer {
                VStack(spacing : 0){
                    MyVideoPlayer(player: avPlayer, aspect: .resizeAspect)
                    Spacer()
                }
                
                
                .ignoresSafeArea()
                .gesture(DragGesture())
            }
        }
        
        .onAppear(perform: {
            avPlayer = AVPlayer(url:  Bundle.main.url(forResource: video_name, withExtension: "mp4")!)
            avPlayer!.play()
        })
        .onDisappear(perform: {
            if avPlayer != nil{
                avPlayer!.pause()
            }
            avPlayer = nil
        })
        
        
    }
}

struct Page_6: View {
    
    @Binding var currentProduct : Int
    @EnvironmentObject var store : MyStore
    let list_2 : [String] = [
        "Unlimited Premium Wallpapers",
        "Unlimited Premium Widgets",
        "No ADs."
        
    ]
    
    
    var body: some View {
        VStack(spacing : 0){
            Spacer()
            
            VStack(spacing : 16){
                HStack(spacing : 23){
                    Image("star_5")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 32, height: 32)
                    
                    Text("Wallive Premium".toLocalize())
                        .mfont(24, .bold)
                        .foregroundColor(.main)
                    
                }.frame(maxWidth: .infinity, alignment : .leading)
                
                    .padding(.leading, 63)
                
                
                ForEach(list_2, id: \.self){
                    opt in
                    
                    HStack(spacing : 23){
                        Image("star_1")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 12, height: 12)
                        
                        Text(opt.toLocalize())
                            .mfont(17, .bold, line: 2)
                            .foregroundColor(.white)
                        
                    }.frame(maxWidth: .infinity, alignment : .leading)
                        
                        .padding(.leading, 73)
                        .padding(.trailing, 48)
                    
                }
                
                
            }
            
            if let weekProduct = store.weekProductNotSale,
               let yearTrialProduct = store.yearlyFreeTrialProduct,
               let month24Product = store.monthProduct  {
                
                GeometryReader{
                    proxy in
                    let size = proxy.size
                    let widthItem = ( size.width - 48 ) / 5
                    
                    
                    
                    HStack(spacing : 8){
                        
                        
                        ZStack(alignment: .bottom){
                            Color.clear
                            
                            
                            
                            
                            if currentProduct == 1 {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.main)
                                    .frame( height: 100)
                            }
                            
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.mblack_bg)
                                .frame( height: 96)
                                .padding(2)
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                                .frame( height: 96)
                                .padding(2)
                            
                            
                            VStack(spacing : 0){
                                Text("1")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                Text("WEEK")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                          //      Text("\(weekProduct.displayPrice)/week.")
                                Text( String(format: NSLocalizedString("%@/week", comment: ""), weekProduct.displayPrice) )
                                    .mfont(13, .regular)
                                    .lineLimit(1)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text("Billed weekly")
                                    .mfont(9, .regular)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                            }.frame( height: 96, alignment : .top)
                                .padding(2)
                            
                            
                            
                        }.frame(width: widthItem * 1.5)
                            .frame(maxHeight: .infinity)
                            .onTapGesture {
                                withAnimation{
                                    currentProduct = 1
                                }
                            }
                        
                        ZStack(alignment: .bottom){
                            
                            
                            RoundedRectangle(cornerRadius: 16)
                                .fill(currentProduct == 2 ? Color.main : Color.main.opacity(0.4))
                                .overlay(
                                    Text("3-Day Free Trial")
                                        .mfont(15, .bold)
                                        .foregroundColor(.black)
                                        .frame( height: 40)
                                    , alignment: .top
                                )
                            
                            VStack(spacing : 0){
                                Text("52")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                Text("WEEK")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text( String(format: NSLocalizedString("%@/week", comment: ""), getDisplayPrice(price: yearTrialProduct.price, chia: 51, displayPrice: yearTrialProduct.displayPrice) ) )
                                    .mfont(13, .regular)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text("Billed annually")
                                    .mfont(9, .regular)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                            }
                            .frame(maxWidth : .infinity)
                            .frame( height: 100, alignment : .top)
                            .background(
                                ZStack{
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(
                                            LinearGradient(colors: [Color.mblack_bg, Color.mblack_bg , Color.mblack_bg ,Color.mblack_bg.opacity(0.6)], startPoint: .top, endPoint: .bottom)
                                        )
                                        .frame( height: 100)
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(Color.white.opacity(0.15))
                                        .frame( height: 100)
                                }
                            )
                            .padding(2)
                            
                        }.frame(width: widthItem * 2, height: size.height)
                            .onTapGesture {
                                withAnimation{
                                    currentProduct = 2
                                }
                            }
                        ZStack(alignment: .bottom){
                            Color.clear
                            
                            
                            
                            
                            if currentProduct == 3 {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(Color.main)
                                    .frame( height: 100)
                            }
                            
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.mblack_bg)
                                .frame( height: 96)
                                .padding(2)
                            RoundedRectangle(cornerRadius: 16)
                                .fill(Color.white.opacity(0.15))
                                .frame( height: 96)
                                .padding(2)
                            
                            
                            VStack(spacing : 0){
                                Text("4")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                    .padding(.top, 8)
                                Text("WEEK")
                                    .mfont(17, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                               // Text("\(decimaPriceToStr(price: month24Product.price , chia: 4))\(removeDigits(string: month24Product.displayPrice ))/week.")
                                Text( String(format: NSLocalizedString("%@/week", comment: ""), getDisplayPrice(price: month24Product.price, chia: 4, displayPrice: month24Product.displayPrice) ) )
                                    .mfont(13, .regular)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                                Text("Billed monthly")
                                    .mfont(9, .regular)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                                
                            }.frame( height: 96, alignment : .top)
                                .padding(2)
                            
                            
                            
                        }.frame(width: widthItem * 1.5)
                            .frame(maxHeight: .infinity)
                            .onTapGesture {
                                withAnimation{
                                    currentProduct = 3
                                }
                            }
                        
                        
                        
                        
                    }
                    .frame(maxWidth: .infinity, maxHeight : .infinity, alignment : .bottom)
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 140)
                .padding(.horizontal, 8)
                .padding(.top, 32)
                .padding(.bottom, 8)
                
                
                VStack(spacing : 4 ){
                    ZStack{
                        Color.clear
                        if currentProduct == 2 {
                            HStack{
                                Image("protected")
                                    .resizable()
                                    .frame(width: 16, height: 16, alignment: .center)
                                
                                Text("No Payment Now!")
                                    .mfont(13, .bold)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
                            }
                        }
                        
                    }.frame( height: 18)
                    ZStack{
                        if currentProduct == 1 {
                            Text( String(format: NSLocalizedString("Just %@ per year, cancel any time.", comment: ""), "\(weekProduct.displayPrice)") )
                         //   Text("Just \(weekProduct.displayPrice) per week, cancel any time.")
                                .mfont(11, .regular)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }else if currentProduct == 2 {
                          //  Text("Just \(yearTrialProduct.displayPrice) per year, cancel any time.")
                            Text( String(format: NSLocalizedString("Just %@ per year, cancel any time.", comment: ""), "\(yearTrialProduct.displayPrice)") )
                                .mfont(11, .regular)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }else if currentProduct == 3 {
                            Text( String(format: NSLocalizedString("Just %@ per year, cancel any time.", comment: ""), "\(month24Product.displayPrice)") )
                          //  Text("Just \(month24Product.displayPrice) per month, cancel any time.")
                                .mfont(11, .regular)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                    }.frame(height : 15)
                    
                    
                    
                }.frame(height : 37, alignment: .bottom)
                
            }
            
            
            
            
            
            
            
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(
                LinearGradient(colors: [Color("black_bg").opacity(0.0),
                                        Color("black_bg").opacity(0.4),
                                        Color("black_bg"),
                                        Color("black_bg")], startPoint: .top, endPoint: .bottom)
            ).padding(.bottom, 24)
    }
}

