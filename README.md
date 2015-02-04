# Word Count Captcha

## Setup:
- Pull down the repository
- Make sure you are using ruby 2.1.2
- Install dependencies `bundle install`
- Run specs `rspec`
- Run app `ruby app.rb`

## Included:
- Cheat protection and statelessness

## Assumptions / Decisions:
- I assumed that the texts would be random and arbitrary.  The app is intended to work even if you replace the existing files from `/texts` with a new set.
- I made the assumption of case insensitivity.  "Word" is the same as "word", and the exclusion and frequency lists all use the downcased versions of words.
- I made the assumption that words are only made up of letters.  All other chars are removed when parsing the text.
- The length of the excluded list is around 10% (though at least 1 for smaller texts and 0 for 1-unique-word texts).
- I used index position to choose excluded words.  Originally, I had thought about using rules such as number of vowels or word length, but in the end I chose a strategy that was better at avoiding edge cases (such as if all the words have a ton of vowels, or if the text has a lot of really short words).
- I included both functional tests using different param cases and unit tests for model methods.

## Next:
- Refactor app to use a modular Sinatra style organization to avoid having public class methods exported to the top level.
- Potentially revisit the way excluded words are chosen in order to be less predictable.
- Clean up `POST '/'` action (not DRY and the flow could have more clarity).
