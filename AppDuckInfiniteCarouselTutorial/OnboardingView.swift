//
//  OnboardingView.swift
//  AppDuckInfiniteCarouselTutorial
//
//  Created by yossa on 4/2/2568 BE.
//

import SwiftUI

struct OnboardingView: View {
  var body: some View {
    let imageNames1 = (1...7).map { String($0) }
    let imageNames2 = (8...14).map { String($0) }
    let imageNames3 = (15...21).map { String($0) }
    let imageNames4 = (22...28).map { String($0) }
    
    ZStack {
      AnimatedMeshGradientView()
      
      VStack {
        VStack {
          InfiniteCarouselView(imageNames: imageNames1, velocity: 0.5)
          InfiniteCarouselView(imageNames: imageNames2, velocity: -0.25)
          InfiniteCarouselView(imageNames: imageNames3, velocity: 0.3)
          InfiniteCarouselView(imageNames: imageNames4, velocity: -0.2)
        }
        .rotationEffect(.degrees(-10))
        
        Spacer()
      }
      
      LinearGradient(
        stops: [
          .init(color: .clear, location: 0.0),
          .init(color: .white, location: 0.6),
          .init(color: .white, location: 1.0),
        ],
        startPoint: .top,
        endPoint: .bottom
      )
      .ignoresSafeArea()
      
      VStack(spacing: 24) {
        Spacer()
        
        Text("Discover Your Best\nAI Companion")
          .font(.system(.largeTitle, design: .default, weight: .bold))
          .multilineTextAlignment(.center)
          .foregroundStyle(
            LinearGradient(
              colors: [.aiPink, .roboticBlue, .futuristicViolet],
              startPoint: .leading,
              endPoint: .trailing
            )
          )
        
        Text("Find and connect with the best AI companions, personalized just for you. Chat, learn, and experience AI like never before!")
          .font(.system(.subheadline, design: .default, weight: .regular))
          .multilineTextAlignment(.center)
          .foregroundStyle(.gray)
          .padding(.horizontal, 32)
        
        Button {
          // TODO
        } label: {
          Text("Get Started")
            .font(.system(.headline, design: .default, weight: .semibold))
            .foregroundStyle(.white)
            .frame(height: 64)
            .frame(maxWidth: .infinity)
            .background(Color.roboticBlue)
            .clipShape(Capsule())
        }
        .padding(.horizontal, 32)
      }

    }
  }
}

#Preview {
  OnboardingView()
}
