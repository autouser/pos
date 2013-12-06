package test_db;

if (-e 'pos_test.db') {
  system('rm pos_test.db');
}

system('sqlite3 pos_test.db < ./share/schema.sql');
$ENV{TEST_DSN} = 'dbi:SQLite:dbname=pos_test.db'; 

1;