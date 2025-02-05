//
//  AnimatedMeshGradientView.swift
//  AppDuckInfiniteCarouselView
//
//  Created by yossa on 3/2/2568 BE.
//

import SwiftUI

struct AnimatedMeshGradientView: View {
  
  @State private var isAnimated = false
  
  var body: some View {
    MeshGradient(
      width: 3,
      height: 3,
      points: [
          [0.0, 0.0], isAnimated ? [0.75, 0.0] : [0.25, 0.0], [1.0, 0.0],
          isAnimated ? [0.0, 0.8] : [0.0, 0.4], isAnimated ? [0.7, 0.2] : [0.9, 0.4], [1.0, 0.5],
          [0.0, 1.0], isAnimated ? [0.3, 1.0] : [0.6, 1.0], [1.0, 1.0]
      ],
      colors: [
        .softLavender, .paleSkyBlue, .mintGreen,
        .dustyRose, .peachCream, .babyBlue,
        .lilacMist, .seafoamPastel, .blushPink
      ]
    )
    .ignoresSafeArea()
    .onAppear {
      withAnimation(.spring(.smooth).repeatForever(autoreverses: true)) {
        isAnimated = true
      }
    }
  }
}
