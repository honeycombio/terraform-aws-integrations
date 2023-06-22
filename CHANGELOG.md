<a name="v0.5.0"></a>
# [v0.5.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.5.0) - 22 June 2023

## Changes

- feature: Provide interface to the sample rate rules to this module [@nlincoln](https://github.cim/nlincoln) ([#47](https://github.com/honeycombio/terraform-aws-integrations/issues/47))


[Changes][v0.5.0]


<a name="v0.4.0"></a>
# [v0.4.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.4.0) - 11 May 2023

## Changes

- fix: be explicit about S3 access policies [@dstrelau](https://github.com/dstrelau) ([#45](https://github.com/honeycombio/terraform-aws-integrations/issues/45))
  - This is technically a breaking change, in that it changes the exact resources created by the root module, but AWS changed the defaults of S3 buckets such that the old version does not work. The new resources match the new AWS defaults and are functionally equivalent to the old ones (ensuring the S3 is completely private). Only users of the root module should see a diff. Individual sub-modules are not effected.


[Changes][v0.4.0]


<a name="v0.3.0"></a>
# [v0.3.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.3.0) - 16 Mar 2023

## Changes

- Supporting running lambda in a vpc [@ryan-keswick](https://github.com/ryan-keswick) ([#41](https://github.com/honeycombio/terraform-aws-integrations/issues/41))
- [build] add repo name and repo link to asana task [@brookesargent](https://github.com/brookesargent) ([#39](https://github.com/honeycombio/terraform-aws-integrations/issues/39))


[Changes][v0.3.0]


<a name="v0.2.8"></a>
# [v0.2.8 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.8) - 15 Dec 2022

## Changes

- Remove 'pro/enterprise only' disclaimer for metrics [@jharley](https://github.com/jharley) ([#37](https://github.com/honeycombio/terraform-aws-integrations/issues/37))
- [ci] update workflow to work for pull\_request\_target [@brookesargent](https://github.com/brookesargent) ([#36](https://github.com/honeycombio/terraform-aws-integrations/issues/36))
- [ci] send Github issues and PRs to Asana [@brookesargent](https://github.com/brookesargent) ([#35](https://github.com/honeycombio/terraform-aws-integrations/issues/35))


[Changes][v0.2.8]


<a name="v0.2.7"></a>
# [v0.2.7 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.7) - 23 Nov 2022

## Changes

- README Improvements [@mjingle](https://github.com/mjingle) ([#32](https://github.com/honeycombio/terraform-aws-integrations/issues/32))


[Changes][v0.2.7]


<a name="v0.2.6"></a>
# [v0.2.6 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.6) - 22 Nov 2022

## Changes

- Include readmes for the examples and OSS metadata [@mjayaram](https://github.com/mjayaram) ([#30](https://github.com/honeycombio/terraform-aws-integrations/issues/30))
- fix postgresql example [@brookesargent](https://github.com/brookesargent) ([#29](https://github.com/honeycombio/terraform-aws-integrations/issues/29))


[Changes][v0.2.6]


<a name="v0.2.5"></a>
# [v0.2.5 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.5) - 21 Nov 2022

## Changes

- Fix links to images in the README [@mjayaram](https://github.com/mjayaram) ([#27](https://github.com/honeycombio/terraform-aws-integrations/issues/27))


[Changes][v0.2.5]


<a name="v0.2.4"></a>
# [v0.2.4 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.4) - 21 Nov 2022

## Changes

- update tf docs [@mjayaram](https://github.com/mjayaram) ([#25](https://github.com/honeycombio/terraform-aws-integrations/issues/25))
- make cloudwatch logs optional at root [@brookesargent](https://github.com/brookesargent) ([#24](https://github.com/honeycombio/terraform-aws-integrations/issues/24))
- update loadbalancer logs readme to be generic [@mjayaram](https://github.com/mjayaram) ([#21](https://github.com/honeycombio/terraform-aws-integrations/issues/21))
- update all readme [@brookesargent](https://github.com/brookesargent) ([#23](https://github.com/honeycombio/terraform-aws-integrations/issues/23))
- add logs in a bucket to main module [@brookesargent](https://github.com/brookesargent) ([#22](https://github.com/honeycombio/terraform-aws-integrations/issues/22))
- add to /examples [@brookesargent](https://github.com/brookesargent) ([#17](https://github.com/honeycombio/terraform-aws-integrations/issues/17))


[Changes][v0.2.4]


<a name="v0.2.3"></a>
# [v0.2.3 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.3) - 18 Nov 2022

## Changes

- [s3-logfile] allow cloudfront parser [@dstrelau](https://github.com/dstrelau) ([#20](https://github.com/honeycombio/terraform-aws-integrations/issues/20))
- Clarify s3-logfile var.name [@dstrelau](https://github.com/dstrelau) ([#18](https://github.com/honeycombio/terraform-aws-integrations/issues/18))
- Relax and variable-ize s3-logfile filter\_suffix [@dstrelau](https://github.com/dstrelau) ([#19](https://github.com/honeycombio/terraform-aws-integrations/issues/19))
- try to avoid infinite diffs [@dstrelau](https://github.com/dstrelau) ([#16](https://github.com/honeycombio/terraform-aws-integrations/issues/16))
- [docs] RDS readme [@brookesargent](https://github.com/brookesargent) ([#15](https://github.com/honeycombio/terraform-aws-integrations/issues/15))


[Changes][v0.2.3]


<a name="v0.2.2"></a>
# [v0.2.2 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.2) - 14 Nov 2022

## Fixes

- Correctly pass honeycomb\_api\_host through to CW Logs module [@dstrelau](https://github.com/dstrelau) ([#14](https://github.com/honeycombio/terraform-aws-integrations/issues/14))


[Changes][v0.2.2]


<a name="v0.2.1"></a>
# [v0.2.1 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.1) - 14 Nov 2022

## Changes

- remove `startswith()` usage to support older TFs [@dstrelau](https://github.com/dstrelau) ([#13](https://github.com/honeycombio/terraform-aws-integrations/issues/13))


[Changes][v0.2.1]


<a name="v0.2.0"></a>
# [v0.2.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.0) - 11 Nov 2022

## Changes

- RDS Logs Lambda Transform [@brookesargent](https://github.com/brookesargent) ([#7](https://github.com/honeycombio/terraform-aws-integrations/issues/7))


[Changes][v0.2.0]


<a name="v0.1.0"></a>
# [v0.1.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.1.0) - 08 Nov 2022

## Changes

- first draft of module readmes [@mjayaram](https://github.com/mjayaram) ([#10](https://github.com/honeycombio/terraform-aws-integrations/issues/10))
- Rename lb-logs -> s3-logfile [@dstrelau](https://github.com/dstrelau) ([#11](https://github.com/honeycombio/terraform-aws-integrations/issues/11))
- add cloudwatch metrics + KFH submodules [@dstrelau](https://github.com/dstrelau) ([#6](https://github.com/honeycombio/terraform-aws-integrations/issues/6))
- Include docs generation config and USAGE docs for submodules [@mjayaram](https://github.com/mjayaram) ([#8](https://github.com/honeycombio/terraform-aws-integrations/issues/8))
- Setup path to prod for modules [@mjayaram](https://github.com/mjayaram) ([#5](https://github.com/honeycombio/terraform-aws-integrations/issues/5))
- Adds expected nested module structure to allow for publish/use of submodules [@mjayaram](https://github.com/mjayaram) ([#4](https://github.com/honeycombio/terraform-aws-integrations/issues/4))
- Extending CW Logs to Honeycomb Module to take a list of log groups [@mjayaram](https://github.com/mjayaram) ([#3](https://github.com/honeycombio/terraform-aws-integrations/issues/3))
- Sets up module to send logs from ONE log group to Honeycomb via Kinesis [@mjayaram](https://github.com/mjayaram) ([#2](https://github.com/honeycombio/terraform-aws-integrations/issues/2))
- [lb] Add agentless LB module [@dstrelau](https://github.com/dstrelau) ([#1](https://github.com/honeycombio/terraform-aws-integrations/issues/1))


[Changes][v0.1.0]


<a name="v0.0.1"></a>
# [v0.0.1](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.0.1) - 02 Nov 2022

First release 🎉 

[Changes][v0.0.1]


[v0.4.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.3.0...v0.4.0
[v0.3.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.8...v0.3.0
[v0.2.8]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.7...v0.2.8
[v0.2.7]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.6...v0.2.7
[v0.2.6]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.5...v0.2.6
[v0.2.5]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.4...v0.2.5
[v0.2.4]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.3...v0.2.4
[v0.2.3]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.2...v0.2.3
[v0.2.2]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.0.1...v0.1.0
[v0.0.1]: https://github.com/honeycombio/terraform-aws-integrations/tree/v0.0.1

<!-- Generated by https://github.com/rhysd/changelog-from-release v3.7.1 -->
