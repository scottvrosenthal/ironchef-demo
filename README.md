# ironchef-demo

This is an ec2 demo using the [iron_chef](https://github.com/scottvrosenthal/iron_chef) gem.

Demo has examples of:

  - how the `iron_chef` gem makes it to automate sever setups with chef solo
  - update & install yum packages for base server setups
  - set up the nginx repo and installs nginx from the repo
  - uses nodes and roles to show the flexiblity

You'll need the following to actually run the demo:

  - an aws account (it's free)
  - ec2 security key (pem file) that you create in the aws ec2 console
  - a running Amazon 2013 AMI Linux instance (t1.micro)

Once you have the instance up and running and your pem downloaded:

  - read the `config/deploy.rb` file and reference your pem file installed on the ec2 instance
  - update `nodes/staging-web1.yml` with the dns of the ec2 instance created
  - next run `cap staging-web1 bootstrap:chef`
  - now run `cap staging-web1 chef:apply`

If everything went as planned you should have an updated ec2 instance with nginx installed.
