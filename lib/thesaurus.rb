class Thesaurus

	VIEW = ["look at","view", "examine","browse","watch","analyse","analyze","study"]
	ABOUT = ["about", "info", "about the app", "about us", "who are we?"]
	CONTACT = ["contact your congressman", "contact", "take action", "get in touch", "act now!", "act", "communicate", "contact your rep"]
	CARE = ["have interest in", "care about", "have concern for"]

	IPSUM_BASEURL = "http://baconipsum.com/api/?="

	def self.getParagraphs(num)
		json_txt = HTTParty.get(IPSUM_BASEURL,{:query=> {:type=>"meat-and-filler", :paras=>num}})[0]
	end

	def self.getSentences(num)
		json_txt = HTTParty.get(IPSUM_BASEURL,{:query=> {:type=>"meat-and-filler", :sentences=>num}})[0]
	end

end