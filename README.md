# Foreman Host Rundeck

Creates a yaml representation of rundeck on hosts

* Website: [TheForeman.org](http://theforeman.org)
* ServerFault tag: [Foreman](http://serverfault.com/questions/tagged/foreman)
* Issues: [foreman_rundeck Redmine](http://projects.theforeman.org/projects/rundeck/issues)
* Wiki: [Foreman wiki](http://projects.theforeman.org/projects/foreman/wiki/About)
* Community and support: #theforeman for general support, #theforeman-dev for development chat in [Freenode](irc.freenode.net)
* Mailing lists:
    * [foreman-users](https://groups.google.com/forum/?fromgroups#!forum/foreman-users)
    * [foreman-dev](https://groups.google.com/forum/?fromgroups#!forum/foreman-dev)

## Installation

Please see the Foreman manual for appropriate instructions:

* [Foreman: How to Install a Plugin](http://theforeman.org/plugins/)

### Red Hat, CentOS, Fedora, Scientific Linux (rpm)

Set up the repo as explained in the link above, then run (on 1.10+):

    # yum install tfm-rubygem-foreman_host_rundeck

On 1.9:

    # yum install ruby193-rubygem-foreman_host_rundeck

### Debian, Ubuntu (deb)

Set up the repo as explained in the link above, then run:

    # apt-get install ruby-foreman-host-rundeck

### Bundle (gem)

Add the following to bundler.d/Gemfile.local.rb in your Foreman installation directory (/usr/share/foreman by default)

    $ gem 'foreman_host_rundeck'

Then run `bundle install` and `foreman-rake db:migrate` from the same directory

--------------

To verify that the installation was successful, go to Foreman, top bar **Administer > About** and check 'foreman_host_rundeck' shows up in the **System Status** menu under the Plugins tab.

## Usage

[Our wiki covers the basics of Rundeck integration](http://projects.theforeman.org/projects/foreman/wiki/Rundeck_Integration)

## Contributing

Fork and send a Pull Request. Thanks!

## Copyright

Copyright (c) 2014 Red Hat

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

