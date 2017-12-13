SETUP:
run the following bash commands in terminal to set secrets.

export QUANDL_API_KEY='yourquandlapikeyhere'
export EMAIL='yourgmailhere@gmail.com'
export EMAIL='yourgmailpasswordhere'

Set "Access for less secure apps" to secure in you Google mail account if needed.


RUN APP:
main.rb is the main application file.
to run: ruby main.rb
Example input format: AAPL 2017-02-01

Remaining TODOs.
- sandbox emails in testing.
- Make handle_response method in ClientRunner class more specific with dealing with errors. Especially in the last part.
- Implement caching in quandl_api_client. Can use Redis for that.
- More units tests. The tests now test the most important parts, but more should be added for each class.
- Move class and module files to a lib folder.
- DataFormatter should probably be a module instead of a class.
- Missed that I was supposed to interact with one more API than Quandl. Quite much, I think. I think the emails is sufficient.
- Create a promt in the CLI asking users for date and ticker.
- clean up comments from spec_helper.
