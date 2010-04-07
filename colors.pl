#!/usr/bin/perl

#use Term::ANSIColor qw(:constants :colored);
use Term::ANSIColor;
local $Term::ANSIColor::AUTORESET = 1;

print colored("Hello hello hello\n", 'blue');

print WHITE ON_BLUE "hello\n";
print RESET CLEAR;

print %attributes;
%attr = %Term::ANSIColor::attributes;
foreach $col (keys(%attr)){
    print RESET;
    if($col =~ /^on/){
      print eval(uc($col)),  "C: $col\n";
    }else{
      print eval(uc($col)),  "C: $col\n";
    }
    print RESET;
}


print "\n";

print "Hello hello hello\n";
print colored("Hello hello hello\n", 'blue');

