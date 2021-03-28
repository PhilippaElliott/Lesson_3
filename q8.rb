flintstones = { "Fred" => 0, "Wilma" => 1, "Barney" => 2, "Betty" => 3, "BamBam" => 4, "Pebbles" => 5 }

flintstones_array = flintstones.to_a

new_fa = flintstones_array.at(2)

p new_fa

#can be done using flintstones.assoc("Barney")
