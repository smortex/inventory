# Inventory

A gem to get inventories of nodes in a Puppet / Choria deployment.

*THIS IS CURRENTLY A WIP AND WILL BURN YOUR NODES*

Please expect quite a lot of changes with this code, I think it will be split in 3 gems at the end, and none of them will be called `inventory`.

## Development

In order to use the Puppet envrionment, use the version of bundler bundled with Puppet:

```
/opt/puppetlabs/puppet/bin/bundle install
/opt/puppetlabs/puppet/bin/bundle exec rake spec
/opt/puppetlabs/puppet/bin/bundle exec exe/inventory
```

## Installation

Take care to install this tool in the Puppet envrionment.  If you are using the AIO package, you can build and install like this:

```
/opt/puppetlabs/puppet/bin/gem build inventory.gemspec
sudo /opt/puppetlabs/puppet/bin/gem install --bindir /opt/puppetlabs/bin inventory-x.y.z.gem
```

## Usage

Two inventroy scripts are currently provided:

* `exe/inventory` use Choria discovery and return live data from your infrastructure;
* `exe/pdb-inventory` use PuppetDB querying and return what Puppet thinks about your infrastructure.

Both have a similar feature-set, and a full list of available options can be obtained by running them with `--help`.

### Basic usage

#### Which nodes are currently up and running

```sh-session
romain@zappy inventory % inventory
```

#### Which nodes are known to puppet

```sh-session
romain@zappy inventory % pdb-inventory
```

### Accessing facts

By default, the report display the node name, along with it's `customer` and `role` facts (if these facts are available).  You can request additional facts are just replace the list.  The syntax is the same for both the choria and puppetdb inventory scripts.

#### Add more facts to the output

```sh-session
romain@zappy inventory % inventory -a datacenter,city,country
```

### Filtering

The usual filtering knobs are available for the choria inventory script.  The puppetdb inventory script has a minimal support for choria-like filtering.

#### Which nodes have burned in Strasbourg

```sh-session
romain@zappy inventory % pdb-inventory -F datacenter=/sbg/
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smortex/inventory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/smortex/inventory/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Inventory project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/smortex/inventory/blob/master/CODE_OF_CONDUCT.md).
