# google-sheets-pairing

A simple ruby CLI app for maximally matching data from Google sheets.

The matcher (`matcher.rb`) is currently set up and configured to read Dev Together event registrations from our Google Form submissions and match mentors and mentees based on the languages and frameworks they have in common.

The code uses an iteration on the Edmonds matrix in order to calculate a maximum bipartite matching of the 2 data sets.

The mailer (`mailer.rb`) reads the the data written from the matcher and creates draft emails for you to send attendees. More info below.

## Getting Started

Clone the repo and run 
```
bundle install
```

You'll need to create a Google client secret in order to use the Sheets and Gmail API. [Follow step 1 here](https://developers.google.com/sheets/api/quickstart/ruby)

Copy the client_secret.json into the root of the repo.

// TODO: Long form steps (https://console.developers.google.com/apis/credentials/wizard ?)

## Usage

### Running the matcher
```
ruby matcher.rb
```

You will be prompted for a Spreadsheet Id. This can be found in the url of your Google Sheets.

https://docs.google.com/spreadsheets/d/**the_id_is_found_here_and_is_rather_long**/edit#gid=0

You can also pass the argument in rather than wait for input `ruby matcher.rb SPREADSHEET_ID`

### Running the mailer
```
ruby mailer.rb
```
You will be prompted for a Spreadsheet Id. This can be found in the url of your Google Sheets.

https://docs.google.com/spreadsheets/d/**the_id_is_found_here_and_is_rather_long**/edit#gid=0

You can also pass the argument in rather than wait for input `ruby mailer.rb SPREADSHEET_ID`

#### First time running
The first time you run either script (`matcher.rb` or `mailer.rb`) you will see a message for each API used prompting you to click a link and enter the resulting code after authorization. This is granting the Google API access to your Google account in order to write to your spreadsheet (for the Sheets API) and to create drafts in your mailbox (for the Gmail API). 

Follow the link provided, then copy paste the resulting code into your terminal. This will create a file containing the token and you should only need to do this once. 

Do not commit your token files to a repo. They should be git ignored.

## Running the tests

```
bundle exec rspec
```

## Built With

* Ruby
* [Google Sheets Api](https://developers.google.com/sheets/api/samples/)
* [Gmail Api](https://developers.google.com/gmail/api/)
* [Mail](https://github.com/mikel/mail)


## Authors

* **Mercedes Bernard** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Max Bipartite Matching Algorithm inspired by: https://www.geeksforgeeks.org/maximum-bipartite-matching/
