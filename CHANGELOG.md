<a name="v0.2.4"></a>
# [v0.2.4 🌈 (v0.2.4)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.2.4) - 18 Nov 2022

## Changes

- update tf docs [@mjayaram](https://github.com/mjayaram) ([#25](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/25))
- make cloudwatch logs optional at root [@brookesargent](https://github.com/brookesargent) ([#24](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/24))
- update all READMEs [@brookesargent](https://github.com/brookesargent) ([#23](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/23))
- add logs in a bucket to main module [@brookesargent](https://github.com/brookesargent) ([#22](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/22))
- update loadbalancer logs readme to be generic [@mjayaram](https://github.com/mjayaram) ([#21](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/21))
- add to `/examples` [@brookesargent](https://github.com/brookesargent) ([#17](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/17))


[Changes][v0.2.4]


<a name="v0.2.3"></a>
# [v0.2.3 🌈 (v0.2.3)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.2.3) - 18 Nov 2022

## Changes

- [s3-logfile] allow cloudfront parser [@dstrelau](https://github.com/dstrelau) ([#20](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/20))
- Clarify s3-logfile var.name [@dstrelau](https://github.com/dstrelau) ([#18](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/18))
- Relax and variable-ize s3-logfile filter\_suffix [@dstrelau](https://github.com/dstrelau) ([#19](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/19))
- try to avoid infinite diffs [@dstrelau](https://github.com/dstrelau) ([#16](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/16))
- [docs] RDS readme [@brookesargent](https://github.com/brookesargent) ([#15](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/15))


[Changes][v0.2.3]


<a name="v0.2.2"></a>
# [v0.2.2 🌈 (v0.2.2)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.2.2) - 14 Nov 2022

## Fixes

- Correctly pass honeycomb\_api\_host through to CW Logs module [@dstrelau](https://github.com/dstrelau) ([#14](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/14))


[Changes][v0.2.2]


<a name="v0.2.1"></a>
# [v0.2.1 🌈 (v0.2.1)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.2.1) - 14 Nov 2022

## Changes

- remove `startswith()` usage to support older TFs [@dstrelau](https://github.com/dstrelau) ([#13](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/13))


[Changes][v0.2.1]


<a name="v0.2.0"></a>
# [v0.2.0 🌈 (v0.2.0)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.2.0) - 11 Nov 2022

## Changes

- RDS Logs Lambda Transform [@brookesargent](https://github.com/brookesargent) ([#7](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/7))


[Changes][v0.2.0]


<a name="v0.1.0"></a>
# [v0.1.0 🌈 (v0.1.0)](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/releases/tag/v0.1.0) - 08 Nov 2022

## Changes

- first draft of module readmes [@mjayaram](https://github.com/mjayaram) ([#10](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/10))
- Rename lb-logs -> s3-logfile [@dstrelau](https://github.com/dstrelau) ([#11](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/11))
- add cloudwatch metrics + KFH submodules [@dstrelau](https://github.com/dstrelau) ([#6](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/6))
- Include docs generation config and USAGE docs for submodules [@mjayaram](https://github.com/mjayaram) ([#8](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/8))
- Setup path to prod for modules [@mjayaram](https://github.com/mjayaram) ([#5](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/5))
- Adds expected nested module structure to allow for publish/use of submodules [@mjayaram](https://github.com/mjayaram) ([#4](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/4))
- Extending CW Logs to Honeycomb Module to take a list of log groups [@mjayaram](https://github.com/mjayaram) ([#3](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/3))
- Sets up module to send logs from ONE log group to Honeycomb via Kinesis [@mjayaram](https://github.com/mjayaram) ([#2](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/2))
- [lb] Add agentless LB module [@dstrelau](https://github.com/dstrelau) ([#1](https://github.com/honeycombio/terraform-aws-honeycomb-integrations/issues/1))


[Changes][v0.1.0]


[v0.2.4]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/compare/v0.2.3...v0.2.4
[v0.2.3]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/compare/v0.2.2...v0.2.3
[v0.2.2]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/compare/v0.2.1...v0.2.2
[v0.2.1]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/compare/v0.2.0...v0.2.1
[v0.2.0]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/compare/v0.1.0...v0.2.0
[v0.1.0]: https://github.com/honeycombio/terraform-aws-honeycomb-integrations/tree/v0.1.0

 <!-- Generated by https://github.com/rhysd/changelog-from-release -->
