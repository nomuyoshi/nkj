# NKJ
NKJ can judge given chars are included in JIS X 0213 or not.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'nkj'
```

Or install it yourself as: 

```
gem install nkj
```

## Usage

```ruby
require 'nkj'

# `jisx0213?` returns a boolean value whether or not the given all chars are included in JIS X 0213.
NKJ.jisx0213?('aあ!庵') #=> true
NKJ.jisx0213?('髙') #=> false

# `level1?` returns whether or not the given all chars are included Japanse Level1 Kanji.(第一水準)
NKJ.level1?('山') #=> true

# `level2?` returns whether or not the given all chars are included Japanse Level2 Kanji.(第二水準)
NKJ.level2?('丼') #=> true

# `level3?` returns whether or not the given all chars are included Japanse Level3 Kanji.(第三水準)
NKJ.level3?('﨑') #=> true

# `level4?` returns whether or not the given all chars are included Japanse Level4 Kanji.(第四水準)
NKJ.level4?('挻') #=> true
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).


## Special Thanks
NKJ uses "JIS X 0213 Code Mapping Tables" which created by Project X0213.
https://x0213.org/codetable/index.en.html