# Honeycomb AWS Cloudwatch Logs integration module

Assumptions - for general one:
* User specified: Cloudwatch Log Group (setting this up and sending data to this is not included)
* Module creates everything else: 
  * Firehose Stream
  * Permissions
  * Config to point to Honeycomb
  * Backup in S3

Note: Backfilling old data from the Log Groups: currently does not do. New data comes in.

TODO Extension:

* Extend to take a list of Log Groups?
