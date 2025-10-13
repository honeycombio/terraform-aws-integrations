<a id="v2.0.0"></a>
# [v2.0.0 🛠️](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v2.0.0) - 2025-10-13

⚠️
This release updates the hashicorp/aws dependency from v5.0 ~> v6.0 which introduces breaking changes to the AWS module's API.
There are no changes to the API of the Honeycomb module itself.
Upgrade to this release of the Honeycomb module when you are ready to [migrate to v6 of the AWS module](https://registry.terraform.io/providers/hashicorp/aws/6.16.0/docs/guides/version-6-upgrade).

## Changes

- maint(deps): Update hashicorp/AWS to v6 (#101) | @MikeGoldsmith

[Changes][v2.0.0]

<a id="v1.5.2"></a>
# [v1.5.2 🛠️](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.5.2) - 2025-10-13

## Changes

- maint(deps): revert upgrade to hashicorp/AWS module v6 (#99) | @MikeGoldsmith

[Changes][v1.5.2]

<a id="v1.5.1"></a>
# [v1.5.1 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.5.1) - 2025-10-06

## Changes

- maint: remove upper bound on hashicorp/aws provider version constraint (#94) | @robbkidd 
- feat(kinesis): add App Runner OpenTelemetry collector for multiplexing (#95) | @lizthegrey

[Changes][v1.5.1]

<a id="v1.5.0"></a>
# [v1.5.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.5.0) - 2025-07-03

## Changes

- feat(kinesis): allow multiple sinks for one firehose (#89) | @lizthegrey
- feat: implements terraform to set LINE_FILTER_RULES (#87) | @mterhar
- maint: Limit hashicorp/aws provider to 5.x versions (#91) | @MikeGoldsmith
- maint: Update generated usage docs (#90) | @MikeGoldsmith

[Changes][v1.5.0]

<a id="v1.3.1"></a>
# [v1.3.1 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.3.1) - 2024-12-19

## Changes

- maint: Fix formating in cloudwatch logs [@MikeGoldsmith](https://github.com/MikeGoldsmith) ([#79](https://github.com/honeycombio/terraform-aws-integrations/issues/79))
- fix: Add opt-in config to create order independent log filters [@aburgel](https://github.com/aburgel) ([#78](https://github.com/honeycombio/terraform-aws-integrations/issues/78))
- fix: pin dependant modules to reduce churn [@jharley](https://github.com/jharley) ([#76](https://github.com/honeycombio/terraform-aws-integrations/issues/76))
- docs: update vulnerability reporting process [@robbkidd](https://github.com/robbkidd) ([#75](https://github.com/honeycombio/terraform-aws-integrations/issues/75))


[Changes][v1.4.0]


<a id="v1.4.0"></a>
# [v1.4.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.4.0) - 2025-03-18

## Changes

NOTE: the cloudwatch-metrics output format `opentelemetry0.7` has been removed.
If you previously used this output format value, you will need to update to the newer `opentelemetry1.0` format.

- maint: Remove OpenTelemetry 0.7 data format [@MikeGoldsmith] ([#83](https://github.com/honeycombio/terraform-aws-integrations/issues/83))

## 🚀 Features

- feat: Allow resource names to be overridden when installing top-level module [@yotamat] ([#85](https://github.com/honeycombio/terraform-aws-integrations/issues/85))


[Changes][v1.3.1]


<a id="v1.3.0"></a>
# [v1.3.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.3.0) - 2024-04-18

## Changes

NOTE: the default output format of the cloudwatch-metrics stream has be updated to `opentelemetry1.0`.
If you had overridden this value consider making the same change to avoid losing metric stream events in the future.

## 🚀 Features

- cloudwatch-metrics - stream opentelemetry1.0 [@jharley](https://github.com/jharley) ([#70](https://github.com/honeycombio/terraform-aws-integrations/issues/70))


[Changes][v1.3.0]


<a id="v1.2.1"></a>
# [v1.2.1 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.2.1) - 2023-11-28

## Changes

- bug: give lambda parameters a fixed order [@RainofTerra](https://github.com/RainofTerra) ([#64](https://github.com/honeycombio/terraform-aws-integrations/issues/64))


[Changes][v1.2.1]


<a id="v1.2.0"></a>
# [v1.2.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.2.0) - 2023-10-17

## Changes

- maint: upgrade from go1.x to provided.al2 [@brookesargent](https://github.com/brookesargent) ([#65](https://github.com/honeycombio/terraform-aws-integrations/issues/65))


[Changes][v1.2.0]


<a id="v1.1.0"></a>
# [v1.1.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.1.0) - 2023-07-05

## Changes

- feature: CloudWatch Metrics metric-level filter support [@jharley](https://github.com/jharley) ([#58](https://github.com/honeycombio/terraform-aws-integrations/issues/58))

[Changes][v1.1.0]


<a id="v1.0.0"></a>
# [v1.0.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v1.0.0) - 2023-06-23

## Changes

- feature: support AWS Provider 5.x [@jharley](https://github.cim/jharley) | ([#53](https://github.com/honeycombio/terraform-aws-integrations/issues/53))
- feature: Moving `s3_configuration {}` from root block to `http_endpoint_configuration` [@ryan-keswick](https://github.com/ryan-keswick) | ([#49](https://github.com/honeycombio/terraform-aws-integrations/issues/49))

📣 This drops support for AWS Provider 4.x. If you are still on v4 of the AWS provider, please continue to use `v0.5.0` of this module.

[Changes][v1.0.0]


<a id="v0.5.0"></a>
# [v0.5.0🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.5.0) - 2023-06-22

## Changes

- feat: Provide interface to the sample rate rules to this module [@NLincoln](https://github.com/NLincoln) ([#47](https://github.com/honeycombio/terraform-aws-integrations/issues/47))


[Changes][v0.5.0]


<a id="v0.4.0"></a>
# [v0.4.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.4.0) - 2023-05-11

## Changes

- fix: be explicit about S3 access policies [@dstrelau](https://github.com/dstrelau) ([#45](https://github.com/honeycombio/terraform-aws-integrations/issues/45))
  - This is technically a breaking change, in that it changes the exact resources created by the root module, but
AWS changed the defaults of S3 buckets such that the old version does not work. The new resources match the new AWS defaults and are functionally equivalent to the old ones (ensuring the S3 is completely private). Only users of the root module should see a diff. Individual sub-modules are not effected.

[Changes][v0.4.0]


<a id="v0.3.0"></a>
# [v0.3.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.3.0) - 2023-03-16

## Changes

- Supporting running lambda in a vpc [@ryan-keswick](https://github.com/ryan-keswick) ([#41](https://github.com/honeycombio/terraform-aws-integrations/issues/41))
- [build] add repo name and repo link to asana task [@brookesargent](https://github.com/brookesargent) ([#39](https://github.com/honeycombio/terraform-aws-integrations/issues/39))


[Changes][v0.3.0]


<a id="v0.2.8"></a>
# [v0.2.8 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.8) - 2022-12-15

## Changes

- Remove 'pro/enterprise only' disclaimer for metrics [@jharley](https://github.com/jharley) ([#37](https://github.com/honeycombio/terraform-aws-integrations/issues/37))
- [ci] update workflow to work for pull\_request\_target [@brookesargent](https://github.com/brookesargent) ([#36](https://github.com/honeycombio/terraform-aws-integrations/issues/36))
- [ci] send Github issues and PRs to Asana [@brookesargent](https://github.com/brookesargent) ([#35](https://github.com/honeycombio/terraform-aws-integrations/issues/35))


[Changes][v0.2.8]


<a id="v0.2.7"></a>
# [v0.2.7 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.7) - 2022-11-23

## Changes

- README Improvements [@mjingle](https://github.com/mjingle) ([#32](https://github.com/honeycombio/terraform-aws-integrations/issues/32))


[Changes][v0.2.7]


<a id="v0.2.6"></a>
# [v0.2.6 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.6) - 2022-11-22

## Changes

- Include readmes for the examples and OSS metadata [@mjayaram](https://github.com/mjayaram) ([#30](https://github.com/honeycombio/terraform-aws-integrations/issues/30))
- fix postgresql example [@brookesargent](https://github.com/brookesargent) ([#29](https://github.com/honeycombio/terraform-aws-integrations/issues/29))


[Changes][v0.2.6]


<a id="v0.2.5"></a>
# [v0.2.5 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.5) - 2022-11-21

## Changes

- Fix links to images in the README [@mjayaram](https://github.com/mjayaram) ([#27](https://github.com/honeycombio/terraform-aws-integrations/issues/27))


[Changes][v0.2.5]


<a id="v0.2.4"></a>
# [v0.2.4 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.4) - 2022-11-21

## Changes

- update tf docs [@mjayaram](https://github.com/mjayaram) ([#25](https://github.com/honeycombio/terraform-aws-integrations/issues/25))
- make cloudwatch logs optional at root [@brookesargent](https://github.com/brookesargent) ([#24](https://github.com/honeycombio/terraform-aws-integrations/issues/24))
- update loadbalancer logs readme to be generic [@mjayaram](https://github.com/mjayaram) ([#21](https://github.com/honeycombio/terraform-aws-integrations/issues/21))
- update all readme [@brookesargent](https://github.com/brookesargent) ([#23](https://github.com/honeycombio/terraform-aws-integrations/issues/23))
- add logs in a bucket to main module [@brookesargent](https://github.com/brookesargent) ([#22](https://github.com/honeycombio/terraform-aws-integrations/issues/22))
- add to /examples [@brookesargent](https://github.com/brookesargent) ([#17](https://github.com/honeycombio/terraform-aws-integrations/issues/17))


[Changes][v0.2.4]


<a id="v0.2.3"></a>
# [v0.2.3 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.3) - 2022-11-18

## Changes

- [s3-logfile] allow cloudfront parser [@dstrelau](https://github.com/dstrelau) ([#20](https://github.com/honeycombio/terraform-aws-integrations/issues/20))
- Clarify s3-logfile var.name [@dstrelau](https://github.com/dstrelau) ([#18](https://github.com/honeycombio/terraform-aws-integrations/issues/18))
- Relax and variable-ize s3-logfile filter\_suffix [@dstrelau](https://github.com/dstrelau) ([#19](https://github.com/honeycombio/terraform-aws-integrations/issues/19))
- try to avoid infinite diffs [@dstrelau](https://github.com/dstrelau) ([#16](https://github.com/honeycombio/terraform-aws-integrations/issues/16))
- [docs] RDS readme [@brookesargent](https://github.com/brookesargent) ([#15](https://github.com/honeycombio/terraform-aws-integrations/issues/15))


[Changes][v0.2.3]


<a id="v0.2.2"></a>
# [v0.2.2 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.2) - 2022-11-14

## Fixes

- Correctly pass honeycomb\_api\_host through to CW Logs module [@dstrelau](https://github.com/dstrelau) ([#14](https://github.com/honeycombio/terraform-aws-integrations/issues/14))


[Changes][v0.2.2]


<a id="v0.2.1"></a>
# [v0.2.1 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.1) - 2022-11-14

## Changes

- remove `startswith()` usage to support older TFs [@dstrelau](https://github.com/dstrelau) ([#13](https://github.com/honeycombio/terraform-aws-integrations/issues/13))


[Changes][v0.2.1]


<a id="v0.2.0"></a>
# [v0.2.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.2.0) - 2022-11-11

## Changes

- RDS Logs Lambda Transform [@brookesargent](https://github.com/brookesargent) ([#7](https://github.com/honeycombio/terraform-aws-integrations/issues/7))


[Changes][v0.2.0]


<a id="v0.1.0"></a>
# [v0.1.0 🌈](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.1.0) - 2022-11-08

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


<a id="v0.0.1"></a>
# [v0.0.1](https://github.com/honeycombio/terraform-aws-integrations/releases/tag/v0.0.1) - 2022-11-02

First release 🎉 

[Changes][v0.0.1]


[v1.3.1]: https://github.com/honeycombio/terraform-aws-integrations/compare/v1.3.0...v1.3.1
[v1.3.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v1.2.1...v1.3.0
[v1.2.1]: https://github.com/honeycombio/terraform-aws-integrations/compare/v1.2.0...v1.2.1
[v1.2.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v1.1.0...v1.2.0
[v1.1.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v1.0.0...v1.1.0
[v1.0.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.5.0...v1.0.0
[v0.5.0]: https://github.com/honeycombio/terraform-aws-integrations/compare/v0.4.0...v0.5.0
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

<!-- Generated by https://github.com/rhysd/changelog-from-release v3.8.1 -->
