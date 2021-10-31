//
//  CoursesView.swift
//  Multiplatform App
//
//  Created by Henrique Bittencourt on 10/27/21.
//

import SwiftUI

struct CoursesView: View {
    @ViewBuilder
    var body: some View {
        #if os (iOS)
        content
            .listStyle(InsetGroupedListStyle())
        #else
        content
            .frame(minWidth: 800, minHeight: 600)
        #endif
    }
    var content: some View {
        List(0 ..< 20) { item in
            CourseRow()
        }
        .navigationTitle("Courses")
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
