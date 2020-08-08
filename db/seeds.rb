issue1 = Issue.create!(title:"hello")
issue1_1 = issue1.children.create!(title:"hello2")
issue1_1_1 = issue1_1.children.create!(title:"hello3")
issue1_1_1_1 = issue1_1_1.children.create!(title:"hello4")
issue1_1_1_1_1 = issue1_1_1_1.children.create!(title:"hello5")

issue2 = Issue.create!(title:"hello")
issue2_1 = issue1.children.create!(title:"hello2")
issue2_1_1 = issue1_1.children.create!(title:"hello3")
issue2_1_1_1 = issue1_1_1.children.create!(title:"hello4")
issue2_1_1_1_1 = issue1_1_1_1.children.create!(title:"hello5")

issue2_2 = issue1.children.create!(title:"hello2")
issue2_2_1 = issue1_1.children.create!(title:"hello3")
issue2_2_1_1 = issue1_1_1.children.create!(title:"hello4")
issue2_2_1_1_1 = issue1_1_1_1.children.create!(title:"hello5")

issue3 = Issue.create!(title:"good")
issue3_1 = issue3.children.create!(title:"good2")
