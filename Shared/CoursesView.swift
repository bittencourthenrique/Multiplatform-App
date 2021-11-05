//
//  CoursesView.swift
//  Multiplatform App
//
//  Created by Henrique Bittencourt on 10/27/21.
//

import SwiftUI

struct CoursesView: View {
    @State var show = false
    @Namespace var namespace
    @State var selectedItem: Course? = nil
    @State var isDisabled = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.adaptive(minimum: 160), spacing: 16)
                    ],
                    spacing: 16
                ) {
                    ForEach(courses) { item in
                        VStack {
                            CourseItem(course: item)
                                .matchedGeometryEffect(id: item.id, in: namespace, isSource: !show)
                            .frame(height: 200)
                            .onTapGesture {
                                withAnimation(.spring(response: 0.3, dampingFraction: 0.7, blendDuration: 0)) {
                                    show.toggle()
                                    selectedItem = item
                                    isDisabled = true
                                }
                            }
                        .disabled(isDisabled)
                        }
                        .matchedGeometryEffect(id: "container\(item.id)", in: namespace, isSource: !show)
                    }
                }
                .padding(16)
                .frame(maxWidth: .infinity)
            }
            zIndex(1)
            if selectedItem != nil {
                ZStack {
                    VStack {
                        ScrollView {
                            CourseItem(course: selectedItem!)
                                .matchedGeometryEffect(id: selectedItem!.id, in: namespace)
                                .frame(height: 300)
                            VStack {
                                ForEach(0 ..< 20) { item in
                                    CourseRow()
                                }
                            }
                            .padding()
                        }
                    }
                    .background(Color("Background 1"))
                    .clipShape(RoundedRectangle(cornerRadius: 22, style: .continuous))
                    .matchedGeometryEffect(id: "container\(selectedItem!.id)", in: namespace)
                .edgesIgnoringSafeArea(.all)
                zIndex(2)
                    
                CloseButton()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            show.toggle()
                            selectedItem = nil
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                isDisabled = false
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}

