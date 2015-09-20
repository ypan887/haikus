###Pull Requests, Merging, and PivotalTracker
"Start" a ticket on PivotalTracker and add yourself as an owner

Use the ticket id# to name branches in the following format:
+ feature/ticket_number-INITIALS
+ bugfix/ticket_number-INITIALS

Push branch, open pull request, and "Finish" ticket on PivotalTracker

Once PR is approved, merge PR and "Deliver" ticket on PivotalTracker

Product Manager will Accept or Reject the ticket

--

###To install:

```sh
bundle install
rails s
```

###Verify install:
```sh
curl http://localhost:3000/ping
```
