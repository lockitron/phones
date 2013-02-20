module Phones
	class Phone
		RESTRICTED_CHARACTERS = /\-|\(|\)|\.|\s|[a-zA-Z]/.freeze
		attr_reader :country_code, :area_code, :local_code

		def initialize(opts = {})
			self.country_code = opts[:country_code]
			self.area_code    = opts[:area_code]
			self.local_code 	= opts[:local_code]
		end

		def country_code=(val)
			@country_code = val
			validate_country_code!
		end

		def area_code=(val)
			@area_code = val
			validate_area_code!
		end

		def local_code=(val)
			if val.class == Array
				@local_code = val.join("")
			else
				@local_code = val
			end
			validate_local_code!
		end

		def pretty
			if self.united_states?
				"(#{self.area_code}) #{self.local_code[0..2]}-#{self.local_code[3..-1]}"
			else
				self.to_s
			end
		end

		def to_s
			"#{self.country_code}#{self.area_code}#{self.local_code}"
		end

		def united_states?
			self.country_code == "+1"
		end

		private

		# We know that this isn't a phone number because certain characters don't exist in phone numbers.
		# These validations check for that.

		def validate_country_code!
			raise ArgumentError, "Country code: #{@country_code} contains restricted characters" if self.country_code =~ RESTRICTED_CHARACTERS && self.country_code.length > 3
		end

		def validate_area_code!
			raise ArgumentError, "Area code: #{@area_code} contains restricted characters" if self.area_code =~ RESTRICTED_CHARACTERS
		end

		def validate_local_code!
			raise ArgumentError, "Local code: #{@local_code} contains restricted characters" if self.local_code =~ RESTRICTED_CHARACTERS
			raise ArgumentError, "Local code cannot be blank" if self.local_code.nil? || self.local_code.length == 0
		end

	end
end
