//
//  Line.swift
//  Taxionomy
//  Created by Herve Crespel on 17/01/2021.
//

import SwiftUI

struct Line: View {
    var prompt = "phrase ou suite de mots"

    @Binding var input : String
    
     var body: some View {
         VStack {
            if prompt != "" {
                Text(prompt).font(.caption)
            }
            TextField(prompt, text: $input)
              //  .textFieldStyle(putexStyle())
        }
     }
}

struct Line_Previews: PreviewProvider {
    static var previews: some View {
        Line(input:.constant("une phrase courte"))
    }
}
