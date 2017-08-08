# signalsciences

[![Build Status](https://travis-ci.org/signalsciences/signalsciences-cookbook.svg?branch=master)](https://travis-ci.org/signalsciences/signalsciences-cookbook)

The signalsciences cookbook installs and configures Signal Sciences in your infrastructure.

## SCOPE

This cookbook is intended to install Signal Sciences agent and module.

## Requirements

* RHEL
* Centos
* Ubuntu
* Debian

## Dependencies

* apt cookbook

## Usage

Include this cookbook in your runlist and make sure you set these attributes.

### Required Attributes
| Key | Description |
| --- | ----------- |
| `['signalsciences']['access_key']` | Your site access key token |
| `['signalsciecnes']['secret']`     | Your site secret token |

## Testing

For more details look at the [TESTING.md](./TESTING.md).

## License & Authors

If you would like to see the detailed LICENSE click [here](./LICENSE).

- Author:: Signal Sciences Corp. <support@signalsciences.com>

```text
Copyright:: Signal Sciences Corp.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
