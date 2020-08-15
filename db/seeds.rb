issue1 = Issue.create!(title:"hello", content: "dummy")
issue1_1 = issue1.children.create!(title:"hello2", content: "dummy")
issue1_1_1 = issue1_1.children.create!(title:"hello3", content: "dummy")
issue1_1_1_1 = issue1_1_1.children.create!(title:"hello4", content: "dummy")
issue1_1_1_1_1 = issue1_1_1_1.children.create!(title:"hello5", content: "dummy")

issue2 = Issue.create!(title:"hello", content: "dummy")
issue2_1 = issue1.children.create!(title:"hello2", content: "dummy")
issue2_1_1 = issue1_1.children.create!(title:"hello3", content: "dummy")
issue2_1_1_1 = issue1_1_1.children.create!(title:"hello4", content: "dummy")
issue2_1_1_1_1 = issue1_1_1_1.children.create!(title:"hello5", content: "dummy")

issue2_2 = issue1.children.create!(title:"hello2", content: "dummy")
issue2_2_1 = issue1_1.children.create!(title:"hello3", content: "dummy")
issue2_2_1_1 = issue1_1_1.children.create!(title:"hello4", content: "dummy")
issue2_2_1_1_1 = issue1_1_1_1.children.create!(title:"hello5", content: "dummy")

issue3 = Issue.create!(title:"good", content: "dummy")
issue3_1 = issue3.children.create!(title:"good2", content: "dummy")
