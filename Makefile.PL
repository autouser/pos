#!/usr/bin/env perl
# IMPORTANT: if you delete this file your app will not work as
# expected.  You have been warned.
use inc::Module::Install 1.02;
use Module::Install::Catalyst; # Complain loudly if you don't have
                               # Catalyst::Devel installed or haven't said
                               # 'make dist' to create a standalone tarball.

name 'POS';
all_from 'lib/POS.pm';

requires 'Catalyst::Runtime' => '5.90042';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'HTTP::Server::Simple::CGI';
requires 'Moose';
requires 'namespace::autoclean';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
requires 'Catalyst::Model::DBIC::Schema';
requires 'DBD::SQLite';
requires 'Catalyst::View::TT';
requires 'Text::CSV';
requires 'Catalyst::Plugin::Session';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'MooseX::MarkAsMethods';
requires 'MooseX::NonMoose';
requires 'Starman';

test_requires 'Test::More' => '0.88';
test_requires 'Test::WWW::Mechanize::Catalyst';
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
