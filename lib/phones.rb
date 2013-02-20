require "phones/version"
require 'active_support'
require 'phones/parser'
require 'phones/phone'
module Phones
end

class String
	def to_phone
		Phones::Parser.parse(self)
	end
end

class NilClass
	def to_phone
		nil
	end
end
