# App

A description

## Development

To set up

    gem install bundler
    bundle install

To run

    rake server

To change the port number, run

   rake server[8888]

To run on a local ip address (eg, to test on an external device), run

   rake server[7770,true]

where the first parameter is the port number.