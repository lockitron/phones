# Phones

Phones is a barebones phone parsing and formatting library. If the phone is number is outside of the United States, it must include the country code prefixed with a "+"

It can parse phone numbers like:
- (555) 555-5555
- 555-555-5555
- 555.555.5555
- 555-555.5555
- 19252008843
- 1-(925)-200-8843
- +49 69 6900
- +49696900
- +19252008843

And any combination between those.

## Installation

First, install it:
```bash
gem install phones
```

In your Gemfile:
```ruby
gem 'phones', :require => 'phones'
```

## Usage

It adds a ```to_phone``` method to ```String```, so you can just do:
```ruby
"1-(925)-200-8843".to_phone
=> +19252008843
```

Pretty printing phone numbers:
```ruby
"1-(925)-200-8843".to_phone.pretty
=> "(925) 200-8843"
```

Country code, area code, local code:
```ruby
phone = "1-(925)-200-8843".to_phone
=> +19252008843
phone.country_code
=> "+1"
phone.area_code
=> "925"
phone.local_code
=> "2008843"
```

Note: ```area_code``` and ```local_code``` is currently only supported for US phone numbers. International phone numbers will have a ```nil``` area_code and ```local_code``` will contain the rest of the phone number. ```country_code``` should work for every country code. 

It'll return nil if it couldn't detect a valid phone number.



