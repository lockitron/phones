# Supported formats (ignore initial dash): 
# - (555) 555-5555
# - 555-555-5555
# - 555.555.5555
# - 555 555 5555
# - +1 555 555 5555
# - +44 844 335 1801
# - 0844 335 1801
# - +49696900
# - +19252008843
# - +448443351801

require 'phones/phone'
module Phones
	class Parser
		IGNORABLE_CHARACTERS = /[a-zA-Z]|\-|\s|\.|\(|\)|\;|\:|\*|\&|\%|\$|\#|\@|\!/.freeze
		def self.parse(options)
			# Let's figure out what the phone number is
			if options.class == Hash
				@number = options[:phone] || options[:number]
			elsif options.class == String
				@number = options
			else
				raise ArgumentError, "Pass a hash of options including a \"number\" key, or just a phone number"
			end

			# Now, let's remove all the characters we can ignore
			strip!

			# "+19252008843" or "19252008843" or "9252008843" are all common
			@phone = try_without_delimiters!

			@phone
		end

		def self.number
			@number
		end

		def self.verbose!
			@verbose = true
		end

		private

		def self.try_without_delimiters!
			raise ArgumentError, "Valid phone numbers are between 5 and 16" if self.number.length > 5 && self.number.length < 16
			parts = []
			# Let's find out if there is a country code
			country_code = "+1"
			# It's easiest to tell when it starts with a plus, so let's start with that
			log "Number: #{self.number}"
			if self.number[0] == "+"
				# Estados Unidos!
				if self.number[1] == '1' && self.number.length == "+19252008843".length
					parts = [self.number[2..4], self.number[5..-1]]
				# 3 Digit country code?
				elsif COUNTRY_CODES.include?(self.number[1..3])
					log "Three Digit Country Code: #{self.number[1..3]}"
					country_code = self.number[0..4]
					parts 			 = [nil, self.number[5..-1]]
				# 2 Digit country code?
				elsif COUNTRY_CODES.include?(self.number[1..2])
					log "Two Digit Country Code: #{self.number[1..2]}"
					country_code = self.number[0..2]
					parts 			 = [nil, self.number[4..-1]]
				else
					# IDK, man
					raise ArgumentError, "Can't parse phone number"
				end
			elsif self.number[0..1] == "00"
				@number = self.number[2..-1]
				if COUNTRY_CODES.include?(self.number[0..2])
					log "Three Digit Country Code: #{self.number[0..2]}"
					country_code = "+" + self.number[0..2]
					parts 			 = [nil, self.number[3..-1]]
				# 2 Digit country code?
				elsif COUNTRY_CODES.include?(self.number[0..1])
					log "Two Digit Country Code: #{self.number[0..1]}"
					country_code = "+" + self.number[0..1]
					parts 			 = [nil, self.number[2..-1]]
				else
					# IDK, man
					raise ArgumentError, "Can't parse phone number"
				end
			elsif self.number[0] == '1' && self.number.length == "19252008843".length
				parts = [self.number[1..3], self.number[4..-1]]
			elsif self.number.length == "9252008843".length
				parts = [self.number[0..2], self.number[3..-1]]
			end
			log "Area Code:  #{parts[0]}"
			log "Local Code: #{parts[1]}"

			Phones::Phone.new(:country_code => country_code, :area_code => parts[0], :local_code => parts[1])
		rescue
		end

		def self.strip!
			self.number.gsub!(IGNORABLE_CHARACTERS, '')
		end

		def self.log(message)
			puts message if @verbose
		end

		# Source: http://en.wikipedia.org/wiki/List_of_country_calling_codes
		COUNTRY_CODES = %w(77 20 210 211 212 213 216 218 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 260 261 262 263 264 265 266 267 268 269 27 290 291 297 298 299 30 31 32 33 34 350 351 352 353 354 355 356 357 358 359 36 370 371 372 373 374 375 376 377 378 379 380 381 382 385 386 387 388 389 40 41 420 421 423 43 44 45 46 47 48 49 500 501 502 503 504 505 506 507 508 509 51 52 53 54 55 56 57 58 590 591 592 593 594 595 596 597 598 599 60 61 62 63 64 65 66 670 672 673 674 675 676 677 678 679 680 681 682 683 685 686 687 688 689 690 691 692 800 808 81 82 84 850 852 853 855 856 86 870 878 880 881 882 883 886 888 90 91 92 93 94 95 960 961 962 963 964 965 966 967 968 970 971 972 973 974 975 976 977 979 98 991 992 993 994 995 996 998).freeze
	end
end