# Inventory

A gem to get inventories of nodes in a Puppet / Choria deployment.

*THIS IS CURRENTLY A WIP AND WILL BURN YOUR NODES*

Please expect quite a lot of changes with this code, I think it will be split in 3 gems at the end, and none of them will be called `inventory`.

## Installation

Do not install this for now.  Just clone the repo, `bundle install` and `bundle exec ./exe/...`…

## Usage

Two inventroy scripts are currently provided:

* `exe/inventory` use Choria discovery and return live data from your infrastructure;
* `exe/pdb-inventory` use PuppetDB querying and return what Puppet thinks about your infrastructure.

Both have a similar feature-set, and a full list of available options can be obtained by running them with `--help`.

### Basic usage

#### Which nodes are currently up and running

```sh-session
romain@zappy inventory % bundle exec ./exe/inventory
```

#### Which nodes are known to puppet

```sh-session
romain@zappy inventory % bundle exec ./exe/pdb-inventory
```

### Accessing facts

By default, the report display the node name, along with it's `customer` and `role` facts (if these facts are available).  You can request additional facts are just replace the list.  The syntax is the same for both the choria and puppetdb inventory scripts.

#### Add more facts to the output

```sh-session
romain@zappy inventory % bundle exec ./exe/inventory -a datacenter,city,country
```

### Filtering

The usual filtering knobs are available for the choria inventory script.  The puppetdb inventory script has a minimal support for choria-like filtering.

#### Which nodes have burned in Strasbourg

```sh-session
romain@zappy inventory % bundle exec ./exe/pdb-inventory -F datacenter=/sbg/
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/smortex/inventory. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/smortex/inventory/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Inventory project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/smortex/inventory/blob/master/CODE_OF_CONDUCT.md).
