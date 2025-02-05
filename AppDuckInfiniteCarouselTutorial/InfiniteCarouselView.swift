//
//  InfiniteCarouselView.swift
//  AppDuckInfiniteCarouselTutorial
//
//  Created by yossa on 4/2/2568 BE.
//

import SwiftUI

struct InfiniteCarouselView: View {
  
  init(imageNames: [String], velocity: CGFloat = 1) {
    self.imageNames = imageNames
    
    var items: [Item] = []
    
    items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
    items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
    items.append(contentsOf: imageNames.map { Item(id: UUID(), imageName: $0) })
    
    self.items = items
    self.velocity = velocity
    
    let length = (CarouselCard.itemSize.width + itemSpacing) * CGFloat(imageNames.count)
    self.x = length
    self.carouselLength = length
  }
  
  private let imageNames: [String]
  private let items: [Item]
  private let velocity: CGFloat
  
  @State private var scrollPosition = ScrollPosition()
  @State private var timer = Timer
    .publish(every: 0.01, on: .main, in: .common)
    .autoconnect()
  
  @State private var x: CGFloat
  
  private let itemSpacing: CGFloat = 8
  private let carouselLength: CGFloat
  
  var body: some View {
    ScrollView(.horizontal, showsIndicators: false) {
      HStack(spacing: itemSpacing) {
        ForEach(items) { item in
          CarouselCard(imageName: item.imageName)
            .id(item.id)
        }
      }
      .safeAreaPadding(.horizontal)
    }
    .scrollClipDisabled()
    .scrollPosition($scrollPosition)
    .onReceive(timer) { _ in
      if x >= carouselLength * 2 || x <= 0 {
        x = carouselLength
      } else {
        x += velocity
      }
    }
    .onChange(of: x) {
      scrollPosition.scrollTo(x: x)
    }
    // 1. we need to detect when the scroll view is manually started / stopped
    .onScrollPhaseChange { oldPhase, newPhase in
      switch (oldPhase, newPhase) {
      case (.idle, .idle):
        break
        
      case (_, .interacting):
        timer.upstream.connect().cancel()
        
      case (_, .idle):
        timer = Timer
          .publish(every: 0.01, on: .main, in: .common)
          .autoconnect()
        
      default:
        break
      }
    }
    // 2. we need to observe the distance the scroll view was moved during the period
    .onScrollGeometryChange(for: Double.self) { scrollGeometry in
      scrollGeometry.contentOffset.x
    } action: { oldValue, newValue in
      x = newValue
    }

  }
}

struct Item: Identifiable {
  let id: UUID
  let imageName: String
}

struct CarouselCard: View {
  
  let imageName: String
  
  static let itemSize = CGSize(width: 100, height: 120)
  
  var body: some View {
    Image(imageName)
      .resizable()
      .scaledToFill()
      .frame(width: Self.itemSize.width, height: Self.itemSize.height)
      .clipShape(RoundedRectangle(cornerRadius: 16))
      .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 4)
  }
}

#Preview {
  let imageNames = (1...7).map { String($0) }
  InfiniteCarouselView(imageNames: imageNames)
}
