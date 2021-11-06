//
//  CourseRow.swift
//  Multiplatform App
//
//  Created by Henrique Bittencourt on 10/27/21.
//

import SwiftUI

struct CourseRow: View {
    var item: CourseSection = courseSections[0]
    var body: some View {
        HStack(alignment: .center) {
            Image(item.logo)
                .renderingMode(.original)
                .frame(width: 48.0, height: 48.0)
                .imageScale(.medium)
                .background(item.color)
                .clipShape(Circle())
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.subheadline)
                    .bold()
                Text(item.subtitle)
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(.vertical, 5.0)
        
       
    }
}

struct CourseRow_Previews: PreviewProvider {
    static var previews: some View {
        CourseRow()
    }
}
