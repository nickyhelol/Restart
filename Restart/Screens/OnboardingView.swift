//
//  OnboardingView.swift
//  Restart
//
//  Created by Nick He on 12/02/22.
//

import SwiftUI

struct OnboardingView: View {
    
    // MARK: - PROPERTY
    
    @AppStorage("onboarding") var isOnboardingViewActive: Bool = true
    
    @State private var buttonWidth: Double = UIScreen.main.bounds.width - 80
    @State private var buttonOffset: CGFloat = 0
    @State private var isAnimnating: Bool = false
    
    // MARK: - BODY
    
    var body: some View {
        ZStack {
            Color("ColorBlue").ignoresSafeArea(.all, edges: .all)
            
            VStack(spacing: 20) {
                // MARK: - HEADER
                Spacer()
                
                VStack(spacing: 0) {
                    Text("Share")
                        .font(.system(size: 60))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                    
                    Text("""
                    It's not how much we give but
                    how much love we put into giving.
                    """)
                        .font(.title3)
                        .fontWeight(.light)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(10)
                    
                    
                }
                .opacity(isAnimnating ? 1 : 0)
                .offset(y: isAnimnating ? 0 : -40)
                .animation(.easeOut(duration: 1), value: isAnimnating)
                
                // MARK: - CENTER
                
                ZStack {
                    CircleGroupView(ShapeColor: .white, ShapeOpacity: 0.2)
                    
                    Image("character-1")
                        .resizable()
                        .scaledToFit()
                        .opacity(isAnimnating ? 1 : 0)
                        .animation(.easeOut(duration: 0.5), value: isAnimnating)

                }
                
                Spacer()
                
                // MARK: - FOOTER
                
                ZStack {
                    // 1. Button wrapper
                    Capsule()
                        .fill(Color.white.opacity(0.2))
                    
                    Capsule()
                        .fill(Color.white.opacity(0.2)).padding(8)
                    
                    // 2. Call-to-action
                    Text("Get Started")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .offset(x: 20)
                    
                    // 3. Capsule dynamic width
                    HStack {
                        Capsule()
                            .fill(Color("ColorRed"))
                            .frame(width: 80 + buttonOffset)
                        
                        Spacer()
                    }
                    
                    // 4. Draggable circle
                    
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color("ColorRed"))
                            Circle()
                                .fill(.black.opacity(0.15))
                                .padding(8)
                            Image(systemName: "chevron.right.2")
                                .font(.system(size: 24, weight: .bold))
                        }
                        .frame(width: 80, height: 80, alignment: .center)
                        .foregroundColor(.white)
                        .offset(x: buttonOffset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    if gesture.translation.width > 0 && buttonOffset < buttonWidth - 80 {
                                        buttonOffset = gesture.translation.width
                                    } else {
                                        isOnboardingViewActive = false
                                    }
                                }
                                .onEnded { _ in
                                    withAnimation(Animation.easeOut(duration: 0.6)){
                                        buttonOffset = 0
                                    }
                                }
                        ) //: Gesture
                        
                        Spacer()
                    } //: HStack
                }
                .frame(width:buttonWidth, height: 80, alignment: .center)
                .padding()
                .opacity(isAnimnating ? 1 : 0)
                .offset(y: isAnimnating ? 0 : 40)
                .animation(.easeOut(duration: 1), value: isAnimnating)
            }
        }
        .onAppear(perform: {
            isAnimnating = true
        })
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
