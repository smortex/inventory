# Motoko

A gem to get inventories of nodes in a Puppet / Choria deployment.

<!-- vim-markdown-toc GFM -->

* [Installation](#installation)
* [Usage](#usage)
  * [Basic usage](#basic-usage)
    * [Which nodes are currently up and running](#which-nodes-are-currently-up-and-running)
    * [Which nodes are known to puppet](#which-nodes-are-known-to-puppet)
  * [Accessing facts](#accessing-facts)
    * [Add more facts to the output](#add-more-facts-to-the-output)
  * [Filtering](#filtering)
    * [Which nodes have burned in Strasbourg](#which-nodes-have-burned-in-strasbourg)
* [Configuration](#configuration)
  * [Columns](#columns)
  * [Column Specifications](#column-specifications)
  * [Shortcuts](#shortcuts)
* [Resolvers](#resolvers)
  * [Extending Motoko with custom resolvers](#extending-motoko-with-custom-resolvers)
* [Formatters](#formatters)
  * [Extending Motoko with custom formatters](#extending-motoko-with-custom-formatters)
* [Development](#development)
* [Contributing](#contributing)
* [License](#license)
* [Code of Conduct](#code-of-conduct)

<!-- vim-markdown-toc -->

## Installation

Take care to install this tool in the Puppet envrionment.  If you are using the AIO package, you can install with:

```
/opt/puppetlabs/puppet/bin/gem install --bindir /opt/puppetlabs/bin motoko
```

Alternatively, you can install using Puppet:

```puppet
package { 'motoko':
  ensure          => 'installed',
  provider        => 'puppet_gem',
  install_options => [
    '--bindir',
    '/opt/puppetlabs/bin',
  ],
}
```

## Usage

Two inventroy scripts are currently provided:

* `exe/inventory` use Choria discovery and return live data from your infrastructure;
* `exe/pdb-inventory` use PuppetDB querying and return what Puppet thinks about your infrastructure.

Both have a similar feature-set, and a full list of available options can be obtained by running them with `--help`.

### Basic usage

#### Which nodes are currently up and running

```sh-session
romain@zappy ~ % inventory
```

#### Which nodes are known to puppet

```sh-session
romain@zappy ~ % pdb-inventory
```

### Accessing facts

By default, the report display the node name, along with it's `customer` and `role` facts (if these facts are available).  You can request additional facts are just replace the list.  The syntax is the same for both the choria and puppetdb inventory scripts.

#### Add more facts to the output

```sh-session
romain@zappy ~ % inventory -a datacenter,city,country
```

### Filtering

The usual filtering knobs are available for the choria inventory script.  The puppetdb inventory script has a minimal support for choria-like filtering.

#### Which nodes have burned in Strasbourg

The initial work on querying PuppetDB is due to the fact that you can't ask Choria for information about nodes which are gone.  On March 9th 2021, [OVH lost (part of) it's Strasboug datacenter](https://twitter.com/olesovhcom/status/1369478732247932929?ref_src=twsrc%5Etfw) and the frustration of not being able to conviniently build a list of affected nodes and customers was a pain. with motoko we can now just query PuppetDB:

```sh-session
romain@zappy ~ % pdb-inventory -F datacenter=/sbg/
```
## Configuration

At startup, Motoko will load system-wide configuration from `/etc/motoko/config.yaml`, and then user configuration from `~/.config/motoko/config.yaml`.

### Columns

Set the list of columns to display by default:

```yaml
columns:
  - "host"
  - "customer"
  - "role"
  - "country"
  - "city"
```

### Column Specifications

Customize how columns are displayed:

* `human_name`: what title should be used for the column (defaults to a capitalized version of the column name);
* `resolver`: which [resolver](#resolvers) to use to gather the information (defaults to `fact`);
* `formatter`: which [formatter](#formatters) to use to print the value (none by default);
* `align`: how to align the formatted value in the column (default to `left`).

```yaml
columns_spec:
  host:
    resolver: "identity"
  customer:
    formatter: "ellipsis"
    max_length: 20
  cpu:
    resolver: "cpu"
  os:
    human_name: "Operating System"
    resolver: "os"
  reboot_required:
    human_name: "R"
    resolver: "reboot_required"
    formatter: "boolean"
```

### Shortcuts

```yaml
shortcuts:
  dc:
    description: "Show physical node locations"
    add_columns:
      - "datacenter"
      - "server_rack"
      - "server_id"
    with_fact:
      - "virtual=physical"
```

This add a new command switch `--dc` equivalent to `--add-columns datacenter,server_rack,server_id --with-fact virtual=physical`.

## Resolvers

| Resolver name     | Desciption |
|-------------------|------------|
| `cpu`             | Aggregate information about the CPU |
| `fact`            | Gather the value of the fact `fact` (default to the column name if unset) |
| `identity`        | Gather the node identity |
| `os`              | Aggregate information about the OS |
| `reboot_required` | Combine value of various facts to determine if a reboot is required |

### Extending Motoko with custom resolvers

Custom resolvers can be droped in the `<motoko-config-directory>/resolvers/` directory.  They are automatically loaded on startup.

## Formatters

| Formatter name  | Desciption |
|-----------------|------------|
| `boolean`       | Display a checkmark for things that evaluate to `true` |
| `datetime`      | Display a date and time in the local time zone |
| `datetime_ago`  | Display a date and time as a duration |
| `ellipsis`      | Display a value truncated at `max_length` chars (default: 20) |
| `timestamp`     | Display a timestamp (number of seconds since the Unix epoch) in the local time zone |
| `timestamp_ago` | Display a timestamp (number of seconds since the Unix epoch) as a duration |

### Extending Motoko with custom formatters

Custom formatters can be droped in the `<motoko-config-directory>/formatters/` directory.  They are automatically loaded on startup.

## Development

In order to use the Puppet environment, use the version of bundler bundled with Puppet:

```
/opt/puppetlabs/puppet/bin/bundle install
/opt/puppetlabs/puppet/bin/bundle exec rake spec
/opt/puppetlabs/puppet/bin/bundle exec exe/inventory
```

Iy you want to install this development code:

```
/opt/puppetlabs/puppet/bin/gem build motoko.gemspec
sudo /opt/puppetlabs/puppet/bin/gem install --bindir /opt/puppetlabs/bin motoko-x.y.z.gem
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smortex/motoko. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/smortex/motoko/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Motoko project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/smortex/motoko/blob/master/CODE_OF_CONDUCT.md).
