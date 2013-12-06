#!/bin/sh

./script/pos_create.pl model POSDB DBIC::Schema POS::Schema::POSDB create=static dbi:SQLite:dbname=pos.db