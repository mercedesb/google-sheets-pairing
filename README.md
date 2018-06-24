# google-sheets-pairing

# Project Title

A simple ruby CLI app for maximally matching data from Google sheets.

The main runner (`matcher.rb`) is currently set up and configured to read Dev Together event registrations and match mentors and mentees based on the languages and frameworks they have in common.

The code uses an iteration on the Edmonds matrix in order to calculate a maximum bipartite matching of the 2 data sets.

## Getting Started

Clone the repo and run 
```
bundle install
```

You'll need to create a Google client secret in order to use the Sheets API. [Follow step 1 here](https://developers.google.com/sheets/api/quickstart/ruby)

Copy the client_secret.json into the root of the repo.

## Usage
```
ruby matcher.rb
```

You will be prompted for a Mentor Sheet Id and a Mentee Sheet Id. These can be found in the url of your Google Sheets.

```https://docs.google.com/spreadsheets/d/the_id_is_found_here_and_is_rather_long/edit#gid=0
```

## Running the tests

```
bundle exec rspec
```

## Built With

* Ruby
* [Google Sheets Api](https://developers.google.com/sheets/api/samples/)


## Authors

* **Mercedes Bernard** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Max Bipartite Matching Algorithm inspired by: https://www.geeksforgeeks.org/maximum-bipartite-matching/
