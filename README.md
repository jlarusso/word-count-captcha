# Word Count Captcha
Detect humans from space trolls, who are bad at counting words.

## Setup:
- Pull down the repository
- Make sure you are using ruby 2.1.2
- Install dependencies `bundle install`
- Run specs `rspec`
- Run app `ruby app.rb` or `./run`

## Assumptions / Decisions:
- I assumed that the texts would be random and arbitrary.  The app is intended to work even if you replace the existing files from `/texts` with a new set.
- I made the assumption of case insensitivity.  "Word" is the same as "word", and the exclusion and frequency lists all use the downcased versions of words.
- I made the assumption that words are only made up of letters.  All other chars are removed when parsing the text.
- The length of the excluded list is around 10% of the original text (though at least 1 word for smaller texts and no words for texts with only one unique word).
- I used index position to choose excluded words.  Originally, I had thought about using rules such as number of vowels or word length, but in the end I chose a strategy that was better at avoiding edge cases (such as if all the words have a ton of vowels, or if the text has a lot of really short words).
- I included both functional tests using different param cases and unit tests for model methods.
- I included a cheat protection mechanism using a SHA digest of a secret token combined with the original body text.  This prevents the use of unauthorized or edited texts and imparts statelessness to the app.
- I removed the erb json templates because I found they were redundant for now.  I was passing the erb an object that was formed exactly like one in the template.  I am using `Hash#to_json` instead.

## Next:
- Refactor app to use a modular Sinatra style organization to avoid having public class methods exported to the top level.
- Potentially revisit the way excluded words are chosen in order to be less predictable.
- Clean up `POST '/'` action (The flow could have more clarity).
- Possibly implement jbuilder for templating.
