//
//  CoursesView.swift
//  Multiplatform App
//
//  Created by Henrique Bittencourt on 10/27/21.
//

import SwiftUI

struct CoursesView: View {
    var body: some View {
        List(0 ..< 20) { item in
            CourseRow()
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
