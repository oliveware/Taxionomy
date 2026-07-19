//
//  FonctionPicker.swift
//  Taxionomy
//
//  Created by Herve Crespel on 05/02/2026.
//

import SwiftUI

public struct FonctionPicker : View {

    @Binding var fonction: Taxion
    var done: () -> Void = {}
    var fonctions:[Taxion]
    
    public init(_ fonction:Binding<Taxion>, _ fonctions:[Taxion], _ done: @escaping () -> Void) {
        _fonction = fonction
        self.done = done
        self.fonctions = fonctions
    }
    
    public init(_ fonction:Binding<Taxion>, _ exclude:[String], _ done: @escaping () -> Void) {
        _fonction = fonction
        self.done = done
        self.fonctions = Taxionomy.fonctions.filter {item in !exclude.contains(item.id)}
    }
    
    public var body: some View {
        VStack {
            if fonctions.count > 0 {
                ScrollView {
                    ForEach(fonctions) { selected in
                        Button(action:{
                            fonction = selected
                            done()
                        })
                        {Text(selected.label).frame(width:100)}
                    }
                }.frame(height:250, alignment:.leading)
                //.padding(.leading, CGFloat(taxion.dim * 80))
            } else {
                Text("aucun choix")
            }
        }.padding()
    }
}

struct FonctionPrepicker : View {
    @State var taxion = Taxion()
    var exclude: [String] = ["2-9-37", "2-9-34", "2-9-36"]
    
    var body: some View {
        VStack {
            Text("Fonctions d'équipement").font(.title).padding()
            FonctionPicker($taxion, exclude,  {})
            Text(taxion.id)
            Text(taxion.nom)
        }.frame(width:300, height:400)
    }
}

#Preview {
    FonctionPrepicker()
}
#Preview {
    FonctionPrepicker(exclude:[])
}
