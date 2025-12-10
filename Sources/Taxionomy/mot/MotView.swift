//
//  SwiftUIView.swift
//  
//
//  Created by Herve Crespel on 11/12/2023.
//

import SwiftUI

struct MotView: View {
    @Binding var mot : Mot
    
    public init(_ mot: Binding<Mot>) {
        self._mot = mot
    }
       
    public var body: some View {
        HStack {
            VStack {
                Text(Genre.prompt).font(.caption)
                GenrePicker(selected:$mot.genre)
            }
            VStack {
                Text("singulier").font(.caption)
                TextField("", text: $mot.singulier)
                   // .textFieldStyle(putexStyle())
            }
            VStack {
                Text("pluriel").font(.caption)
                TextField("", text: $mot.pluriel)
                  //  .textFieldStyle(putexStyle())
            }
        }
    }
}

#Preview {
    MotView(.constant(Mot("essai",nil)))
}
