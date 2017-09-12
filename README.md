GDPR Sample InSpec Profile
==========================

This Compliance Profile acts as an example for GDPR based best practises. It is purely an 
example and should not be used in any production environments, or relied upon for GDPR
compliance / auditing.

It makes use of example controls in the following profiles.

- https://github.com/dev-sec/linux-baseline
- https://github.com/dev-sec/mysql-baseline
- https://github.com/dev-sec/ssh-baseline
- https://github.com/dev-sec/ssl-baseline

Thanks to the great Dev-Sec project for all their great work: https://github.com/dev-sec

## Standalone Usage

This Compliance Profile requires [InSpec](https://github.com/chef/inspec) for execution:

```
$ git clone https://github.com/grdnrio/gdpr-inspec-profile.git
$ inspec exec gdpr-inspec-profile
```

You can also execute the profile directly from Github:

```
$ inspec exec https://github.com/grdnrio/gdpr-inspec-profile.git
```

## License and Author

* Author:: Joe Gardiner <joe@grdnr.io>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.