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

## Usage

First, install it:
```bash
gem install phones
```

After requiring it:
```ruby
require 'phones'
```

It adds a ```to_phone``` method to ```String```, so you can just do:
```ruby
	"1-(925)-200-8843".to_phone
	 => +19252008843
```

It'll return nil if it couldn't detect a valid phone number.


