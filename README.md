# Search JSON

Given some json files in `data/`, you'll be able to search for key and value and display the matching results.

## Install

Developed in Ruby 2.7.

```bash
bundle # Gems installed in local folder for your convenience
bundle binstubs
bin/rspec
open coverage/index.html # If you're interested
ruby search_json.rb
```

## Run

```bash
$ ruby search_json.rb

# Sample output:
Select the file to search users
Enter your search term _id
Enter your search value 11

Matching records:

_id                           11
url                           http://initech.zendesk.com/api/v2/users/11.json
external_id                   f844d39b-1d2c-4908-8719-48b5930bc6a2
name                          Shelly Clements
alias                         Miss Campos
created_at                    2016-06-10T06:50:13 -10:00
active                        true
verified                      true
shared                        true
locale                        zh-CN
timezone                      Moldova
last_login_at                 2016-02-28T04:06:24 -11:00
phone                         9494-882-401
signature                     Don't Worry Be Happy!
organization_id               103
tags                          Camptown; Glenville; Harleigh; Tedrow
suspended                     false
role                          agent
organization_name             Plasmos
assigned_ticket_subjects      A Nuisance in Saint Lucia
submitter_ticket_subjects     A Nuisance in Comoros

# Sample searches:

Select the file to search tickets
Enter your search term assignee_id
Enter your search value 40

Select the file to search organizations
Enter your search term _id
Enter your search value 101
```

Checkout the files in `data/*.json` for inspiration.

Enjoy!
