//
//  CorouselView.swift
//  Xsis
//
//  Created by Rahmat Susanto on 19/10/23.
//

import SwiftUI

struct CarauselView: View {
    var body: some View {
        Group {
            CarouselContent()
                .frame(width: UIScreen.main.bounds.width - 40, height: 200, alignment: .center)
                .cornerRadius(20)
        }
    }
}

struct CarouselContent: View {
    var body: some View {
        GeometryReader { geometry in
            CorouselItems(numberOfImages: 5) {
                Image("home_banner_1")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("home_banner_2")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("home_banner_3")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("home_banner_4")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                Image("home_banner_5")
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
            }
        }
    }
}

struct CorouselItems<Content: View>: View {
    private var numberOfImages: Int
    private var content: Content
    @State var slideGesture: CGSize = CGSize.zero
    @State private var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    init(numberOfImages: Int, @ViewBuilder content: () -> Content) {
        self.numberOfImages = numberOfImages
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom) {
                HStack(spacing: 0) {
                    self.content
                }
                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .leading)
                .offset(x: CGFloat(self.currentIndex) * -geometry.size.width, y: 0)
                .animation(.spring())
                .onReceive(self.timer) { _ in
                    self.currentIndex = (self.currentIndex + 1) % (self.numberOfImages == 0 ? 1 : self.numberOfImages)}
                .gesture(DragGesture().onChanged{ value in
                    self.slideGesture = value.translation
                }
                    .onEnded{ value in
                        if self.slideGesture.width < -50 {
                            if self.currentIndex < self.numberOfImages - 1 {
                                withAnimation {
                                    self.currentIndex += 1
                                }
                            }
                        }
                        if self.slideGesture.width > 50 {
                            if self.currentIndex > 0 {
                                withAnimation {
                                    self.currentIndex -= 1
                                }
                            }
                        }
                        self.slideGesture = .zero
                    })
                
                HStack(spacing: 3) {
                    ForEach(0..<self.numberOfImages, id: \.self) { index in
                        Circle()
                            .frame(width: index == self.currentIndex ? 10 : 8,
                                   height: index == self.currentIndex ? 10 : 8)
                            .foregroundColor(index == self.currentIndex ? Color.green : .white)
                            .overlay(Circle().stroke(Color.indigo, lineWidth: 1))
                            .padding(.bottom, 8)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}
