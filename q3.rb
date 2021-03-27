advice = "Few things in life are as important as house training your pet dinosaur."

advice_array = advice.split(" ")

advice_array.map! {|word| word == "important" ? "urgent" : word}

puts advice_array.join(" ")