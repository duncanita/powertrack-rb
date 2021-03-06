## General

* _[DONE]_ Rely upon MultiJson for JSON encoding and decoding
* Support thread-safe streams

  A single stream used in several threads to perform several simultaneous actions
  like consuming the stream while changing its rules.

  It's currently impossible due to EventMachine. A transition to Celluloid::IO and
  http.rb is required to be thread-friendly.

## Rules

* _[DONE]_ Check rule size
* _[DONE]_ Add 1 or more rules to a stream
* _[DONE]_ Delete some rules from the stream
* _[DONE]_ Get all existing rules for a stream
* _[DONE]_ Rules equality and usage in hash as keys
* Rule encoding (UTF-8 enforcement ?)
* Double check a rule supports all the syntactical and semantic restrictions
  as defined by GNIP [PowerTrack Rules](http://support.gnip.com/apis/powertrack/rules.html#Restrictions)
  reference documentation
* Support evolution of rules in terms of addition, removal and updates.

## Real-time PowerTrack

* _[DONE]_ Manage persitent connection to a data stream. See
  [Powertrack API reference](http://support.gnip.com/apis/powertrack/api_reference.html)
* _[DONE]_ [Consume streaming data](http://support.gnip.com/apis/consuming_streaming_data.html)
* _[DONE]_ Capture heartbeat activities
* _[DONE]_ Capture system-related activities

## Compliance activities

See [Honoring user intent on Twitter](http://support.gnip.com/articles/honoring-user-intent-on-twitter.html)
and [Compliance Activities](http://support.gnip.com/sources/twitter/data_format.html#ComplianceActivities).

* _[DROPPED]_ Add a comply method to PowerTrack::API ?
  The compliance activities are broadcasted on a specific compliance stream.
* Support the Compliance Firehose stream
  [Compliance Firehose Reference](http://support.gnip.com/apis/compliance_firehose/api_reference.html)

### Account

* Protect / Unprotect account
* Delete account
* Scrub geo
* Suspend account
* Withhold account

### Status

* Delete status
* Withhold status

## Data formats

See [Data format](http://support.gnip.com/sources/twitter/data_format.html)

* _[DONE]_ Support Original output format
* _[DONE]_ Support Activity Stream output format
* _[DONE]_ Support raw format

* _[OUT]_ Manage retweets.
  See [Identifying and Understanding retweets](http://support.gnip.com/articles/identifying-and-understanding-retweets.html)

## Disconnections

See [Managing disconnections](http://support.gnip.com/articles/disconnections-explained.html)

* _[DONE]_ Reconnect after disconnect. See
  [Disconnections & Reconnecting](http://support.gnip.com/apis/consuming_streaming_data.html#Disconnections)
* _[DONE]_ Reconnect using an exponential backoff pattern.
* _[DONE]_ Support Backfill (v1)
* _[DONE]_ Support Replay (v1)
* Reconnect when there's a GNIP server issue signaled by the 503 HTTP response status

## Other features

* _[DONE]_ Support test and development streams
* _[DONE]_ Support Replay mode (5-days back history)
* Support status dashboard
* Support Historical PowerTrack

## PowerTrack v2
See [Migration Guide](http://support.gnip.com/apis/powertrack2.0/transition.html)
and [PowerTrack API v2](http://support.gnip.com/apis/powertrack2.0/index.html).

* _[DONE]_ Support both v1 and v2 with the same interface/class
* _[DONE]_ Support new endpoint URLs
* Support rule validator
* Support new operators and quoted tweet filtering.
  Double-check with tests that the gem does not prevent their usage
* _[DONE]_ Support new backfill behavior
  * _[DONE]_ Support fixed backfill period used at first connection
  * _[DONE]_ Support fixed backfill period used at each reconnect
  * Support dynamic backfill period at each reconnect, calibrated according to
    the number of minutes the stream was disconnected. Emit a warning if the
    stream was disconnected more than 5 minutes (tweets were probably lost)
* _[DONE]_ Use HTTP POST verb (instead of DELETE) for rule deletions
* _[DONE]_ Fallback to v1 when Replay mode wants to use v2. Emit a warning.
* _[DONE]_ Support Replay v2
  [Replay API 2.0 Reference](http://support.gnip.com/apis/replay2.0/api_reference.html)
